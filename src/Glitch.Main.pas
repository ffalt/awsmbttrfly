unit Glitch.Main;

interface

function WinMain(hInstance: HINST; hPrevInstance: HINST; lpCmdLine: PChar; nCmdShow: Integer): Integer; stdcall;

implementation

uses
  Winapi.Windows,
  Winapi.Messages,
  Glitch.Consts,
  Glitch.Application,
  Glitch.Utils;

var
  mainwc: TWndClassEx;
  wc: TWndClassEx;

  { ------------------------------------------------------------------------------ }

{$EXTERNALSYM InitCommonControls}
procedure InitCommonControls; stdcall; external 'COMCTL32.DLL' name 'InitCommonControls';

{ ------------------------------------------------------------------------------ }

function WndMainProc(AHWND: HWND; uMsg: UINT; wParam: wParam; lParam: lParam): lresult; stdcall;
begin
  Result := 0;
  case uMsg of
    WM_TRAYEVENT:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_TRAYEVENT');
{$ENDIF}
        if (lParam = WM_RBUTTONUP) then
        begin
          App.ShowPopup(AHWND, true);
        end
        else if (lParam = WM_LBUTTONUP) then
        begin
          App.ClickTrayIcon(AHWND);
        end;
      end;
   WM_COMMAND:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc Command');
{$ENDIF}
        App.ExecuteCmd(AHWND, LoWord(wParam));
      end;
   WM_TIMER:
      begin
        if wParam = ID_TIMER_MOVE then
          App.TimerMove(AHWND)
        else if wParam = ID_TIMER_DRAW then
          App.TimerRender(AHWND);
      end;
    WM_DESTROY:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_DESTROY');
{$ENDIF}
        App.Deinit(AHWND);
        App.Free;
        PostQuitMessage(0);
      end;
  else
    Result := DefWindowProc(AHWND, uMsg, wParam, lParam);
  end;
end;

{ ------------------------------------------------------------------------------ }

function WndProc(AHWND: HWND; uMsg: UINT; wParam: wParam; lParam: lParam): lresult; stdcall;
begin
  Result := 0;
  case uMsg of
    WM_PAINT:
      begin
{$IFDEF DEBUG}
        // Glitch.Utils.Log('WndProc Paint');
{$ENDIF}
        App.Paint(AHWND);
      end;
    WM_COMMAND:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc Command');
{$ENDIF}
        App.ExecuteCmd(AHWND, LoWord(wParam));
      end;
    WM_NCMOUSEMOVE:
      begin
        begin
{$IFDEF DEBUG}
          Glitch.Utils.Log('WndProc WM_NCMOUSEMOVE');
{$ENDIF}
          App.Hover(AHWND, true);
        end;
      end;
    WM_NCMOUSELEAVE:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_NCMOUSELEAVE');
{$ENDIF}
        App.Hover(AHWND, false);
      end;
    WM_MOUSELEAVE:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_MOUSELEAVE');
{$ENDIF}
      end;
    WM_MOUSEACTIVATE:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_MOUSEACTIVATE');
{$ENDIF}
      end;
    WM_NCHITTEST:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_NCHITTEST');
{$ENDIF}
        if App.HitTest(AHWND) then
          Result := HTCAPTION;
      end;
    WM_TRAYEVENT:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_TRAYEVENT');
{$ENDIF}
        if (lParam = WM_RBUTTONUP) then
        begin
          App.ShowPopup(AHWND);
        end
        else if (lParam = WM_LBUTTONUP) then
        begin
          App.ClickTrayIcon(AHWND);
        end;
      end;
    WM_EXITSIZEMOVE:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_EXITSIZEMOVE');
{$ENDIF}
        App.Drop(AHWND);
        Result := DefWindowProc(AHWND, uMsg, wParam, lParam);
      end;
    WM_ENTERSIZEMOVE:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_ENTERSIZEMOVE');
{$ENDIF}
        App.Drag(AHWND);
        Result := DefWindowProc(AHWND, uMsg, wParam, lParam);
      end;
    WM_NCLBUTTONDBLCLK:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_NCLBUTTONDBLCLK');
{$ENDIF}
        App.DoubleClick(AHWND);
      end;
    WM_NCLBUTTONDOWN:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_NCLBUTTONDOWN');
{$ENDIF}
        App.Click(AHWND);
        Result := DefWindowProc(AHWND, uMsg, wParam, lParam);
      end;
    WM_NCRBUTTONDOWN:
      begin
{$IFDEF DEBUG}
        Glitch.Utils.Log('WndProc WM_NCRBUTTONDOWN');
{$ENDIF}
        App.ShowPopup(AHWND);
      end;
  else
    Result := DefWindowProc(AHWND, uMsg, wParam, lParam);
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure RegisterWindowClass;
begin
{$IFDEF DEBUG}
  Glitch.Utils.Log('Registering Window Classes');
{$ENDIF}
  with wc do
  begin
    cbSize := SizeOf(TWndClassEx);
    Style := CS_HREDRAW or CS_VREDRAW or CS_DBLCLKS;
    lpfnWndProc := @WndProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hbrBackground := COLOR_BTNFACE + 1;
    lpszMenuName := nil;
    lpszClassName := PChar(Global_wndClassName);
    hIconSm := 0;
    hInstance := hInstance;
    hIcon := 0;
    hCursor := LoadCursor(0, IDC_ARROW);
  end;
  RegisterClassEx(wc);
  with mainwc do
  begin
    cbSize := SizeOf(TWndClassEx);
    Style := CS_HREDRAW or CS_VREDRAW or CS_DBLCLKS;
    lpfnWndProc := @WndMainProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hbrBackground := COLOR_BTNFACE + 1;
    lpszMenuName := nil;
    lpszClassName := PChar(Global_wndMainClassName);
    hIconSm := 0;
    hInstance := hInstance;
    hIcon := 0;
    hCursor := LoadCursor(0, IDC_ARROW);
  end;
  RegisterClassEx(mainwc);
end;

{ ------------------------------------------------------------------------------ }

function WinMain(hInstance: HINST; hPrevInstance: HINST; lpCmdLine: PChar; nCmdShow: Integer): Integer; stdcall;
var
  msg: TMsg;
begin
{$IFDEF DEBUG}
  AllocConsole;
  Glitch.Utils.Log('*****Debug Flight Started*****');
{$ENDIF}
  Randomize;
  InitCommonControls;
  RegisterWindowClass;

  Global_Lang.InitLang;

{$IFDEF DEBUG}
  Glitch.Utils.Log('Creating Window');
{$ENDIF}
  App := TApp.Create;
  App.CreateMainWindow;
  App.Start;

{$IFDEF DEBUG}
  Glitch.Utils.Log('Entering Message Loop');
{$ENDIF}
  while Getmessage(msg, 0, 0, 0) do
  begin
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;

  UnRegisterClass(wc.lpszClassName, hInstance);
  UnRegisterClass(mainwc.lpszClassName, hInstance);

{$IFDEF DEBUG}
  Glitch.Utils.Log('Terminating');
  FreeConsole;
{$ENDIF}
  Result := msg.wParam;
end;

{ ------------------------------------------------------------------------------ }

end.
