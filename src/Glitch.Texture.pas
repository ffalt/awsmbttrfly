unit Glitch.Texture;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL;

type
  TTextureIndex = record
    index: integer;
    First: integer;
    Last: integer;
    function Next: integer;
    procedure Reset;
  end;

  TBaseTextures = class
  protected
    function LoadRes(const AResID: integer; var AWidth, AHeight: integer): Cardinal;
    function LoadFromFile(const AFilename: string; var AWidth, AHeight: integer): Cardinal;
  public
    Current: TTextureIndex;
  end;

  TTextures = class(TBaseTextures)
  private
    FTextures: array of gluInt;
    FSize: single;
    procedure Clear;
    procedure Add(Texture: gluInt);
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddFromFilename(const AFilename: string);
    procedure AddFromRes(const AResID: integer);
    procedure Render(const AIndex: integer; const AFlip: boolean);
    property Count: integer read GetCount;
    property Size: single read FSize write FSize;
  end;

type
  TIndexCoordinates = record
    Left: single;
    Right: single;
    Top: single;
    Bottom: single;
    procedure Fill(const AIndex, ARows, ACols: integer; const APartw, AParth: single);
  end;

  TIndexCoordinatesArray = array of TIndexCoordinates;

  TTextureMap = class(TBaseTextures)
  private
    FTexture: gluInt;
    FLoaded: boolean;
    FRows, FCols: integer;
    Fratio: single;
    FSize, FSizeRatio: single;
    FCoordinates: TIndexCoordinatesArray;
    procedure Clear;
    procedure SetSize(const Value: single);
    procedure InitMap(const AWidth, AHeight, ARows, ACols, AMins: integer; const ASize: single);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Bind;
    procedure LoadFromRes(const AResID, ARows, ACols, AMins: integer; const ASize: single);
    procedure LoadFromFilename(const AFilename: string; const ARows, ACols, AMins: integer; const ASize: single);
    procedure Render(const AIndex: integer; const AFlip: boolean);
    property Size: single read FSize write SetSize;
    property TextureID: gluInt read FTexture write FTexture;
  end;

implementation

uses
  KOL,
  KOL_gl,
  KOL_glBitmap,
  System.Classes;

{ ------------------------------------------------------------------------------ }

{ TTextureIndex }

{ ------------------------------------------------------------------------------ }

function TTextureIndex.Next: integer;
begin
  result := Index;
  inc(Index);
  if (Index < First) or (Index > Last) then
    Index := First;
end;

{ ------------------------------------------------------------------------------ }

{ TTextures }

{ ------------------------------------------------------------------------------ }

procedure TTextures.Clear;
begin
  if Length(FTextures) > 0 then
  begin
    glDeleteTextures(Length(FTextures), @FTextures[0]);
    SetLength(FTextures, 0);
  end;
end;

{ ------------------------------------------------------------------------------ }

constructor TTextures.Create;
begin
end;

{ ------------------------------------------------------------------------------ }

destructor TTextures.Destroy;
begin
  Clear;
end;

{ ------------------------------------------------------------------------------ }

procedure TTextures.Add(Texture: gluInt);
begin
  SetLength(FTextures, Length(FTextures) + 1);
  FTextures[High(FTextures)] := Texture;
  Current.Last := High(FTextures);
end;

{ ------------------------------------------------------------------------------ }

procedure TTextures.AddFromRes(const AResID: integer);
var
  LWidth, LHeight: integer;
begin
  Add(LoadRes(AResID, LWidth, LHeight));
end;

{ ------------------------------------------------------------------------------ }

procedure TTextures.AddFromFilename(const AFilename: string);
var
  LWidth, LHeight: integer;
begin
  Add(LoadFromFile(AFilename, LWidth, LHeight));
end;

{ ------------------------------------------------------------------------------ }

function TBaseTextures.LoadFromFile(const AFilename: string; var AWidth, AHeight: integer): Cardinal;
var
  LBitmap: TglBitmap2D;
begin
  LBitmap := TglBitmap2D.Create;
  try
    LBitmap.LoadFromFile(AFilename);
    LBitmap.DeleteTextureOnFree := FALSE;
    LBitmap.FreeDataAfterGenTexture := FALSE;
    AWidth := LBitmap.width;
    AHeight := LBitmap.height;
    LBitmap.GenTexture;
    result := LBitmap.ID;
  finally
    LBitmap.Free;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TBaseTextures.LoadRes(const AResID: integer; var AWidth, AHeight: integer): Cardinal;
var
  LBitmap: TglBitmap2D;
