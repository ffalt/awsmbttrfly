unit Glitch.Utils;

interface

uses
  Winapi.Windows;

function IsMouseInRect(Handle: HWND; const X, Y, AWidth, AHeight: integer): boolean;
procedure OpenBrowser(const s: string);

{$IFDEF DEBUG}
procedure Log(const s: string);
{$ENDIF}

implementation

uses
{$IFDEF DEBUG}
  System.TypInfo, System.SysUtils,
{$ENDIF}
  Winapi.ShellAPI;

{------------------------------------------------------------------------------}

{$IFDEF DEBUG}

procedure Log(const s: string);
begin
  WriteLn(Output, s);
end;

{$ENDIF}

{------------------------------------------------------------------------------}

procedure OpenBrowser(const s: string);
begin
  ShellExecute(0, 'open', PChar(s), nil, nil, SHOW_OPENWINDOW);
end;

{------------------------------------------------------------------------------}

function IsMouseInRect(Handle: HWND; const X, Y, AWidth, AHeight: integer): boolean;
var
  CurPos: TPoint;
  R: TRect;
begin
  result := false;
  GetCursorPos(CurPos);
  R.Left := X + 20; // TODO magic constant border
  R.Top := Y + 20; // TODO magic constant border
  R.Width := AWidth - 20; // TODO magic constant border
  R.Height := AHeight - 20; // TODO magic constant border
  if PtInRect(R, CurPos) then
  begin
    result := true;
  end;
end;

{------------------------------------------------------------------------------}

end.
