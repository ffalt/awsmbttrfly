unit Glitch.Application;

{
  //Ideen

  Flug-Geschwindigkeit einstellen/random
  Flügel-Geschwindigkeit einstellen/random
  Cursor folgen
  Massieren (ani)
  Melken (ani)
  Sprechblase

}

{$IFDEF ALLINONE}
{$R 'Bttrfly.res' 'resources\Bttrfly.rc'}
{$ENDIF}
{$R 'Bttrfly_Base.res' 'resources\Bttrfly_Base.rc'}

interface

uses
  kol,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  KOL_Png,
  Glitch.Consts,
  Glitch.Sprite,
  Glitch.Utils.IntHash;

type
  TApp = class
  private
    FAllowedArea: TRect;
    FAutoFly: boolean;
    FDefaultDragable: boolean;
    FDefaultOnTop: boolean;
    FDefaultSize: TSpriteSize;
    FDrawObjs: TIntegerHash;
    FLastPopupItemHWND: HWND;
    FMainHWND: HWND;
    FPopupMenuHWnd: HWND;
    FResourcePath: string;
    FShellIcon: TNotifyIconData;
    function GetLastPopupDrawObjOrLast: TSprite;
    function GetSettingsDragable: boolean;
    function GetSettingsOnTop: boolean;
    function GetSettingsSize: TSpriteSize;
    procedure AddDrawObj(const AObj: TSprite);
    procedure CloseDrawObj(const ADrawObj: TSprite);
    procedure CreateTrayIcon(const AHWND: HWND);
    procedure GiveMilk(ADrawObj: TSprite);
    procedure ReadSettings;
    procedure SaveSettings;
    procedure SetSettingsAutoFly(const AValue: boolean);
    procedure SetSettingsDragable(const AValue: boolean);
    procedure SetSettingsOnTop(const AValue: boolean);
    procedure SetSettingsSize(const AValue: TSpriteSize);
    procedure Nibble(ADrawObj: TSprite);
  public
    constructor Create;
    function HitTest(const AHWND: HWND): boolean;
    procedure BringToFront;
    procedure Click(const AHWND: HWND);
    procedure ClickTrayIcon(const AHWND: HWND);
    procedure CreateMainWindow;
    procedure CreateObject(const AClass: TGLObjectDrawClass; const AX: integer = -1; const AY: integer = -1);
    procedure Deinit(const AHWND: HWND);
    procedure DoubleClick(const AHWND: HWND);
    procedure Drag(const AHWND: HWND);
    procedure Drop(const AHWND: HWND);
    procedure ExecuteCmd(const AHWND: HWND; const ACMD: SmallInt);
    procedure Hover(const AHWND: HWND; const AStart: boolean);
    procedure Paint(AHWND: HWND);
    procedure SetTrayIcon(const AHint: string; const Update: boolean);
    procedure ShowPopup(const AHWND: HWND; const isTrayIcon: boolean = false);
    procedure Start;
    procedure TimerMove(const AHWND: HWND);
    procedure TimerRender(const AHWND: HWND);
    property MainHWND: HWND read FMainHWND write FMainHWND;
    property SettingsAutoFly: boolean read FAutoFly write SetSettingsAutoFly;
    property SettingsDragable: boolean read GetSettingsDragable write SetSettingsDragable;
    property SettingsOnTop: boolean read GetSettingsOnTop write SetSettingsOnTop;
    property SettingsSize: TSpriteSize read GetSettingsSize write SetSettingsSize;
  end;

var
  App: TApp;

implementation

uses
  Glitch.Sprite.Butterfly,
  Glitch.Sprite.Milk,
  Glitch.Sprite.Piggy,
  Glitch.Sprite.Kitty,
  Glitch.Sprite.Caterpillar,
  Glitch.Sprite.Piglet,
  Glitch.Sound,
  Glitch.Utils,
  Glitch.Dialog;

