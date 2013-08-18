unit Glitch.Sprite;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Texture, KOL_png;

type
  TSpriteSize = (cNormal, cSmall);

  TGLObjectDraw = class
  protected
    FStartPos: TPoint;
    FSize: TSpriteSize;
    procedure SetSize(const Value: TSpriteSize);
  public
    constructor Create; virtual;
    class function WindowWidth: integer; virtual; abstract;
    class function WindowHeight: integer; virtual; abstract;
    class function Name:string; virtual; abstract;
    procedure SetStartPos(p: TPoint);
    procedure Hover(const AStart: boolean); virtual; abstract;
    procedure UpdateSizeFloat; virtual; abstract;
    procedure InitTextures(const APath: string); virtual; abstract;
    procedure DeInitTextures; virtual; abstract;
    procedure RenderObj; virtual; abstract;
    procedure Drop; virtual; abstract;
    function MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; Area: TRect): boolean; virtual; abstract;
    function StartPos(const AWidth, AHeight: integer; Area: TRect): TPoint; virtual; abstract;
    property Size: TSpriteSize read FSize write SetSize;
  end;

  TGLObjectDrawClass = class of TGLObjectDraw;

  TSpriteBitmap = record
    bi: BITMAPINFO;
    hBmpDC: HDC;
    hBmp: HBitmap;
    pBmpBits: Pointer;
    procedure Init(AWidth, AHeight: integer);
    procedure Deinit;
    function CreateBitmap32(BitmapDC: HDC; Width, Height: integer): HBitmap;
  end;

  TOpenGLContext = class
  private
    hOpenGLDC: HDC;
    hRC: HGLRC;
    procedure SetupOpenGl;
    function OpenOpenGl(AHWnd: HWND; AColorBits: Byte): boolean;
    procedure CloseOpenGL(AHWnd: HWND; AObj: TGLObjectDraw);
    procedure Render(AObj: TGLObjectDraw; AWidth, AHeight: integer; ABitmap: TSpriteBitmap);
  public
    procedure InitOpenGL(AHWnd: HWND; AWidth, AHeight: integer; ABitmap: TSpriteBitmap; AObj: TGLObjectDraw; AResPath: string);
    function MakeCurrentOpenGL: boolean;
    constructor Create;
  end;

  TSprite = class
  private
    FHWnd: HWND;
    FWidth, FHeight: integer;
    FisDragable: boolean;
    FBitmap: TSpriteBitmap;
    FRenderingActive: Bool;
    FFrameRect: TRect;
    FDragging: boolean;
    FObj: TGLObjectDraw;
    FContext: TOpenGLContext;
    function GetIsOnTop: boolean;
    procedure SetIsOnTop(const Value: boolean);
    function GetHeight: integer;
    function GetWidth: integer;
    function CreateWindow(const AWidth, AHeight: integer; AOnTop: boolean): HWND;
    procedure UpdateFrame;
    procedure EndOpenGL;
  protected
    FArea: TRect;
    FwndPosX, FwndPosY: integer;
    procedure MoveWindowTo;
  public
    constructor Create(AArea: TRect; AObj: TGLObjectDraw; AOnTop: boolean; AResPath: string);
    destructor Destroy; override;
    procedure BringToFront;
    procedure Hover(const AStart: boolean); virtual;
    procedure Drag; virtual;
    procedure Show;
    procedure RenderNextOpenGL; virtual;
    procedure Drop; virtual;
    procedure Paint; virtual;
    procedure Move; virtual;
    property X: integer read FwndPosX write FwndPosX;
    property Y: integer read FwndPosY write FwndPosY;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
    property isDragable: boolean read FisDragable write FisDragable;
    property isOnTop: boolean read GetIsOnTop write SetIsOnTop;
    property HWND: HWND read FHWnd;
    property Obj: TGLObjectDraw read FObj;
  end;

implementation

uses
  Glitch.Consts,
  Glitch.Utils,
  KOL_glBitmap,
  KOL_gl,
  KOL;

{ ------------------------------------------------------------------------------ }

