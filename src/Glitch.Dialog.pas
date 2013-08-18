unit Glitch.Dialog;

interface

procedure ShowDialog;

implementation

uses
  KOL, Glitch.Application, Glitch.Sprite, Glitch.Utils, KOL_png,
  Winapi.Windows, Glitch.Consts;

var
  FOptionDialog: PControl;
  Fpng: PPngObject;

{------------------------------------------------------------------------------}

procedure OnLabelEnter(Dummy: Pointer; Sender: PControl);
begin
  Sender.Font.Color := clNavy;
end;

{------------------------------------------------------------------------------}

procedure OnLabelLeave(Dummy: Pointer; Sender: PControl);
begin
  Sender.Font.Color := clBlue;
end;

{------------------------------------------------------------------------------}

procedure OnRadioButtonSmallClick(Dummy: Pointer; Sender: PControl);
begin
  if Sender.Checked then
    App.SettingsSize := cSmall;
end;

{------------------------------------------------------------------------------}

procedure OnRadioButtonLargeClick(Dummy: Pointer; Sender: PControl);
begin
  if Sender.Checked then
    App.SettingsSize := cNormal;
end;

{------------------------------------------------------------------------------}

procedure OnCheckButtonAutoPilotClick(Dummy: Pointer; Sender: PControl);
begin
  App.SettingsAutoFly := Sender.Checked;
end;

{------------------------------------------------------------------------------}

procedure OnCheckButtonDragableClick(Dummy: Pointer; Sender: PControl);
begin
  App.SettingsDragable := Sender.Checked;
end;

{------------------------------------------------------------------------------}

procedure OnCheckButtonOnTopClick(Dummy: Pointer; Sender: PControl);
begin
  App.SettingsOnTop := Sender.Checked;
end;

{------------------------------------------------------------------------------}

procedure OnLabelFfaltClick(Dummy: Pointer; Sender: PControl);
begin
  OpenBrowser('https://twitter.com/ffalt');
end;

{------------------------------------------------------------------------------}

procedure OnLabelCCClick(Dummy: Pointer; Sender: PControl);
begin
  OpenBrowser('http://creativecommons.org/licenses/by-nc-sa/3.0/');
end;

{------------------------------------------------------------------------------}

procedure OnLabelTinySpeckClick(Dummy: Pointer; Sender: PControl);
begin
  OpenBrowser('http://tinyspeck.com/');
end;

{------------------------------------------------------------------------------}

procedure OnFormClose(Dummy: Pointer; Sender: PControl);
begin
  FOptionDialog := nil;
end;

{------------------------------------------------------------------------------}

// procedure TestPaintBitmap;
// var
// begin
// {$IFDEF TEST_BMPMEM}
// TransColor := clRed;
// {$ELSE}
// {$ENDIF}
// {$IFDEF TEST_STRETCHDRAW}
// {$IFNDEF TEST_BMPTRANSPARENT}
// Bmp1.SaveToFile('tst5.bmp');
// Bmp1.StretchDraw(PB.Canvas.Handle, PB.ClientRect);
// {$ELSE}
// {$ENDIF}
// {$ELSE}
// {$IFNDEF TEST_BMPTRANSPARENT}
// Bmp1.Draw(PB.Canvas.Handle, 10, 40);
// {$ELSE}
// Bmp1.DrawTransparent(PB.Canvas.Handle, 10, 40, TransColor);
// {$ENDIF}
// {$ENDIF}
// end;

{------------------------------------------------------------------------------}

procedure TestPaint(Dummy: Pointer; Sender: PControl; DC: HDC);
var
  CR: TRect;
begin
  CR := Sender.ClientRect;
  // Sender.Canvas.MoveTo(1, 1);
  // Sender.Color := clBlue;
  // Sender.Canvas.Brush.Color := clYellow;
  // Sender.Canvas.FillRect(CR);
  // TransColor := App.Fpng.TransparentColor;
  Fpng.StretchDrawTransparent(DC, CR, clBlack);
  // App.Fpng.DrawTransparent(Sender.Canvas.Handle, CR.Left, CR.Top, CR.Width, CR.Height, clBlack);
end;

{------------------------------------------------------------------------------}

procedure ShowDialog;
const
  cFormSize = 380;
  cFormBorder = 16;
var
  LIcon: PIcon;
  PB1, Label1, Group1, Check1: PControl;
  Y, Height, Width: integer;