var
  SpriteClasses: array [0 .. 4] of TGLObjectDrawClass = //
    (
    TButterfly,
    TKitty,
    TPiggy,
    TPiglet,
    TCaterpillar
  );

  { ------------------------------------------------------------------------------ }

function GetRandomHint: string;
const
  cText: array [0 .. 6] of string = ( //
    'Ɛ(｡˘v˘｡)3', //
    'Ɛ(˘ .˘)3', //
    'Ɛ(ノ˘v˘)ノ彡', //
    'Ɛ(˘ ³˘)3', //
    'Ɛ(☌.☌)3', //
    'Ɛ(^o^)3', //
    'Ɛ(♥ω♥)3' //
    // 'MÖÖÖÖLX', //
    // 'U needs milx!',
    // 'I HAZ MILX 4U',
    // 'i haz milx! ',
    // 'U <3 milx? I <3 u!!!'
    );

begin
  Result := cText[Random(Length(cText))];
end;

{ ------------------------------------------------------------------------------ }

constructor TApp.Create;
var
  abd: TAppBarData;
begin
  FResourcePath := ExtractFilePath(ParamStr(0)) + 'images/';
  Glitch.Sound.SoundPath := ExtractFilePath(ParamStr(0)) + 'sounds/';
  // OutputDebugString(PChar(FResourcePath));
  FAutoFly := True;
  FDefaultOnTop := True;
  FDefaultDragable := True;
  FDefaultSize := cNormal;
  FDrawObjs := TIntegerHash.Create;
  GetWindowRect(GetDesktopWindow, FAllowedArea);

  FillChar(abd, SizeOf(TAppBarData), 0);
  abd.cbSize := SizeOf(TAppBarData);
  SHAppBarMessage(ABM_GETTASKBARPOS, abd);

  case abd.uEdge of
    ABE_LEFT:
      FAllowedArea.Left := FAllowedArea.Left + abd.rc.Width;
    ABE_RIGHT:
      FAllowedArea.Right := FAllowedArea.Right - abd.rc.Width;
    ABE_TOP:
      FAllowedArea.Top := FAllowedArea.Top + abd.rc.Height;
    ABE_BOTTOM:
      FAllowedArea.Bottom := FAllowedArea.Bottom - abd.rc.Height;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.CreateTrayIcon(const AHWND: HWND);
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Creating TrayIcon');
{$ENDIF}
  SetTrayIcon(GetRandomHint, false);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.CreateMainWindow;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('CreateMainWindow');
{$ENDIF}
  FMainHWND := CreateWindowEx(WS_EX_TOOLWINDOW, PChar(Global_wndMainClassName), PChar(Global_wndTitle), WS_POPUP, 0, 0, 100, 100, 0, 0, hInstance, nil);
  createMenu;
  CreateTrayIcon(FMainHWND);
{$IFDEF DEBUG}
  Glitch.Utils.Log('Init Timer');
{$ENDIF}
  ReadSettings;
  SetTimer(FMainHWND, ID_TIMER_DRAW, TIMERINTERVAL_DRAW, nil);
  SetTimer(FMainHWND, ID_TIMER_MOVE, TIMERINTERVAL_MOVE, nil);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.ReadSettings;
var
  hOpenKey: HKEY;
  iI, iSize, iType: integer;
begin
  if RegOpenKeyEx(HKEY_CURRENT_USER, 'Software\AwsmBttrfly', 0, KEY_READ, hOpenKey) = ERROR_SUCCESS then
  begin
    // Reading an Integer value
    iType := REG_DWORD; // Type of data that is going to be read
    iSize := SizeOf(integer); // Buffer for the value to read
    if RegQueryValueEx(hOpenKey, 'OnTop', nil, @iType, @iI, @iSize) = ERROR_SUCCESS then
      FDefaultOnTop := iI <> 1;
    if RegQueryValueEx(hOpenKey, 'Pilot', nil, @iType, @iI, @iSize) = ERROR_SUCCESS then
      FAutoFly := iI <> 1;
    if RegQueryValueEx(hOpenKey, 'Mouse', nil, @iType, @iI, @iSize) = ERROR_SUCCESS then
      FDefaultDragable := iI <> 1;
    if RegQueryValueEx(hOpenKey, 'Size', nil, @iType, @iI, @iSize) = ERROR_SUCCESS then
      if iI = 1 then
        FDefaultSize := cSmall;
    // // Reading a string value
    // if RegQueryValueEx(hOpenKey, 'String Value', nil, @iType, pcTemp, @iSize) = ERROR_SUCCESS then
    // MainForm.Caption := string(pcTemp);
    RegCloseKey(hOpenKey);
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.SaveSettings;
var
  hOpenKey: HKEY;
  iI: integer;
  pdI: PDWORD;