{ TSprite }

{ ------------------------------------------------------------------------------ }

constructor TSprite.Create(AArea: TRect; AObj: TGLObjectDraw; AOnTop: boolean; AResPath: string);
var
  LPoint: TPoint;
begin
  FArea := AArea;
  FObj := AObj;
  FHWnd := CreateWindow(AObj.WindowWidth, AObj.WindowHeight, AOnTop);
  FDragging := False;
  FisDragable := true;
  FWidth := GetWidth;
  FHeight := GetHeight;
  SetRect(FFrameRect, 0, 0, FWidth, FHeight);
  LPoint := FObj.StartPos(FWidth, FHeight, FArea);
  FwndPosX := LPoint.X;
  FwndPosY := LPoint.Y;
  FBitmap.Init(FWidth, FHeight);
  FContext := TOpenGLContext.Create;
  FContext.InitOpenGL(FHWnd, FWidth, FHeight, FBitmap, FObj, AResPath);
  RenderNextOpenGL;
  Paint;
  MoveWindowTo;
end;

{ ------------------------------------------------------------------------------ }

destructor TSprite.Destroy;
begin
  EndOpenGL;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.EndOpenGL;
begin
  FContext.CloseOpenGL(FHWnd, FObj);
  if Assigned(FObj) then
    FObj.Free;
  FObj := nil;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.RenderNextOpenGL;
begin
  if not FRenderingActive then
  begin
    FRenderingActive := true;
    FContext.Render(FObj, FWidth, FHeight, FBitmap);
    FRenderingActive := False;
  end;
  UpdateFrame;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.Paint;
var
  ps: PAINTSTRUCT;
  bf: BLENDFUNCTION;
  pt: TPoint;
  sz: TSize;
begin
  BeginPaint(FHWnd, ps);

  pt.X := 0;
  pt.Y := 0;

  sz.cx := self.FWidth;
  sz.cy := self.FHeight;

  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.AlphaFormat := AC_SRC_ALPHA;
  bf.SourceConstantAlpha := 255;

  UpdateLayeredWindow(FHWnd, 0, nil, @sz, self.FBitmap.hBmpDC, @pt, 0, @bf, ULW_ALPHA);

  EndPaint(FHWnd, ps);
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.UpdateFrame;
begin
  InvalidateRect(FHWnd, @FFrameRect, true);
end;

{ ------------------------------------------------------------------------------ }

function TSprite.CreateWindow(const AWidth, AHeight: integer; AOnTop: boolean): HWND;
var
  Flags: Cardinal;
begin
  Flags := WS_EX_LAYERED or WS_EX_TOOLWINDOW;
  if AOnTop then
    Flags := Flags or WS_EX_TOPMOST;
  Result := CreateWindowEx(Flags, PChar(Global_wndClassName), PChar(Global_wndTitle), WS_POPUP, 0, 0, AWidth, AHeight, 0, 0, hInstance, nil);
end;

{ ------------------------------------------------------------------------------ }

function TSprite.GetHeight: integer;
var
  R: TRect;
begin
  GetWindowRect(FHWnd, R);
  Result := R.Height;
end;

{ ------------------------------------------------------------------------------ }

function TSprite.GetWidth: integer;
var
  R: TRect;
begin
  GetWindowRect(FHWnd, R);
  Result := R.Width;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.SetIsOnTop(const Value: boolean);
begin
  if Value <> GetIsOnTop then
    if Value then
      SetWindowPos(FHWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE)
    else
      SetWindowPos(FHWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE)
end;

{ ------------------------------------------------------------------------------ }

function TSprite.GetIsOnTop: boolean;
var
  LExStyle: NativeInt;
begin
  LExStyle := GetWindowLong(FHWnd, GWL_EXSTYLE);
  Result := LongBool(LExStyle and WS_EX_TOPMOST);
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.Show;
begin
  UpdateFrame;
  ShowWindow(FHWnd, SW_NORMAL);
  UpdateWindow(FHWnd);
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.Drag;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Drag');
{$ENDIF}
  FDragging := true;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.Drop;
