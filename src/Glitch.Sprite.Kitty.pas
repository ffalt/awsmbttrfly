unit Glitch.Sprite.Kitty;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Sprite,
  Glitch.Texture,
  Glitch.Consts;

type
  TKittyTexture = ( //
    cktFly, //
    cktBall, //
    cktJump, //
    cktFlySmall, //
    cktBallSmall, //
    cktJumpSmall);

const
  Kitty_Size = 1.75;
  Kitty_SizeSmall = 1.5;
  Kitty_Width: integer = 140;
  Kitty_Height: integer = 140;
  Kitty_Size_Padding_Bottom = 36;
  Kitty_SizeSmall_Padding_Bottom = 16;
  Kitty_Path: string = 'kitty';
  KittyTextures: array [TKittyTexture] of TMapInfo = ( //
    (ResID: 1020; ResFile: 'npc_kitty_chicken__x1_3fly_png_1354840558.png'; Rows: 3; Cols: 7; Zoom: Kitty_Size; ZoomSmall: Kitty_SizeSmall; FreeSpace: 1), //
    (ResID: 1021; ResFile: 'npc_kitty_chicken__x1_3hitBall_png_1354840558.png'; Rows: 2; Cols: 5; Zoom: Kitty_Size; ZoomSmall: Kitty_SizeSmall; FreeSpace: 2), //
    (ResID: 1022; ResFile: 'npc_kitty_chicken__x1_3happy_png_1354840564.png'; Rows: 6; Cols: 7; Zoom: Kitty_Size; ZoomSmall: Kitty_SizeSmall; FreeSpace: 5), //
    (ResID: 1023; ResFile: 'npc_kitty_chicken__x1_2fly_png_1354840551.png'; Rows: 3; Cols: 7; Zoom: Kitty_Size; ZoomSmall: Kitty_SizeSmall; FreeSpace: 1), //
    (ResID: 1024; ResFile: 'npc_kitty_chicken__x1_2hitBall_png_1354840552.png'; Rows: 2; Cols: 5; Zoom: Kitty_Size; ZoomSmall: Kitty_SizeSmall; FreeSpace: 2), //
    (ResID: 1025; ResFile: 'npc_kitty_chicken__x1_2jump_png_1354840550.png'; Rows: 3; Cols: 6; Zoom: Kitty_Size; ZoomSmall: Kitty_SizeSmall; FreeSpace: 2) //
    );

type
  TDirection = (cStay, cLeft, cRight, cUp, cDown, cJump, cFall);

  TKitty = class(TGLObjectDraw)
  private
    FSmall, FFlip: boolean;
    FDir, FNext: TDirection;
    FMoved, FSpeed: integer;
    FKittyTexture: TKittyTexture;
    FTextures: array [TKittyTexture] of TTextureMap;
    FLastTexture: TKittyTexture;
    function GetSizeFloat(const ATexture: TKittyTexture): single;
    function GetBottomPadding: integer;
    function GetRandomDirection: TDirection;
    function GetFlipByDir(const dir: TDirection): boolean;
    procedure TurnLeft;
    procedure TurnRight;
    procedure Ball;
    procedure RandomTurn;
    function GetTexture(tt: TKittyTexture): TKittyTexture;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function WindowWidth: integer; override;
    class function WindowHeight: integer; override;
    class function Name: string; override;
    procedure InitTextures(const APath: string); override;
    procedure DeInitTextures; override;
    procedure RenderObj; override;
    procedure UpdateSizeFloat; override;
    procedure Hover(const AStart: boolean); override;
    procedure Drop; override;
    procedure Turn;
    function MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean; override;
    function StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint; override;
  end;

implementation

uses
  Glitch.Utils;

{ ------------------------------------------------------------------------------ }

constructor TKitty.Create;
var
  Ltexture: TKittyTexture;
begin
  inherited;
  for Ltexture := Low(TKittyTexture) to High(TKittyTexture) do
    FTextures[Ltexture] := TTextureMap.Create;
  FSmall := true;
  FDir := cStay;
  FFlip := false;
  FMoved := 0;
  FKittyTexture := GetTexture(cktFly);
  FLastTexture := GetTexture(cktBall);
end;

{ ------------------------------------------------------------------------------ }

function TKitty.GetTexture(tt: TKittyTexture): TKittyTexture;
begin
  result := tt;
  if FSmall then
  begin
    case tt of
      cktFly:
        result := cktFlySmall;
      cktBall:
        result := cktBallSmall;
      cktJump:
        result := cktJumpSmall;
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TKitty.StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint;
begin
  if (FStartPos.X = -1) and (FStartPos.Y = -1) then
  begin
    FStartPos.X := 100 + Random(AArea.Width - AWidth - 200);
    FStartPos.Y := AArea.Height - AHeight - GetBottomPadding;
  end;
  result := FStartPos;
  FNext := cLeft;
  FFlip := true;
  FDir := cStay;
  FKittyTexture := GetTexture(cktJump);
  FDir := cFall;
end;

{ ------------------------------------------------------------------------------ }

function TKitty.GetBottomPadding: integer;
begin
  case FSize of
    cSmall:
      result := Kitty_SizeSmall_Padding_Bottom;
  else
    result := Kitty_Size_Padding_Bottom;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TKitty.GetRandomDirection: TDirection;
begin
  case Random(4) of
    0:
      result := cLeft;
    1:
      result := cRight;
    2:
      result := cUp;
  else
    result := cDown;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TKitty.GetFlipByDir(const dir: TDirection): boolean;
