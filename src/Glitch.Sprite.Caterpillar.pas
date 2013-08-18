unit Glitch.Sprite.Caterpillar;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Sprite,
  Glitch.Texture,
  Glitch.Consts;

const
  Caterpillar_SizeSmall = 0.8;
  Caterpillar_Size = 1.5;
  Caterpillar_Size_Padding_Bottom = 14;
  Caterpillar_SizeSmall_Padding_Bottom = 24;
  Caterpillar_Width: integer = 90;
  Caterpillar_Height: integer = 70;
  Caterpillar_Path = 'caterpillar';
  CaterpillarTextures: array [0 .. 0] of TMapInfo = ( //
    (ResID: 1100; ResFile: 'caterpillar__x1_sit_png_1354831021.png'; Rows: 23; Cols: 31; Zoom: Caterpillar_Size; ZoomSmall: Caterpillar_SizeSmall; FreeSpace: 13) //
    );

type
  TDirection = (cUp, cDown, cStay);

  TCaterpillar = class(TGLObjectDraw)
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

constructor TCaterpillar.Create;
begin
  inherited;
  FMap := TTextureMap.Create;
  FSpeed := 2;
  FDir := cDown;
  FFlip := false;
end;

{ ------------------------------------------------------------------------------ }

destructor TCaterpillar.Destroy;
begin
  DeInitTextures;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

class function TCaterpillar.WindowHeight: integer;
begin
  result := Caterpillar_Height;
end;

{ ------------------------------------------------------------------------------ }

class function TCaterpillar.WindowWidth: integer;
begin
  result := Caterpillar_Width;
end;

{ ------------------------------------------------------------------------------ }

function TCaterpillar.StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint;
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

procedure TCaterpillar.Jump;
begin
  FDir := cUp;
  FSpeed := 40;
end;

{ ------------------------------------------------------------------------------ }

function TCaterpillar.MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean;
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

class function TCaterpillar.Name: string;
begin
  result := 'Caterpillar';
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.ToggleFlip;
begin
  FFlip := not FFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.RandomFlip;
begin
  FFlip := Random(2) = 1;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.DeInitTextures;
begin
  inherited;
  if Assigned(FMap) then
    FMap.free;
  FMap := nil;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.Drop;
begin
  FDir := cDown;
  FSpeed := 1;
  RandomFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.Hover(const AStart: boolean);
begin
  // inherited;
end;

{ ------------------------------------------------------------------------------ }

function TCaterpillar.GetBottomPadding: integer;
begin
  case FSize of
    cSmall:
      result := Caterpillar_SizeSmall_Padding_Bottom;
  else
    result := Caterpillar_Size_Padding_Bottom;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TCaterpillar.GetSizeFloat: single;
begin
  case FSize of
    cSmall:
      result := Caterpillar_SizeSmall;
  else
    result := Caterpillar_Size;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.UpdateSizeFloat;
begin
  FMap.Size := GetSizeFloat;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.InitTextures(const APath: string);
begin
  inherited;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Caterpillar InitTextures');
{$ENDIF}
{$IFDEF ALLINONE}
  FMap.LoadFromRes(CaterpillarTextures[0].ResID, CaterpillarTextures[0].Rows, CaterpillarTextures[0].Cols, CaterpillarTextures[0].FreeSpace, GetSizeFloat);
{$ELSE}
  FMap.LoadFromFilename(APath + Caterpillar_Path + '\' + CaterpillarTextures[0].ResFile, CaterpillarTextures[0].Rows, CaterpillarTextures[0].Cols, CaterpillarTextures[0].FreeSpace, GetSizeFloat);
{$ENDIF}
  FMap.Bind;
end;

{ ------------------------------------------------------------------------------ }

procedure TCaterpillar.RenderObj;
begin
  FMap.Render(FMap.Current.Next, FFlip);
end;

{ ------------------------------------------------------------------------------ }

end.