begin
  LBitmap := TglBitmap2D.Create;
  try
    LBitmap.LoadFromResourceID(HInstance, AResID, RT_RCDATA);
    LBitmap.DeleteTextureOnFree := FALSE;
    LBitmap.FreeDataAfterGenTexture := FALSE;
    AWidth := LBitmap.width;
    AHeight := LBitmap.height;
    LBitmap.GenTexture;
    result := LBitmap.ID;
  finally
    LBitmap.Free;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TTextures.GetCount: integer;
begin
  result := Length(FTextures);
end;

{ ------------------------------------------------------------------------------ }

procedure TTextures.Render(const AIndex: integer; const AFlip: boolean);
var
  TextureID: DWORD;
begin
  TextureID := FTextures[AIndex];

  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, TextureID); // Bind the Texture to the object

  glBegin(GL_QUADS);
  if (not AFlip) then
  begin
    glEnable(GL_CULL_FACE);
    glNormal3f(0.0, 0.0, 1.0);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(-FSize, -FSize, FSize);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(FSize, -FSize, FSize);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(FSize, FSize, FSize);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(-FSize, FSize, FSize);
  end
  else
  begin
    glDisable(GL_CULL_FACE);
    glNormal3f(0.0, 0.0, 1.0);
    glTexCoord2f(0.0, 0.0);
    glVertex3f(-FSize, -FSize, FSize);
    glTexCoord2f(1.0, 0.0);
    glVertex3f(FSize, -FSize, FSize);
    glTexCoord2f(1.0, 1.0);
    glVertex3f(FSize, FSize, FSize);
    glTexCoord2f(0.0, 1.0);
    glVertex3f(-FSize, FSize, FSize);
  end;

  glEnd();
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureIndex.Reset;
begin
  index := 0;
end;

{ ------------------------------------------------------------------------------ }

{ TTextureMap }

{ ------------------------------------------------------------------------------ }

constructor TTextureMap.Create;
begin
  FTexture := 0;
  FRows := 0;
  FCols := 0;
  FLoaded := FALSE;
  Fratio := 1;
  FSizeRatio := 1;
  FSize := 1;
end;

{ ------------------------------------------------------------------------------ }

destructor TTextureMap.Destroy;
begin
  Clear;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.Bind;
begin
  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, FTexture); // Bind the Texture to the object
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.Clear;
var
  LTextures: array of gluInt;
begin
  if FLoaded then
  begin
    SetLength(LTextures, 1);
    glDeleteTextures(1, @LTextures[0]);
    FLoaded := FALSE;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.InitMap(const AWidth, AHeight, ARows, ACols, AMins: integer; const ASize: single);
var
  i: integer;
  Lpartw, Lparth: single;
begin
  FRows := ARows;
  FCols := ACols;
  Current.Last := (ARows * ACols) - 1 - AMins;
  Fratio := (AWidth / ACols) / (AHeight / ARows);
  FSize := ASize;
  FSizeRatio := ASize * Fratio;
  Lpartw := 1 / FCols;
  Lparth := 1 / FRows;
  FLoaded := true;
  SetLength(FCoordinates, Current.Last + 1);
  for i := 0 to Current.Last do
    FCoordinates[i].Fill(i, FRows, FCols, Lpartw, Lparth);
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.LoadFromFilename(const AFilename: string; const ARows, ACols, AMins: integer; const ASize: single);
var
  LWidth, LHeight: integer;
begin
  FTexture := LoadFromFile(AFilename, LWidth, LHeight);
  InitMap(LWidth, LHeight, ARows, ACols, AMins, ASize);
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.LoadFromRes(const AResID, ARows, ACols, AMins: integer; const ASize: single);
var
  LWidth, LHeight: integer;
begin
  FTexture := LoadRes(AResID, LWidth, LHeight);
  InitMap(LWidth, LHeight, ARows, ACols, AMins, ASize);
end;

{ ------------------------------------------------------------------------------ }

procedure TIndexCoordinates.Fill(const AIndex, ARows, ACols: integer; const APartw, AParth: single);
var
  row, col: integer;
  x, y: single;
begin
  row := AIndex div ACols;
  col := AIndex mod ACols;
  x := APartw * col;
  y := AParth * row;
  Left := x;;
  Right := x + APartw;
  Top := y;
  Bottom := y + AParth;
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.SetSize(const Value: single);
begin
  FSize := Value;
  FSizeRatio := FSize * Fratio;
end;

{ ------------------------------------------------------------------------------ }

procedure TTextureMap.Render(const AIndex: integer; const AFlip: boolean);
var
  LCoords: TIndexCoordinates;