begin
  pdI := nil;
  if RegCreateKeyEx(HKEY_CURRENT_USER, 'Software\AwsmBttrfly', 0, nil, REG_OPTION_NON_VOLATILE, KEY_WRITE, nil, hOpenKey, pdI) = ERROR_SUCCESS then
  begin
    iI := IfThenElse(0, 1, FDefaultOnTop);
    RegSetValueEx(hOpenKey, 'OnTop', 0, REG_DWORD, @iI, SizeOf(iI));
    iI := IfThenElse(0, 1, FAutoFly);
    RegSetValueEx(hOpenKey, 'Pilot', 0, REG_DWORD, @iI, SizeOf(iI));
    iI := IfThenElse(0, 1, FDefaultDragable);
    RegSetValueEx(hOpenKey, 'Mouse', 0, REG_DWORD, @iI, SizeOf(iI));
    iI := IfThenElse(0, 1, FDefaultSize = cNormal);
    RegSetValueEx(hOpenKey, 'Size', 0, REG_DWORD, @iI, SizeOf(iI));
    // // Saving a string value
    // RegSetValueEx(hOpenKey, 'String Value', 0, REG_SZ, PChar(MainForm.Caption), Length(MainForm.Caption) + 1); // The 1 is for the terminating 0 (PChar)
    RegCloseKey(hOpenKey); // Close the open registry key
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.AddDrawObj(const AObj: TSprite);
begin
  FDrawObjs.SetValue(AObj.HWND, AObj);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.CreateObject(const AClass: TGLObjectDrawClass; const AX: integer = -1; const AY: integer = -1);
var
  LGLObjectDraw: TGLObjectDraw;
  p: TPoint;
  LDrawObj: TSprite;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Creating ' + AClass.ClassName);
{$ENDIF}
  LGLObjectDraw := AClass.Create;
  if (AX >= 0) and (AX >= 0) then
  begin
    p.X := AX;
    p.Y := AY;
    LGLObjectDraw.SetStartPos(p);
  end;
  LDrawObj := TSprite.Create(FAllowedArea, LGLObjectDraw, GetSettingsOnTop, FResourcePath);
  AddDrawObj(LDrawObj);
  LGLObjectDraw.Size := GetSettingsSize;
  LDrawObj.isDragable := GetSettingsDragable;
  LDrawObj.Show;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.CloseDrawObj(const ADrawObj: TSprite);
var
  LHWND: HWND;
begin
  if not Assigned(ADrawObj) then
    Exit;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Removing ' + ADrawObj.Obj.ClassName);
{$ENDIF}
  LHWND := ADrawObj.HWND;
  FDrawObjs.remove(LHWND);
  ADrawObj.Free;
  DestroyWindow(LHWND);
end;

{ ------------------------------------------------------------------------------ }