var
  p: TPoint;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Drop');
{$ENDIF}
  FDragging := False;
  GetCursorPos(p);
  self.X := p.X - (self.Width div 2);
  self.Y := p.Y - (self.Height div 2);
  if Assigned(FObj) then
    FObj.Drop;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.Hover(const AStart: boolean);
begin
  if Assigned(FObj) then
    FObj.Hover(AStart);
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.Move;
begin
  if Assigned(FObj) and (not FDragging) then
    if FObj.MoveObj(FwndPosX, FwndPosY, FHWnd, FWidth, FHeight, FArea) then
      MoveWindowTo;
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.MoveWindowTo;
begin
  MoveWindow(FHWnd, FwndPosX, FwndPosY, FWidth, FHeight, true);
end;

{ ------------------------------------------------------------------------------ }

procedure TSprite.BringToFront;
begin
  // TODO
  if not GetIsOnTop then
  begin
    SetIsOnTop(true);
    SetIsOnTop(False);
  end;
  // SetWindowPos( FHWnd, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or
  // SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_SHOWWINDOW );
end;

{ ------------------------------------------------------------------------------ }

{ TGLObjectDraw }

{ ------------------------------------------------------------------------------ }

constructor TGLObjectDraw.Create;
begin
  FSize := cNormal;
  FStartPos.X := -1;
  FStartPos.Y := -1;
end;

{ ------------------------------------------------------------------------------ }

procedure TGLObjectDraw.SetStartPos(p: TPoint);
begin
  FStartPos := p;
end;

{ ------------------------------------------------------------------------------ }

procedure TGLObjectDraw.SetSize(const Value: TSpriteSize);
begin
  FSize := Value;
  UpdateSizeFloat;
end;

{ ------------------------------------------------------------------------------ }

{ TSpriteBitmap }

{ ------------------------------------------------------------------------------ }

procedure TSpriteBitmap.Deinit;
begin
  if hBmp > 0 then
    DeleteObject(hBmp);
  if hBmpDC > 0 then
    DeleteDC(hBmpDC);
  hBmp := 0;
  hBmpDC := 0;
end;

{ ------------------------------------------------------------------------------ }

procedure TSpriteBitmap.Init(AWidth, AHeight: integer);
begin
  hBmpDC := CreateCompatibleDC(0);
  hBmp := CreateBitmap32(hBmpDC, AWidth, AHeight);
  SelectObject(hBmpDC, hBmp);
end;

{ ------------------------------------------------------------------------------ }

function TSpriteBitmap.CreateBitmap32(BitmapDC: HDC; Width, Height: integer): HBitmap;
begin
  ZeroMemory(@bi, sizeof(BITMAPINFO));
  with bi.bmiHeader do
  begin
    biSize := sizeof(BITMAPINFOHEADER);
    biBitCount := 32;
    biClrImportant := 0;
    biClrUsed := 0;
    biCompression := BI_RGB;
    biWidth := Width;
    biHeight := Height;
    biPlanes := 1;
    biSizeImage := Width * Height * (biBitCount div 8);
  end;
  Result := CreateDIBSection(BitmapDC, bi, DIB_RGB_COLORS, pBmpBits, 0, 0);
end;

{ ------------------------------------------------------------------------------ }

{ TOpenGLContext }

{ ------------------------------------------------------------------------------ }

constructor TOpenGLContext.Create;
begin
end;

{ ------------------------------------------------------------------------------ }

function TOpenGLContext.MakeCurrentOpenGL: boolean;
begin
  Result := False;
  if (hRC > 0) and (hOpenGLDC > 0) then
    if wglMakeCurrent(hOpenGLDC, hRC) then
      Result := true;
end;

{ ------------------------------------------------------------------------------ }