begin
  LCoords := FCoordinates[AIndex];
  if (not AFlip) then
  begin
    glEnable(GL_CULL_FACE);
    glBegin(GL_QUADS);
    glTexCoord2f(LCoords.Right, LCoords.Top);
    glVertex3f(-FSizeRatio, -FSize, FSize);
    glTexCoord2f(LCoords.Left, LCoords.Top);
    glVertex3f(FSizeRatio, -FSize, FSize);
    glTexCoord2f(LCoords.Left, LCoords.Bottom);
    glVertex3f(FSizeRatio, FSize, FSize);
    glTexCoord2f(LCoords.Right, LCoords.Bottom);
    glVertex3f(-FSizeRatio, FSize, FSize);
  end
  else
  begin
    glDisable(GL_CULL_FACE);
    glBegin(GL_QUADS);
    glTexCoord2f(LCoords.Left, LCoords.Top);
    glVertex3f(-FSizeRatio, -FSize, FSize);
    glTexCoord2f(LCoords.Right, LCoords.Top);
    glVertex3f(FSizeRatio, -FSize, FSize);
    glTexCoord2f(LCoords.Right, LCoords.Bottom);
    glVertex3f(FSizeRatio, FSize, FSize);
    glTexCoord2f(LCoords.Left, LCoords.Bottom);
    glVertex3f(-FSizeRatio, FSize, FSize);
  end;
  glEnd();
end;

{ ------------------------------------------------------------------------------ }