begin
  if not Assigned(FOptionDialog) then
  begin
    FOptionDialog := KOL.NewForm(nil, Global_Lang.menu_info).SetSize(cFormSize, 300);
    FOptionDialog.Font.FontHeight := -12;
    FOptionDialog.Font.FontName := 'MS Sans Serif';
    FOptionDialog.OnDestroy := TOnEvent(MakeMethod(nil, @OnFormClose));
    FOptionDialog.AutoFreeOnClose := True;
    FOptionDialog.Style := WS_SYSMENU or WS_CAPTION or WS_DLGFRAME;
    Width := cFormSize - (cFormBorder);

    LIcon := NewIcon;
    LIcon.LoadFromResourceID(hInstance, 1, 0);
    FOptionDialog.Icon := LIcon.Handle;
    LIcon.Free;

    if (Fpng = nil) then
    begin
      Fpng := NewPngObject;
      Fpng.LoadFromResourceName(hInstance, 'FFALT');
    end;

    Y := cFormBorder;

    PB1 := NewPaintBox(FOptionDialog).SetPosition(cFormSize - cFormBorder - Fpng.Width - 10, 20).SetSize(Fpng.Width, Fpng.Height);
    PB1.OnPaint := TOnPaint(MakeMethod(nil, @TestPaint));

    Height := 30;
    Label1 := NewWordWrapLabel(FOptionDialog, Global_wndTitle + ' ' + Global_Lang.version + ' ' + Global_strVersion) //
      .SetSize(Width, Height).SetPosition(cFormBorder, Y);
    Label1.Font.FontStyle := [fsBold];
    Label1.Font.FontHeight := -13;
    Label1.Font.FontQuality := fqAntialiased;
    inc(Y, Height);
    inc(Y, 10);

    Height := 68;
    Group1 := NewGroupbox(FOptionDialog, Global_Lang.sprite_size) //
      .SetSize(100, Height).SetPosition(cFormBorder, Y);

    Check1 := NewRadiobox(Group1, Global_Lang.sprite_size_large).SetPosition(cFormBorder, 16);
    Check1.Checked := App.SettingsSize = cNormal;
    Check1.OnClick := TOnEvent(MakeMethod(nil, @OnRadioButtonLargeClick));
    Check1 := NewRadiobox(Group1, Global_Lang.sprite_size_small).SetPosition(cFormBorder, 16 + 24);
    Check1.Checked := App.SettingsSize = cSmall;
    Check1.OnClick := TOnEvent(MakeMethod(nil, @OnRadioButtonSmallClick));

    Height := 24;
    Check1 := NewCheckbox(FOptionDialog, Global_Lang.autopilot).SetPosition(cFormBorder + 100 + cFormBorder, Y);
    Check1.Checked := App.SettingsAutoFly;
    Check1.OnClick := TOnEvent(MakeMethod(nil, @OnCheckButtonAutoPilotClick));
    Check1.Width := 100;
    inc(Y, Height);

    Height := 24;
    Check1 := NewCheckbox(FOptionDialog, Global_Lang.enabledrag).SetPosition(cFormBorder + 100 + cFormBorder, Y);
    Check1.Checked := App.SettingsDragable;
    Check1.OnClick := TOnEvent(MakeMethod(nil, @OnCheckButtonDragableClick));
    Check1.Width := 100;
    inc(Y, Height);

    Check1 := NewCheckbox(FOptionDialog, Global_Lang.ontop).SetPosition(cFormBorder + 100 + cFormBorder, Y);
    Check1.Checked := App.SettingsOnTop;
    Check1.OnClick := TOnEvent(MakeMethod(nil, @OnCheckButtonOnTopClick));
    Check1.Width := 100;

    inc(Y, 40);

    Height := 16;
    Label1 := NewWordWrapLabel(FOptionDialog, Global_Lang.createdBy) //
      .SetSize(Width div 2, Height).SetPosition(cFormBorder, Y);
    Label1.Font.FontQuality := fqAntialiased;
    inc(Y, Height);

    Height := 16;
    Label1 := NewLabel(FOptionDialog, '@ffalt') //
      .SetSize(Width div 2, Height).SetPosition(cFormBorder, Y);
    Label1.Cursor := LoadCursor(0, IDC_HAND);
    Label1.Font.Color := clBlue;
    Label1.Font.FontStyle := Label1.Font.FontStyle + [fsUnderline];
    Label1.OnClick := TOnEvent(MakeMethod(nil, @OnLabelFfaltClick));
    Label1.OnMouseEnter := TOnEvent(MakeMethod(nil, @OnLabelEnter));
    Label1.OnMouseLeave := TOnEvent(MakeMethod(nil, @OnLabelLeave));
    inc(Y, Height);

    inc(Y, 10);

    Height := 16;
    Label1 := NewWordWrapLabel(FOptionDialog, Global_Lang.graphics_sounds_by) //
      .SetSize(Width div 2, Height).SetPosition(cFormBorder, Y);
    Label1.Font.FontQuality := fqAntialiased;
    inc(Y, Height);

    Height := 16;
    Label1 := NewLabel(FOptionDialog, 'Tiny Speck') //
      .SetSize(Width div 2, Height).SetPosition(cFormBorder, Y);
    Label1.Cursor := LoadCursor(0, IDC_HAND);
    Label1.Font.Color := clBlue;
    Label1.Font.FontStyle := Label1.Font.FontStyle + [fsUnderline];
    Label1.OnClick := TOnEvent(MakeMethod(nil, @OnLabelTinySpeckClick));
    Label1.OnMouseEnter := TOnEvent(MakeMethod(nil, @OnLabelEnter));
    Label1.OnMouseLeave := TOnEvent(MakeMethod(nil, @OnLabelLeave));
    inc(Y, Height);

    inc(Y, 2);

    Height := 16;
    Label1 := NewWordWrapLabel(FOptionDialog, Global_Lang.licensed_under) //
      .SetSize(Width, Height).SetPosition(cFormBorder, Y);
    Label1.Font.FontQuality := fqAntialiased;
    inc(Y, Height);

    Height := 16;
    Label1 := NewLabel(FOptionDialog, 'Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported') //
      .SetSize(Width, Height).SetPosition(cFormBorder, Y);
    Label1.Cursor := LoadCursor(0, IDC_HAND);
    Label1.Font.Color := clBlue;
    Label1.Font.FontStyle := Label1.Font.FontStyle + [fsUnderline];
    Label1.OnClick := TOnEvent(MakeMethod(nil, @OnLabelCCClick));
    Label1.OnMouseEnter := TOnEvent(MakeMethod(nil, @OnLabelEnter));
    Label1.OnMouseLeave := TOnEvent(MakeMethod(nil, @OnLabelLeave));

    FOptionDialog.CenterOnForm(nil);
    FOptionDialog.Show;
    FOptionDialog.DoSetFocus;
  end
  else
    FOptionDialog.BringToFront;
end;

{------------------------------------------------------------------------------}

end.