function TApp.GetLastPopupDrawObjOrLast: TSprite;
begin
  Result := TSprite(FDrawObjs.Values[FLastPopupItemHWND]);
  if not Assigned(Result) and (FDrawObjs.Count >= 0) then
    Result := TSprite(FDrawObjs.ValueAtPos(FDrawObjs.Count - 1));
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Deinit(const AHWND: HWND);
var
  i: integer;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Kill Timer');
{$ENDIF}
  KillTimer(AHWND, ID_TIMER_DRAW);
  KillTimer(AHWND, ID_TIMER_MOVE);
{$IFDEF DEBUG}
  Glitch.Utils.Log('Kill All');
{$ENDIF}
  for i := FDrawObjs.Count - 1 downto 0 do
    FDrawObjs.ValueAtPos(i).Free;
  FDrawObjs.Free;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Destroy TrayIcon');
{$ENDIF}
  Shell_NotifyIcon(NIM_DELETE, @FShellIcon);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.TimerMove(const AHWND: HWND);
var
  i: integer;
begin
  if (FAutoFly) then
    for i := 0 to FDrawObjs.Count - 1 do
      TSprite(FDrawObjs.ValueAtPos(i)).Move;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.TimerRender(const AHWND: HWND);
var
  i: integer;
begin
  for i := 0 to FDrawObjs.Count - 1 do
    TSprite(FDrawObjs.ValueAtPos(i)).RenderNextOpenGL;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Paint(AHWND: HWND);
begin
  TSprite(FDrawObjs.Values[AHWND]).Paint;
end;

{ ------------------------------------------------------------------------------ }

