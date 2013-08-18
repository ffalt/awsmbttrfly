unit Glitch.Consts;

interface

uses
  WinApi.Messages;

const
  WM_TRAYEVENT = WM_USER + 10;

  ID_TIMER_DRAW = $000001;
  ID_TIMER_MOVE = $000002;
  TIMERINTERVAL_DRAW = 60;
  TIMERINTERVAL_MOVE = 30;

const
  MENU_CLOSE = 1000;
  MENU_DIALOG = 1001;
  MENU_REMOVE = 1002;
  MENU_MILK = 1003;
  MENU_MASSAGE = 1004;
  MENU_SING = 1005;
  MENU_NIBBLE = 1006;
  MENU_ADD_Base = 1100;

type
  TMapInfo = record
    ResID: Cardinal;
    ResFile: string;
    Rows: integer;
    Cols: integer;
    Zoom: double;
    ZoomSmall: double;
    FreeSpace: integer;
  end;

const
  IMG_ICON = 100;

const
  Global_wndClassName: string = 'wndDskClass';
  Global_wndMainClassName: string = 'wndMainDskClass';

  Global_wndTitle: string = 'AwsmBttrfly';
  Global_strVersion: string = '0.8';

  Global_EyeZ: double = 7;
  Global_zNear: double = 0.1;
  Global_zFar: double = 255.0;

  Global_AreaBorder: integer = 30;

type
  TLang = record
    version: string;
    createdBy: string;
    menu_info: string;
    menu_end: string;
    autopilot: string;
    enabledrag: string;
    sprite_size: string;
    sprite_size_large: string;
    sprite_size_normal: string;
    sprite_size_small: string;
    remove_milk: string;
    graphics_sounds_by: string;
    licensed_under: string;
    milk: string;
    massage: string;
    sing: string;
    ontop: string;
    nibble: string;
    remove_start: string;
    remove_end: string;
    add_start: string;
    add_end: string;
    function FormatRemoveSprite(const AName: string): string;
    function FormatAddSprite(const AName: string): string;
    function GetOptionTitle: string;
    function GetVersionTitle: string;
    procedure Eng;
    procedure Deu;
    procedure InitLang;
  end;

var
  Global_Lang: TLang;

implementation

uses
  WinApi.Windows;

{------------------------------------------------------------------------------}

procedure TLang.Eng;
begin
  version := 'Version';
  createdBy := 'Created by';
  menu_info := 'Options';
  menu_end := 'End';
  autopilot := 'Autopilot';
  enabledrag := 'Clickable';
  sprite_size := 'Size';
  sprite_size_large := 'Large';
  sprite_size_normal := 'Normal';
  sprite_size_small := 'Small';
  remove_start := 'Set ';
  remove_end := ' free';
  add_start := 'Attracted ';
  add_end := '';
  remove_milk := 'Drink Milx';
  graphics_sounds_by := 'Graphics & Sounds by';
  licensed_under := 'licensed under';
  ontop := 'Always (on) top';
end;

{------------------------------------------------------------------------------}

procedure TLang.Deu;
begin
  sprite_size := 'Größe';
  version := 'Version';
  createdBy := 'gebastelt von';
  menu_info := 'Optionen';
  menu_end := 'Ende';
  autopilot := 'Autopilot';
  enabledrag := 'Klickbar';
  sprite_size_large := 'Groß';
  sprite_size_normal := 'Normal';
  sprite_size_small := 'Klein';
  remove_start := '';
  remove_end := ' freilassen';
  add_start := '';
  add_end := ' anlocken';
  remove_milk := 'Milx wegschütten';
  graphics_sounds_by := 'Grafik & Sounds von';
  licensed_under := 'lizenziert unter';
  ontop := 'Immer oben auf';
end;

{------------------------------------------------------------------------------}

function TLang.FormatAddSprite(const AName: string): string;
begin
  result := add_start + AName + add_end;
end;

{------------------------------------------------------------------------------}

function TLang.FormatRemoveSprite(const AName: string): string;
begin
  result := remove_start + AName + remove_end;
end;

{------------------------------------------------------------------------------}

function TLang.GetOptionTitle: string;
begin
  result := Global_wndTitle + #9#9 + version + #32 + Global_strVersion + #13 + createdBy + ' ffalt 2013' + #13#13 + 'Graphics & Sounds by Tiny Speck, licensed under' + //
    #13 + 'Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License' + #13 + 'http://creativecommons.org/licenses/by-nc-sa/3.0/';
end;

{------------------------------------------------------------------------------}

function TLang.GetVersionTitle: string;
begin
  result := Global_wndTitle + ' v' + Global_strVersion;
end;

{------------------------------------------------------------------------------}

procedure TLang.InitLang;
var
  i: integer;
begin
  milk := 'Milk';
  massage := 'Massage';
  sing := 'Sing';
  nibble := 'Nibble';
  i := WinApi.Windows.GetUserDefaultLangID;
  if i = 1031 then
    Deu
  else
    Eng;
end;

{------------------------------------------------------------------------------}

end.