begin
  case dir of
    cLeft:
      result := true;
    cRight:
      result := false;
  else
    result := FFlip;
  end;
end;

{ ------------------------------------------------------------------------------ }

function TKitty.MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean;
var
  LMap: TTextureMap;
  LSpeed: integer;
  oldflip: boolean;
begin
  oldflip := FFlip;
  result := true;
  try
    LMap := FTextures[FKittyTexture];
    LSpeed := 1;

    if not(FDir in [cJump, cFall, cStay]) then
    begin
      inc(FMoved, LSpeed);
      if FMoved > 200 then
      begin
        RandomTurn;
        FMoved := 0;
        Exit;
      end;
    end;

    case FDir of
      cFall:
        begin
          FKittyTexture := GetTexture(cktJump);
          Y := Y + FSpeed;
          if (Y + AHeight - GetBottomPadding >= AArea.Bottom) then
          begin
            FSpeed := 0;
            FDir := cJump;
            Y := AArea.Bottom - AHeight + GetBottomPadding;
          end
          else if FSpeed < 25 then
            inc(FSpeed);
        end;
      cJump:
        begin
          if Random(300) = 3 then
            RandomTurn;
        end;
      cStay:
        begin
          if (LMap.Current.Index = LMap.Current.Last) then
          begin
            if FNext = cStay then
              FNext := GetRandomDirection;
            FDir := FNext;
            FTextures[GetTexture(cktFly)].Current.Reset;
            FKittyTexture := GetTexture(cktFly);
            FFlip := GetFlipByDir(FNext);
          end;
        end;
      cUp:
        begin
          Y := Y - LSpeed;
          if Y < AArea.Top then
          begin
            FDir := cDown;
          end;
        end;
      cDown:
        begin
          Y := Y + LSpeed;
          if AArea.Height - Y < AHeight then
          begin
            FDir := cUp;
          end;
        end;
      cLeft:
        begin
          X := X - LSpeed;
          if X < AArea.Left then
          begin
            TurnRight;
          end;
        end;
      cRight:
        begin
          X := X + LSpeed;
          if AArea.Width - X < AWidth then
          begin
            TurnLeft;
          end;
        end;
    end;
  finally
    if FFlip and not oldflip then
    begin
      X := X + 23;
    end
    else if not FFlip and oldflip then
    begin
      X := X - 23;
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

class function TKitty.Name: string;
begin
  result := 'Kitty';
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.Ball;
begin
  FKittyTexture := GetTexture(cktBall);
  FDir := cStay;
  FTextures[GetTexture(cktBall)].Current.Reset;
  FFlip := GetFlipByDir(FNext);
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.TurnRight;
begin
  FNext := cRight;
  Ball;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.TurnLeft;
begin
  FNext := cLeft;
  Ball;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.Turn;
begin
  FSmall := Random(2) = 1;
  if (FDir in [cFall, cJump]) then
    RandomTurn
  else
    FDir := cFall
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.RandomTurn;
begin
  FNext := GetRandomDirection;
  Ball;
end;

{ ------------------------------------------------------------------------------ }

destructor TKitty.Destroy;
begin
  DeInitTextures;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.Drop;
begin
  if FDir = cJump then
    FDir := cFall;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.Hover(const AStart: boolean);
begin
  // inherited;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.DeInitTextures;
var
  Ltexture: TKittyTexture;
begin
  inherited;
  for Ltexture := Low(TKittyTexture) to High(TKittyTexture) do
    if (FTextures[Ltexture] <> nil) then
    begin
      FTextures[Ltexture].Free;
      FTextures[Ltexture] := nil;
    end;
end;

{ ------------------------------------------------------------------------------ }

function TKitty.GetSizeFloat(const ATexture: TKittyTexture): single;
begin
  case FSize of
    cSmall:
      result := KittyTextures[ATexture].ZoomSmall;
  else
    result := KittyTextures[ATexture].Zoom;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.UpdateSizeFloat;
var
  Ltexture: TKittyTexture;
begin
  for Ltexture := Low(TKittyTexture) to High(TKittyTexture) do
    FTextures[Ltexture].Size := GetSizeFloat(Ltexture);
end;

{ ------------------------------------------------------------------------------ }

class function TKitty.WindowHeight: integer;
begin
  result := Kitty_Height;
end;

{ ------------------------------------------------------------------------------ }

class function TKitty.WindowWidth: integer;
begin
  result := Kitty_Width;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.InitTextures(const APath: string);
var
  Ltexture: TKittyTexture;
  Ltexmap: TMapInfo;
begin
  inherited;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Kitty InitTextures');
{$ENDIF}
  for Ltexture := Low(TKittyTexture) to High(TKittyTexture) do
  begin
    Ltexmap := KittyTextures[Ltexture];
{$IFDEF ALLINONE}
    FTextures[Ltexture].LoadFromRes(KittyTextures[Ltexture].ResID, //
{$ELSE}
    FTextures[Ltexture].LoadFromFilename(APath + Kitty_Path + '\' + Ltexmap.ResFile, //
{$ENDIF}
      Ltexmap.Rows, //
      Ltexmap.Cols, //
      Ltexmap.FreeSpace, GetSizeFloat(Ltexture));
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TKitty.RenderObj;
var
  LMap: TTextureMap;
begin
  LMap := FTextures[FKittyTexture];
  if FKittyTexture <> FLastTexture then
  begin
    FLastTexture := FKittyTexture;
    LMap.Bind;
  end;
  LMap.Render(LMap.Current.Next, FFlip)
end;

{ ------------------------------------------------------------------------------ }

end.