// glLineQader(10, V4f(0, 1, 0, 1));
// glLoadIdentity;
// gluLookAt(0, 0, 50, 0, 0, 0, 0, 1, 0);
//
// if uMainApp.isFire then
// SnowFall.FxType := pfxFire
// else
// SnowFall.FxType := pfxSmoke;
//
// glDisable(GL_LIGHTING);
// glEnable(GL_TEXTURE_2D);
// glDepthMask(False);
// SnowFall.Render(0, -20, 10);
// SnowFall.Advance(5);
// glDepthMask(TRUE);
{


  //procedure TSprite.InitOpenGLLight;
  //var
  //  LPos: TV4f;
  //begin
  //  if FLight then
  //  begin
  //    LPos := V4f(0, 50, 100, 1);
  //    glLightfv(GL_LIGHT0, GL_POSITION, @LPos);
  //
  //    glEnable(GL_LIGHT0);
  //    glEnable(GL_LIGHTING);
  //  end
  //  else
  //    glDisable(GL_LIGHTING);
  //end;



  function gluBuild2DMipmaps(Target: GLenum; Components, Width, Height: GLint; Format, aType: GLenum; Data: Pointer): GLint; stdcall; external glu32;
  procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external OpenGL32;
  procedure glDeleteTextures(n: Integer; textures: PGLuint); stdcall; external OpenGL32;
  procedure glCopyTexSubImage2D(Target: GLenum; level, xoffset, yoffset, x, y: GLint; Width, Height: GLsizei); stdcall; external OpenGL32;
  procedure glCopyTexImage2D(Target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width, Height: GLsizei; border: GLint); stdcall; external OpenGL32;
  function v4f(x, y, Z, W: single): TV4f;
  procedure GenerateTextureFormBitmap(hBmp: HBITMAP; var texture: GLuint; const TextureMode: Integer = GL_MODULATE);
  function GenerateTextureFromResourceBitmap(hRes: HInst; ResID: Integer; const TextureMode: Integer = GL_MODULATE): GLuint;

  procedure GenerateTexture(imgWidth, imgHeight: Integer; imageData: Pointer; var texture: GLuint; RGBFormat: Integer; const TextureMode: Integer = GL_MODULATE);

  procedure glQader(size: single; TextureID: DWORD);
  procedure glLineQader(size: single; Color: TV4f);
  procedure glFrame(size: single; TextureID: DWORD);
  procedure glFrame2(const size: single; const TextureID: DWORD; const flip: boolean);

  procedure GenerateTexture(imgWidth, imgHeight: Integer; imageData: Pointer; var texture: GLuint; RGBFormat: Integer; const TextureMode: Integer = GL_MODULATE);
  begin
  glGenTextures(1, texture);
  glBindTexture(GL_TEXTURE_2D, texture);

  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, TextureMode);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, imgWidth, imgHeight, RGBFormat, GL_UNSIGNED_BYTE, imageData);
  end;

  procedure GenerateTextureFormBitmap(hBmp: HBITMAP; var texture: GLuint; const TextureMode: Integer = GL_MODULATE);
  type
  TByteArray = array of byte;
  var
  BitmapLength: LongWord;
  bmpBits: TByteArray;
  bi: tagBITMAP;

  procedure SetAlphaValueTo(pData: Pointer; size: Integer; Alpha: byte);
  asm
  push ebx
  test edx,edx
  jz @@end

  @@loop :
  mov ch, 255
  mov [eax+3],ch

  add eax, 4
  sub edx, 4
  jnle @@loop
  @@end:
  pop ebx
  end;

  begin
  GetObject(hBmp, sizeof(bi), @bi);

  if bi.bmBitsPixel > 1 then
  begin
  BitmapLength := bi.bmWidth * bi.bmHeight * (bi.bmBitsPixel div 8);
  SetLength(bmpBits, BitmapLength + 1);

  GetBitmapBits(hBmp, BitmapLength, @bmpBits[0]);

  if @bmpBits[0] <> nil then
  begin
  // Swap_BGR_To_RGB(bmpBits, Length(bmpBits), 255);
  SetAlphaValueTo(bmpBits, Length(bmpBits), 0);

  GenerateTexture(bi.bmWidth, bi.bmHeight, @bmpBits[0], texture, GL_BGRA);
  end;
  end;
  SetLength(bmpBits, 0);
  end;

  function GenerateTextureFromResourceBitmap(hRes: HInst; ResID: Integer; const TextureMode: Integer = GL_MODULATE): GLuint;
  var
  hBmp: HBITMAP;
  begin
  hBmp := Loadimage(HInstance, MAKEINTRESOURCE(ResID), IMAGE_BITMAP, 0, 0, LR_DEFAULTSIZE);
  GenerateTextureFormBitmap(hBmp, Result, TextureMode);
  DeleteObject(hBmp);
  end;


  procedure glQader(size: single; TextureID: DWORD);
  begin
  glColor4f(0.7, 0.7, 0.7, 1.0);

  glEnable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, TextureID); // Bind the Texture to the object

  glBegin(GL_QUADS);
  // Front Face
  glNormal3f(0.0, 0.0, 1.0);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(-size, -size, size);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(size, -size, size);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(size, size, size);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(-size, size, size);

  // Back Face
  glNormal3f(0.0, 0.0, -1.0);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(-size, -size, -size);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(-size, size, -size);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(size, size, -size);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(size, -size, -size);

  // Top Face
  glNormal3f(0.0, 1.0, 0.0);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(-size, size, -size);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(-size, size, size);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(size, size, size);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(size, size, -size);

  // Bottom Face
  glNormal3f(0.0, -1.0, 0.0);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(-size, -size, -size);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(size, -size, -size);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(size, -size, size);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(-size, -size, size);

  // Right face
  glNormal3f(1.0, 0.0, 0.0);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(size, -size, -size);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(size, size, -size);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(size, size, size);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(size, -size, size);

  // Left Face
  glNormal3f(-1.0, 0.0, 0.0);
  glTexCoord2f(0.0, 0.0);
  glVertex3f(-size, -size, -size);
  glTexCoord2f(1.0, 0.0);
  glVertex3f(-size, -size, size);
  glTexCoord2f(1.0, 1.0);
  glVertex3f(-size, size, size);
  glTexCoord2f(0.0, 1.0);
  glVertex3f(-size, size, -size);
  glEnd();
  end;

  procedure glLineQader(size: single; Color: TV4f);
  begin
  glColor4fv(@Color);
  glDisable(GL_LIGHTING);
  glDisable(GL_TEXTURE_2D);
  glBegin(GL_LINE_STRIP);
  glVertex3f(-size, size, -size); // Top
  glVertex3f(size, size, -size);
  glVertex3f(size, size, size);
  glVertex3f(-size, size, size);
  glVertex3f(-size, size, -size);

  glVertex3f(-size, -size, -size); // toBottom

  glVertex3f(size, -size, -size); // Bottom
  glVertex3f(size, -size, size);
  glVertex3f(-size, -size, size);
  glVertex3f(-size, -size, -size);
  glEnd();

  glBegin(GL_LINES);
  glVertex3f(-size, size, size);
  glVertex3f(-size, -size, size);
  glEnd();

  glBegin(GL_LINES);
  glVertex3f(size, size, size);
  glVertex3f(size, -size, size);
  glEnd();

  glBegin(GL_LINES);
  glVertex3f(size, size, -size);
  glVertex3f(size, -size, -size);
  glEnd();

  glEnable(GL_TEXTURE_2D);
  glEnable(GL_LIGHTING);
  end;


}

end.
