unit Glitch.Sprite.Piggy;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Sprite,
  Glitch.Texture,
  Glitch.Consts;

type
  TPiggyTexture = ( //
    cptWalk, //
    cptChew, //
    cptLook, //
    cptNibble, //
    cptRooked1, //
    cptRooked2, //
    cptOvernibble);

const
  Piggy_Size = 2;
  Piggy_SizeSmall = 1.5;
  Piggy_Width: integer = 90;
  Piggy_Height: integer = 70;
  Piggy_Size_Padding_Bottom = 6;
  Piggy_SizeSmall_Padding_Bottom = 16;
  Piggy_Path: string = 'piggy';
  PiggyTextures: array [TPiggyTexture] of TMapInfo = ( //
    (ResID: 1010; ResFile: 'npc_piggy__x1_walk_png_1354829432.png'; Rows: 3; Cols: 8; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall), //
    (ResID: 1011; ResFile: 'npc_piggy__x1_chew_png_1354829433.png'; Rows: 5; Cols: 11; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall; FreeSpace: 2), //
    (ResID: 1012; ResFile: 'npc_piggy__x1_look_screen_png_1354829434.png'; Rows: 5; Cols: 10; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall; FreeSpace: 2), //
    (ResID: 1013; ResFile: 'npc_piggy__x1_nibble_png_1354829441.png'; Rows: 6; Cols: 10; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall), //
    (ResID: 1014; ResFile: 'npc_piggy__x1_rooked1_png_1354829442.png'; Rows: 1; Cols: 10; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall), //
    (ResID: 1015; ResFile: 'npc_piggy__x1_rooked2_png_1354829443.png'; Rows: 3; Cols: 8; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall), //
    (ResID: 1016; ResFile: 'npc_piggy__x1_too_much_nibble_png_1354829441.png'; Rows: 6; Cols: 12; Zoom: Piggy_Size; ZoomSmall: Piggy_SizeSmall; FreeSpace: 1) //
    );

type
  TDirection = (cUp, cDown, cStay, cLeft, cRight);

  TPiggy = class(TGLObjectDraw)
  private
    FFlip: boolean;
    FDir: TDirection;
    FSpeed: integer;
    FPiggyTexture: TPiggyTexture;
    FTextures: array [TPiggyTexture] of TTextureMap;
    FLastTexture: TPiggyTexture;
    procedure RandomFlip;
    function GetSizeFloat(const ATexture: TPiggyTexture): single;
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
    procedure Nibble;
    function MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean; override;
    function StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint; override;
  end;

implementation

uses
  Glitch.Utils;

{ ------------------------------------------------------------------------------ }

constructor TPiggy.Create;
var
  Ltexture: TPiggyTexture;
begin
  inherited;
  for Ltexture := Low(TPiggyTexture) to High(TPiggyTexture) do
    FTextures[Ltexture] := TTextureMap.Create;
  FDir := cDown;
  FFlip := false;
  FPiggyTexture := cptWalk;
  FLastTexture := cptNibble;
end;

{ ------------------------------------------------------------------------------ }

destructor TPiggy.Destroy;
begin
  DeInitTextures;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

class function TPiggy.WindowHeight: integer;
begin
  result := Piggy_Height;
end;

{ ------------------------------------------------------------------------------ }

class function TPiggy.WindowWidth: integer;
begin
  result := Piggy_Width;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.DeInitTextures;
var
  Ltexture: TPiggyTexture;
begin
  inherited;
  for Ltexture := Low(TPiggyTexture) to High(TPiggyTexture) do
    if (FTextures[Ltexture] <> nil) then
    begin
      FTextures[Ltexture].Free;
      FTextures[Ltexture] := nil;
    end;
end;

{ ------------------------------------------------------------------------------ }

function TPiggy.StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint;
begin
  if (FStartPos.X = -1) and (FStartPos.Y = -1) then
  begin
    FStartPos.X := 100 + Random(AArea.Width - AWidth - 200);
    FStartPos.Y := AArea.Height - AHeight - GetBottomPadding;
  end;
  result := FStartPos;
  FDir := cDown;
  RandomFlip;
end;

{ ------------------------------------------------------------------------------ }

function TPiggy.GetBottomPadding: integer;
begin
  case FSize of
    cSmall:
      result := Piggy_SizeSmall_Padding_Bottom;
  else
    result := Piggy_Size_Padding_Bottom;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.Jump;
begin
  FDir := cUp;
  FSpeed := 40;
end;