procedure TOpenGLContext.SetupOpenGl;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Setup OpenGl');
{$ENDIF}
  // Grundeigenschaften der Scene:
  glClearColor(0.0, 0.0, 0.0, 0.0); // Bildschirm löschen (schwarz ohne Alphawert !)

  glClearDepth(1.0); // Depth Buffer Setup
  glShadeModel(GL_SMOOTH); // Aktiviert weiches Shading
  glDepthFunc(GL_LESS); // Bestimmt den Typ des Depth Testing
  glEnable(GL_DEPTH_TEST); // Aktiviert Depth Testing

  glEnable(GL_ALPHA_TEST); // Texturen/objecte auf Alphabl. testen
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnable(GL_BLEND); // Alphablend aktivieren

  // Qualitativ bessere Koordinaten Interpolation
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

  glEnable(GL_CULL_FACE);
  glEnable(GL_NORMALIZE);
  glEnable(GL_COLOR_MATERIAL);
end;

{ ------------------------------------------------------------------------------ }

function TOpenGLContext.OpenOpenGl(AHWnd: HWND; AColorBits: Byte): boolean;
var
  pfd: PIXELFORMATDESCRIPTOR;
  PixelFormat: integer;
begin
  Result := False;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Init OpenGl');
{$ENDIF}
  hOpenGLDC := GetDC(AHWnd);

  ZeroMemory(@pfd, sizeof(PIXELFORMATDESCRIPTOR));
  pfd.nSize := sizeof(PIXELFORMATDESCRIPTOR);
  pfd.nVersion := 1;
  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL;
  pfd.iLayerType := PFD_DOUBLEBUFFER;
  pfd.iPixelType := PFD_TYPE_RGBA;
  pfd.cColorBits := AColorBits;
  pfd.cDepthBits := 32;
  pfd.cAlphaBits := 8;

  PixelFormat := ChoosePixelFormat(hOpenGLDC, @pfd);
  if SetPixelFormat(hOpenGLDC, PixelFormat, @pfd) then
  begin
    hRC := wglCreateContext(hOpenGLDC);
    Result := MakeCurrentOpenGL;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TOpenGLContext.InitOpenGL(AHWnd: HWND; AWidth, AHeight: integer; ABitmap: TSpriteBitmap; AObj: TGLObjectDraw; AResPath: string);
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Reinit OpenGL');
{$ENDIF}
  if OpenOpenGl(AHWnd, ABitmap.bi.bmiHeader.biBitCount) then
  begin
    SetupOpenGl;
    if MakeCurrentOpenGL then
    begin
      // opengl
      glViewport(0, 0, AWidth, AHeight);
      glMatrixMode(GL_PROJECTION);
      glLoadIdentity();
      gluPerspective(45.0, AWidth / AHeight, Global_zNear, Global_zFar);
      glMatrixMode(GL_MODELVIEW);
      glLoadIdentity();
      AObj.InitTextures(AResPath);
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TOpenGLContext.CloseOpenGL(AHWnd: HWND; AObj: TGLObjectDraw);
begin
  MakeCurrentOpenGL;
  AObj.DeInitTextures;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Shutdown OpenGl');
{$ENDIF}
  if (hRC <> 0) then
  begin
    wglMakeCurrent(0, 0);
    wglDeleteContext(hRC);
    hRC := 0;
  end;

  if (hOpenGLDC <> 0) then
    ReleaseDC(AHWnd, hOpenGLDC);

  if (hOpenGLDC <> 0) then
  begin
    DeleteDC(hOpenGLDC);
    hOpenGLDC := 0;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TOpenGLContext.Render(AObj: TGLObjectDraw; AWidth, AHeight: integer; ABitmap: TSpriteBitmap);
begin
  wglMakeCurrent(hOpenGLDC, hRC);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity;
  gluLookAt(0, 0, Global_EyeZ, 0, 0, 0, 0, 1, 0);
  glRotatef(180, 0, 0, 1);
  AObj.RenderObj;
  glFlush();
  SwapBuffers(hOpenGLDC);
  glReadBuffer(GL_BACK);
  glReadPixels(0, 0, AWidth, AHeight, GL_BGRA, GL_UNSIGNED_BYTE, ABitmap.pBmpBits);
end;

{ ------------------------------------------------------------------------------ }

end.
