unit Glitch.Sprite.Milk;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Sprite,
  Glitch.Texture,
  Glitch.Consts;

const
  Milk_Row = 1;
  Milk_Col = 4;
  Milk_Size = 2;
  Milk_SizeSmall = 1.5;
  Milk_Width: integer = 37;
  Milk_Height: integer = 44;
  Milk_ResPath: string = 'milk';
  MilkTextures: array [0 .. 0] of TMapInfo = ( //
    (ResID: 1101; ResFile: 'milk_butterfly__x1_1_x1_2_x1_3_x1_4_png_1354829507.png'; Rows: 1; Cols: 4; Zoom: Milk_Size; ZoomSmall: Milk_SizeSmall; FreeSpace: 0) //
    );

type
  TDirection = (cUp, cDown, cStay);

  TMilk = class(TGLObjectDraw)
  private
    FFlip: boolean;
    FDir: TDirection;
    FSpeed: integer;
    FMap: TTextureMap;
    procedure RandomFlip;
    function GetSizeFloat: single;
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

const
  cImageBloatY = 0;

  { ------------------------------------------------------------------------------ }

constructor TMilk.Create;
begin
  inherited;
  FMap := TTextureMap.Create;
  FSpeed := 2;
  FDir := cDown;
  FFlip := false;
end;

{ ------------------------------------------------------------------------------ }

destructor TMilk.Destroy;
begin
  DeInitTextures;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

class function TMilk.WindowHeight: integer;
begin
  result := Milk_Height;
end;

{ ------------------------------------------------------------------------------ }

class function TMilk.WindowWidth: integer;
begin
  result := Milk_Width;
end;

{ ------------------------------------------------------------------------------ }

function TMilk.StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint;
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

procedure TMilk.Jump;
begin
  FDir := cUp;
  FSpeed := 40;
end;

{ ------------------------------------------------------------------------------ }

function TMilk.MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean;
begin
  result := true;
  case FDir of
    cDown:
      begin
        Y := Y + FSpeed;
        if (Y + AHeight - cImageBloatY >= AArea.Bottom) then
        begin
          FDir := cUp;
          if (FSpeed <= 8) then
            FDir := cStay
          else
            Y := AArea.Top + AArea.Height - (AHeight - cImageBloatY);
        end
        else
          inc(FSpeed, 2);
      end;
    cUp:
      begin
        Y := Y - (FSpeed);
        dec(FSpeed, 6);
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

{------------------------------------------------------------------------------}

class function TMilk.Name: string;
begin
  result := 'Milk';
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.ToggleFlip;
begin
  FFlip := not FFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.RandomFlip;
begin
  FFlip := Random(2) = 1;
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.DeInitTextures;
begin
  inherited;
  if Assigned(FMap) then
    FMap.free;
  FMap := nil;
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.Drop;
begin
  FDir := cDown;
  FSpeed := 1;
  RandomFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.Hover(const AStart: boolean);
begin
  // inherited;
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.InitTextures(const APath: string);
begin
  inherited;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Milk InitTextures');
{$ENDIF}
{$IFDEF ALLINONE}
  FMap.LoadFromRes(MilkTextures[0].ResID, MilkTextures[0].Rows, MilkTextures[0].Cols, MilkTextures[0].FreeSpace, GetSizeFloat);
{$ELSE}
  FMap.LoadFromFilename(APath + Milk_ResPath + '\' + MilkTextures[0].ResFile, MilkTextures[0].Rows, MilkTextures[0].Cols, MilkTextures[0].FreeSpace, GetSizeFloat);
{$ENDIF}
  FMap.Bind;
end;

{ ------------------------------------------------------------------------------ }

function TMilk.GetSizeFloat: single;
const
  LSizes: array [TSpriteSize] of double = (Milk_Size, Milk_SizeSmall);
begin
  result := LSizes[FSize];
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.UpdateSizeFloat;
begin
  FMap.Size := GetSizeFloat;
end;

{ ------------------------------------------------------------------------------ }

procedure TMilk.RenderObj;
begin
  FMap.Render(0, FFlip);
end;

{ ------------------------------------------------------------------------------ }

end.
