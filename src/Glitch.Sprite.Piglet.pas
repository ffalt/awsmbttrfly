unit Glitch.Sprite.Piglet;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Sprite,
  Glitch.Texture,
  Glitch.Consts;

const
  Piglet_SizeSmall = 0.8;
  Piglet_Size = 1.5;
  Piglet_Size_Padding_Bottom = 14;
  Piglet_SizeSmall_Padding_Bottom = 24;
  Piglet_Width: integer = 90;
  Piglet_Height: integer = 70;
  Piglet_Path = 'piglet';
  Piglet_Textures: array [0 .. 0] of TMapInfo = ( //
    (ResID: 1102; ResFile: 'piglet__x1_sit_png_1354830978.png'; Rows: 30; Cols: 24; Zoom: Piglet_Size; ZoomSmall: Piglet_SizeSmall; FreeSpace: 20) //
    );

type
  TDirection = (cUp, cDown, cStay);

  TPiglet = class(TGLObjectDraw)
  private
    FFlip: boolean;
    FDir: TDirection;
    FSpeed: integer;
    FMap: TTextureMap;
    procedure RandomFlip;
    function GetSizeFloat: single;
    function GetBottomPadding: integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function WindowWidth: integer; override;
    class function WindowHeight: integer; override;
    class function Name: string; override;
    procedure InitTextures(const APath: string); override;
    procedure DeInitTextures; override;
    procedure RenderObj; override;
    procedure ToggleFlip;
    procedure UpdateSizeFloat; override;
    procedure Hover(const AStart: boolean); override;
    procedure Drop; override;
    procedure Jump;
    function MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean; override;
    function StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint; override;
  end;

implementation

uses
  Glitch.Utils;

{ ------------------------------------------------------------------------------ }

constructor TPiglet.Create;
begin
  inherited;
  FMap := TTextureMap.Create;
  FSpeed := 2;
  FDir := cDown;
  FFlip := false;
end;

{ ------------------------------------------------------------------------------ }

destructor TPiglet.Destroy;
begin
  DeInitTextures;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

class function TPiglet.WindowHeight: integer;
begin
  result := Piglet_Height;
end;

{ ------------------------------------------------------------------------------ }

class function TPiglet.WindowWidth: integer;
begin
  result := Piglet_Width;
end;

{ ------------------------------------------------------------------------------ }

function TPiglet.StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint;
begin
  if (FStartPos.X = -1) and (FStartPos.Y = -1) then
  begin
    FStartPos.X := 100 + Random(AArea.Width - AWidth - 200);
    FStartPos.Y := 100;
  end;
  result := FStartPos;
  FDir := cDown;
  RandomFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.Jump;
begin
  FDir := cUp;
  FSpeed := 40;
end;

{ ------------------------------------------------------------------------------ }

function TPiglet.MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean;
begin
  result := true;
  case FDir of
    cDown:
      begin
        Y := Y + FSpeed;
        if (Y + AHeight - GetBottomPadding >= AArea.Bottom) then
        begin
          FDir := cUp;
          if (FSpeed <= 3) then
            FDir := cStay
          else
            Y := AArea.Top + AArea.Height - (AHeight - GetBottomPadding);
        end
        else
          inc(FSpeed);
      end;
    cUp:
      begin
        Y := Y - FSpeed;
        dec(FSpeed, 2);
        if (Y < AArea.Top) then
        begin
          FSpeed := 1;
          FDir := cDown;
          Y := AArea.Top;
        end
        else if (FSpeed < 1) then
        begin
          FSpeed := 1;
          FDir := cDown;
        end;
      end;
    cStay:
      result := false;
  end;
end;

{ ------------------------------------------------------------------------------ }

class function TPiglet.Name: string;
begin
  result := 'Piglet';
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.ToggleFlip;
begin
  FFlip := not FFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.RandomFlip;
begin
  FFlip := Random(2) = 1;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.DeInitTextures;
begin
  inherited;
  if Assigned(FMap) then
    FMap.free;
  FMap := nil;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.Drop;
begin
  FDir := cDown;
  FSpeed := 1;
  RandomFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.Hover(const AStart: boolean);
begin
  // inherited;
end;

{ ------------------------------------------------------------------------------ }

function TPiglet.GetBottomPadding: integer;
begin
  case FSize of
    cSmall:
      result := Piglet_SizeSmall_Padding_Bottom;
  else
    result := Piglet_Size_Padding_Bottom;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TPiglet.GetSizeFloat: single;
begin
  case FSize of
    cSmall:
      result := Piglet_SizeSmall;
  else
    result := Piglet_Size;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.UpdateSizeFloat;
begin
  FMap.Size := GetSizeFloat;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.InitTextures(const APath: string);
begin
  inherited;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Piglet InitTextures');
{$ENDIF}
{$IFDEF ALLINONE}
  FMap.LoadFromRes(Piglet_Textures[0].ResID, Piglet_Textures[0].Rows, Piglet_Textures[0].Cols, Piglet_Textures[0].FreeSpace, GetSizeFloat);
{$ELSE}
  FMap.LoadFromFilename(APath + Piglet_Path + '\' + Piglet_Textures[0].ResFile, Piglet_Textures[0].Rows, Piglet_Textures[0].Cols, Piglet_Textures[0].FreeSpace, GetSizeFloat);
{$ENDIF}
  FMap.Bind;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiglet.RenderObj;
begin
  FMap.Render(FMap.Current.Next, FFlip);
end;

{ ------------------------------------------------------------------------------ }

end.