function TApp.HitTest(const AHWND: HWND): boolean;
begin
  Result := TSprite(FDrawObjs.Values[AHWND]).isDragable
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.SetTrayIcon(const AHint: string; const Update: boolean);
begin
  FShellIcon.cbSize := System.SizeOf(TNotifyIconData);
  FShellIcon.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP or NIF_INFO;
  FShellIcon.uCallbackMessage := WM_TRAYEVENT;
  FShellIcon.uID := $0815;
  FShellIcon.hIcon := LoadImage(hInstance, MAKEINTRESOURCE(1), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
  lStrCpy(FShellIcon.szTip, PChar(Global_wndTitle));
  lStrCpy(FShellIcon.szInfo, PChar(AHint));
  lStrCpy(FShellIcon.szInfoTitle, PChar(Global_Lang.getVersionTitle));
  FShellIcon.Wnd := FMainHWND;
  if not Update then
    Shell_NotifyIcon(NIM_ADD, @FShellIcon)
  else
    Shell_NotifyIcon(NIM_MODIFY, @FShellIcon);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.ClickTrayIcon(const AHWND: HWND);
begin
  SetTrayIcon(GetRandomHint, True);
  BringToFront;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Drag(const AHWND: HWND);
begin
  TSprite(FDrawObjs.Values[AHWND]).Drag;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Drop(const AHWND: HWND);
begin
  TSprite(FDrawObjs.Values[AHWND]).Drop;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Hover(const AHWND: HWND; const AStart: boolean);
begin
  TSprite(FDrawObjs.Values[AHWND]).Hover(AStart);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.ExecuteCmd(const AHWND: HWND; const ACMD: SmallInt);
begin
  case ACMD of
    MENU_CLOSE:
      PostMessage(FMainHWND, WM_CLOSE, 0, 0);
    MENU_SING:
      begin
        Glitch.Sound.Play(cpLa);
      end;
    MENU_MASSAGE:
      begin
        Glitch.Sound.Play(cpAhh);
      end;
    MENU_NIBBLE:
      begin
        Nibble(GetLastPopupDrawObjOrLast);
      end;
    MENU_Milk:
      begin
        GiveMilk(GetLastPopupDrawObjOrLast);
      end;
    MENU_REMOVE:
      begin
        CloseDrawObj(GetLastPopupDrawObjOrLast);
      end;
    MENU_DIALOG:
      Glitch.Dialog.ShowDialog;
  else
    begin
      if (MENU_ADD_Base <= ACMD) and (ACMD <= (MENU_ADD_Base + High(SpriteClasses))) then
        CreateObject(SpriteClasses[ACMD - MENU_ADD_Base]);
    end;
  end;
  DeleteObject(FPopupMenuHWnd);
  FPopupMenuHWnd := 0;
  FLastPopupItemHWND := 0;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.GiveMilk(ADrawObj: TSprite);
var
  X, Y: integer;
begin
  X := -1;
  Y := -1;
  if Assigned(ADrawObj) then
  begin
    X := ADrawObj.X;
    Y := ADrawObj.Y;
  end;
  CreateObject(TMilk, X, Y);
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.ShowPopup(const AHWND: HWND; const isTrayIcon: boolean = false);
var
  p: TPoint;
  LDrawObj: TSprite;
  LMenu: HMENU;
  i: integer;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Creating PopupMenu');
{$ENDIF}
  if FPopupMenuHWnd > 0 then
    DeleteObject(FPopupMenuHWnd);
  FLastPopupItemHWND := AHWND;
  FPopupMenuHWnd := CreatePopupMenu();

  LDrawObj := nil;
  if not isTrayIcon then
    LDrawObj := TSprite(FDrawObjs.Values[AHWND]);

  if Assigned(LDrawObj) and (LDrawObj.Obj is TButterfly) then
  begin
    AppendMenu(FPopupMenuHWnd, MF_STRING, MENU_Milk, PChar(Global_Lang.Milk));
    AppendMenu(FPopupMenuHWnd, MF_STRING, MENU_MASSAGE, PChar(Global_Lang.massage));
    AppendMenu(FPopupMenuHWnd, MF_STRING, MENU_SING, PChar(Global_Lang.sing));
    AppendMenu(FPopupMenuHWnd, MF_SEPARATOR, 0, '');
    LMenu := CreatePopupMenu();
    AppendMenu(FPopupMenuHWnd, MF_POPUP, LMenu, PChar('App'));
  end
  else if Assigned(LDrawObj) and (LDrawObj.Obj is TPiggy) then
  begin
    AppendMenu(FPopupMenuHWnd, MF_STRING, MENU_NIBBLE, PChar(Global_Lang.Nibble));
    AppendMenu(FPopupMenuHWnd, MF_SEPARATOR, 0, '');
    LMenu := CreatePopupMenu();
    AppendMenu(FPopupMenuHWnd, MF_POPUP, LMenu, PChar('App'));
  end
  else
    LMenu := FPopupMenuHWnd;
  for i := Low(SpriteClasses) to High(SpriteClasses) do
    AppendMenu(LMenu, MF_STRING, MENU_ADD_Base + i, PChar(Global_Lang.FormatAddSprite(SpriteClasses[i].Name)));
  if Assigned(LDrawObj) then
  begin
    AppendMenu(LMenu, MF_SEPARATOR, 0, '');
    if (LDrawObj.Obj is TMilk) then
      AppendMenu(LMenu, MF_STRING, MENU_REMOVE, PChar(Global_Lang.remove_milk))
    else
      AppendMenu(LMenu, MF_STRING, MENU_REMOVE, PChar(Global_Lang.FormatRemoveSprite(LDrawObj.Obj.Name)));
  end;
  AppendMenu(LMenu, MF_SEPARATOR, 0, '');
  AppendMenu(LMenu, MF_STRING, MENU_DIALOG, PChar(Global_Lang.menu_info));
  AppendMenu(LMenu, MF_SEPARATOR, 0, '');
  AppendMenu(LMenu, MF_STRING, MENU_CLOSE, PChar(Global_Lang.menu_end));
  if Assigned(LDrawObj) then
    SetMenuDefaultItem(LMenu, MENU_CLOSE, 0);
  SetForegroundWindow(AHWND);
  GetCursorPos(p);
  TrackPopupMenu(FPopupMenuHWnd, TPM_RIGHTALIGN or TPM_RIGHTBUTTON, p.X, p.Y, 0, AHWND, nil);
end;

{ ------------------------------------------------------------------------------ }

function TApp.GetSettingsDragable: boolean;
begin
  Result := FDefaultDragable;
end;

{ ------------------------------------------------------------------------------ }

function TApp.GetSettingsOnTop: boolean;
begin
  Result := FDefaultOnTop;
end;

{ ------------------------------------------------------------------------------ }

function TApp.GetSettingsSize: TSpriteSize;
begin
  Result := FDefaultSize;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.SetSettingsSize(const AValue: TSpriteSize);
var
  i: integer;
begin
  if FDefaultSize <> AValue then
  begin
    FDefaultSize := AValue;
    for i := 0 to FDrawObjs.Count - 1 do
      TSprite(FDrawObjs.ValueAtPos(i)).Obj.Size := AValue;
    SaveSettings;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.SetSettingsAutoFly(const AValue: boolean);
begin
  if FAutoFly <> AValue then
  begin
    FAutoFly := AValue;
    SaveSettings;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.SetSettingsDragable(const AValue: boolean);
var
  i: integer;
begin
  if FDefaultDragable <> AValue then
  begin
    FDefaultDragable := AValue;
    for i := 0 to FDrawObjs.Count - 1 do
      TSprite(FDrawObjs.ValueAtPos(i)).isDragable := AValue;
    SaveSettings;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.SetSettingsOnTop(const AValue: boolean);
var
  i: integer;
begin
  if FDefaultOnTop <> AValue then
  begin
    FDefaultOnTop := AValue;
    for i := 0 to FDrawObjs.Count - 1 do
      TSprite(FDrawObjs.ValueAtPos(i)).isOnTop := AValue;
    SaveSettings;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.BringToFront;
var
  i: integer;
begin
  for i := 0 to FDrawObjs.Count - 1 do
    TSprite(FDrawObjs.ValueAtPos(i)).BringToFront;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Nibble(ADrawObj: TSprite);
begin
  if (ADrawObj.Obj is TPiggy) then
  begin
    TPiggy(ADrawObj.Obj).Nibble;
    Glitch.Sound.Play(cpNibble);
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.DoubleClick(const AHWND: HWND);
var
  X, Y: integer;
  LDrawObj: TSprite;
begin
  LDrawObj := TSprite(FDrawObjs.Values[AHWND]);
  if Assigned(LDrawObj) then
    if (LDrawObj.Obj is TButterfly) then
    begin
      Glitch.Sound.Play(cpLa);
    end
    else if (LDrawObj.Obj is TMilk) then
    begin
      CloseDrawObj(LDrawObj);
      Glitch.Sound.Play(cpDrink);
    end
    else if (LDrawObj.Obj is TPiglet) then
    begin
      X := LDrawObj.X;
      Y := LDrawObj.Y - 40;
      CloseDrawObj(LDrawObj);
      Glitch.Sound.Play(cpNibble);
      CreateObject(TPiggy, X, Y);
    end
    else if (LDrawObj.Obj is TPiggy) then
    begin
      Nibble(LDrawObj);
    end
    else if (LDrawObj.Obj is TKitty) then
    begin
      TKitty(LDrawObj.Obj).Turn;
    end
    else if (LDrawObj.Obj is TCaterpillar) then
    begin
      case Random(7) of
        0:
          begin
            X := LDrawObj.X;
            Y := LDrawObj.Y - 40;
            CloseDrawObj(LDrawObj);
            Glitch.Sound.Play(cpBounce);
            CreateObject(TButterfly, X, Y);
          end;
        1, 2, 3:
          begin
            TCaterpillar(LDrawObj.Obj).ToggleFlip;
          end;
      else
        begin
          TCaterpillar(LDrawObj.Obj).Jump;
        end;
      end;
    end;
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Click(const AHWND: HWND);
begin
{$IFDEF DEBUG}
  // CreateObject(TPiggy);
{$ENDIF}
end;

{ ------------------------------------------------------------------------------ }

procedure TApp.Start;
begin
  // CreateObject(TCaterpillar);
  // CreateObject(TPiggy);
  // CreateObject(TKitty);
  // CreateObject(TPiglet);
   CreateObject(TButterfly);
end;

{ ------------------------------------------------------------------------------ }

end.