{ ------------------------------------------------------------------------------ }

function TPiggy.MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean;
var
  LMap: TTextureMap;
begin
  result := true;
  LMap := FTextures[FPiggyTexture];
  case FDir of
    cDown:
      begin
        Y := Y + FSpeed;
        if (Y + AHeight - GetBottomPadding >= AArea.Bottom) then
        begin
          FDir := cUp;
          FPiggyTexture := cptRooked1;
          if (FSpeed <= 3) then
          begin
            FDir := cStay;
            FPiggyTexture := cptRooked2;
            FTextures[cptRooked2].Current.Reset;
          end
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
          FPiggyTexture := cptRooked1;
          Y := AArea.Top;
        end
        else if (FSpeed < 1) then
        begin
          FSpeed := 1;
          FPiggyTexture := cptRooked1;
          FDir := cDown;
        end;
      end;
    cLeft:
      begin
        X := X - FSpeed;
        if (X < AArea.Left) then
        begin
          FDir := cRight;
          FFlip := false;
          X := AArea.Left;
        end
        else
        begin
          if Random(200) = 1 then
          begin
            FDir := cStay;
            if Random(2) = 1 then
              FPiggyTexture := cptChew
            else
              FPiggyTexture := cptLook;
            FTextures[FPiggyTexture].Current.Reset;
          end;
        end;
      end;
    cRight:
      begin
        X := X + FSpeed;
        if (X + AWidth >= AArea.Right) then
        begin
          FDir := cLeft;
          FFlip := true;
          X := AArea.Right - AWidth;
        end
        else
        begin
          if Random(200) = 1 then
          begin
            FDir := cStay;
            if Random(2) = 1 then
              FPiggyTexture := cptChew
            else
              FPiggyTexture := cptLook;
            FTextures[FPiggyTexture].Current.Reset;
          end;
        end;
      end;
    cStay:
      begin
        FSpeed := 1;
        result := false;
        if (LMap.Current.Index = LMap.Current.Last) then
        begin
          FPiggyTexture := cptWalk;
          if FFlip then
            FDir := cLeft
          else
            FDir := cRight;
        end;
      end;
  end;
end;

{ ------------------------------------------------------------------------------ }

class function TPiggy.Name: string;
begin
  result := 'Piggy';
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.Nibble;
begin
  FDir := cStay;
  FTextures[cptNibble].Current.Reset;
  FPiggyTexture := cptNibble;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.ToggleFlip;
begin
  FFlip := not FFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.RandomFlip;
begin
  FFlip := Random(2) = 1;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.Drop;
begin
  FDir := cDown;
  FSpeed := 1;
  RandomFlip;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.Hover(const AStart: boolean);
begin
  // inherited;
end;

{ ------------------------------------------------------------------------------ }

function TPiggy.GetSizeFloat(const ATexture: TPiggyTexture): single;
begin
  case FSize of
    cSmall:
      result := PiggyTextures[ATexture].ZoomSmall;
  else
    result := PiggyTextures[ATexture].Zoom;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.UpdateSizeFloat;
var
  Ltexture: TPiggyTexture;
begin
  for Ltexture := Low(TPiggyTexture) to High(TPiggyTexture) do
    FTextures[Ltexture].Size := GetSizeFloat(Ltexture);
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.InitTextures(const APath: string);
var
  Ltexture: TPiggyTexture;
  Ltexmap: TMapInfo;
begin
  inherited;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Piggy InitTextures');
{$ENDIF}
  for Ltexture := Low(TPiggyTexture) to High(TPiggyTexture) do
  begin
    Ltexmap := PiggyTextures[Ltexture];
{$IFDEF ALLINONE}
    FTextures[Ltexture].LoadFromRes(Ltexmap.ResID, //
{$ELSE}
    FTextures[Ltexture].LoadFromFilename(APath + Piggy_Path + '\' + Ltexmap.ResFile, //
{$ENDIF}
      Ltexmap.Rows, //
      Ltexmap.Cols, //
      Ltexmap.FreeSpace, //
      GetSizeFloat(Ltexture) //
      );
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TPiggy.RenderObj;
var
  LMap: TTextureMap;
begin
  LMap := FTextures[FPiggyTexture];
  if FPiggyTexture <> FLastTexture then
  begin
    FLastTexture := FPiggyTexture;
    LMap.Bind;
  end;
  LMap.Render(LMap.Current.Next, FFlip);
end;

{ ------------------------------------------------------------------------------ }

end.
