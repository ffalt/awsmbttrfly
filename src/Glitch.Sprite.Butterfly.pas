unit Glitch.Sprite.Butterfly;

interface

uses
  Winapi.Windows,
  Winapi.OpenGL,
  Glitch.Sprite,
  Glitch.Texture,
  Glitch.Consts;

type
  TButterflyTexture = ( //
    cbtAngle1, //
    cbtAngle2, //
    cbtRooked, //
    cbtSide, //
    cbtTop, //
    cbtRestAngle1, //
    cbtRestAngle2, //
    cbtRestTop);

const
  Butterfly_Size = 2;
  Butterfly_SizeSmall = 1.5;
  Butterfly_Width: integer = 70;
  Butterfly_Height: integer = 70;
  Butterfly_Path: string = 'butterfly';
  ButterflyTextures: array [TButterflyTexture] of TMapInfo = ( //
    (ResID: 1000; ResFile: 'npc_butterfly__x1_fly-angle1_png_1354829526.png'; Rows: 3; Cols: 12; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall; FreeSpace: 2), //
    (ResID: 1001; ResFile: 'npc_butterfly__x1_fly-angle2_png_1354829527.png'; Rows: 2; Cols: 10; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall), //
    (ResID: 1002; ResFile: 'npc_butterfly__x1_fly-rooked_png_1354829525.png'; Rows: 1; Cols: 14; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall), //
    (ResID: 1003; ResFile: 'npc_butterfly__x1_fly-side_png_1354829525.png'; Rows: 1; Cols: 12; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall), //
    (ResID: 1004; ResFile: 'npc_butterfly__x1_fly-top_png_1354829528.png'; Rows: 7; Cols: 13; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall; FreeSpace: 4), //
    (ResID: 1005; ResFile: 'npc_butterfly__x1_rest-angle1_png_1354829530.png'; Rows: 1; Cols: 6; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall), //
    (ResID: 1006; ResFile: 'npc_butterfly__x1_rest-angle2_png_1354829531.png'; Rows: 1; Cols: 10; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall), //
    (ResID: 1007; ResFile: 'npc_butterfly__x1_rest-top_png_1354829532.png'; Rows: 3; Cols: 14; Zoom: Butterfly_Size; ZoomSmall: Butterfly_SizeSmall) //
    );

type
  TDirection = (cLeft, cRight, cLeftUp, cLeftDown, cRightUp, cRightDown);

  TButterfly = class(TGLObjectDraw)
  private
    FDir: TDirection;
    FHover: boolean;
    FWillChangeDirection: boolean;
    FWillChangeDirectionCounter: integer;
    FTextures: array [TButterflyTexture] of TTextureMap;
    FLastMap: TTextureMap;
    function getFlipByDirection(dir: TDirection): boolean;
    procedure MoveButterfly(var X, Y: integer; const AWidth, AHeight: integer; AArea: TRect);
    function RandomFlyPosition(const AWidth, AHeight: integer; AArea: TRect): TPoint;
    function GetSizeFloat(Ateaxture: TButterflyTexture): single;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function WindowWidth: integer; override;
    class function WindowHeight: integer; override;
    class function Name:string; override;
    procedure UpdateSizeFloat; override;
    procedure InitTextures(const APath: string); override;
    procedure DeInitTextures; override;
    procedure Drop; override;
    procedure Hover(const AStart: boolean); override;
    procedure RenderObj; override;
    function MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean; override;
    function StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint; override;
    property Direction: TDirection read FDir write FDir;
  end;

implementation

uses
  Glitch.Utils;

{ ------------------------------------------------------------------------------ }

constructor TButterfly.Create;
var
  Ltexture: TButterflyTexture;
begin
  inherited;
  FWillChangeDirection := false;
  FWillChangeDirectionCounter := 0;
  FHover := false;
  FDir := cLeft;
  FStartPos.X := -1;
  FStartPos.Y := -1;
  for Ltexture := Low(TButterflyTexture) to High(TButterflyTexture) do
    FTextures[Ltexture] := TTextureMap.Create;
end;

{ ------------------------------------------------------------------------------ }

function TButterfly.StartPos(const AWidth, AHeight: integer; AArea: TRect): TPoint;
begin
  if (FStartPos.X = -1) and (FStartPos.Y = -1) then
    FStartPos := RandomFlyPosition(AWidth, AHeight, AArea);
  result := FStartPos;
end;

{ ------------------------------------------------------------------------------ }

function TButterfly.RandomFlyPosition(const AWidth, AHeight: integer; AArea: TRect): TPoint;
begin
  case Random(4) of
    0:
      begin
        result.X := AArea.Width - AWidth - 100;
        result.Y := AArea.Height - AHeight - 100;
        self.Direction := cLeft;
      end;
    1:
      begin
        result.X := AArea.Width - AWidth - 100;
        result.Y := AArea.Top + 100;
        self.Direction := cLeft;
      end;
    2:
      begin
        result.X := AArea.Left + 100;
        result.Y := AArea.Height - AHeight - 100;
        self.Direction := cRight;
      end;
    3:
      begin
        result.X := AArea.Left + 100;
        result.Y := AArea.Top + 100;
        self.Direction := cRight;
      end;
  else
    begin
      result.X := (AArea.Width - AWidth) div 2;
      result.Y := (AArea.Height - AWidth) div 2;
      self.Direction := cLeft;
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.Hover(const AStart: boolean);
begin
  FHover := AStart;
end;

{ ------------------------------------------------------------------------------ }

function TButterfly.MoveObj(var X, Y: integer; const AWindowHandle: HWND; const AWidth, AHeight: integer; AArea: TRect): boolean;
begin
  if not FHover then
  begin
    MoveButterfly(X, Y, AWidth, AHeight, AArea);
    result := true;
  end
  else
  begin
    if not IsMouseInRect(AWindowHandle, X, Y, AWidth, AHeight) then
    begin
      FHover := false;
      FWillChangeDirectionCounter := 20;
    end;
    result := false;
  end;
end;

{------------------------------------------------------------------------------}

class function TButterfly.Name: string;
begin
  result := 'Butterfly';
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.MoveButterfly(var X, Y: integer; const AWidth, AHeight: integer; AArea: TRect);

  procedure CheckTurn;
  begin
    if FWillChangeDirection then
    begin
      FWillChangeDirection := false;
      FWillChangeDirectionCounter := 10;
    end;
  end;

  procedure PrepareTurn;
  begin
    FWillChangeDirection := true;
    FWillChangeDirectionCounter := 0;
  end;

const
  cMaxR = 100;
  cPercent = 4;
{$IFDEF DEBUG}
  // var
  // old: TDirection;
{$ENDIF}
var
  LSpeed: integer;
begin
{$IFDEF DEBUG}
  // old := FDir;
{$ENDIF}
  if FWillChangeDirection then
    LSpeed := 1
  else
    LSpeed := 2;
  case FDir of
    cLeft, cLeftUp, cLeftDown:
      begin
        X := X - LSpeed;
        if X < AArea.Left then
        begin
          CheckTurn;
          X := AArea.Left;
          case FDir of
            cLeft:
              begin
                case Random(2) of
                  0:
                    FDir := cRight;
                  1:
                    FDir := cRightUp;
                  2:
                    FDir := cRightDown;
                end;
              end;
            cLeftUp:
              FDir := cRightUp;
            cLeftDown:
              FDir := cRightDown;
          end;
        end
        else if X - Global_AreaBorder < AArea.Left then
        begin
          PrepareTurn;
        end;
      end;
    cRight, cRightUp, cRightDown:
      begin
        X := X + LSpeed;
        if AArea.Width - X < AWidth then
        begin
          CheckTurn;
          X := AArea.Width - AWidth;
          case FDir of
            cRight:
              begin
                case Random(2) of
                  0:
                    FDir := cLeft;
                  1:
                    FDir := cLeftUp;
                  2:
                    FDir := cLeftDown;
                end;
              end;
            cRightUp:
              FDir := cLeftUp;
            cRightDown:
              FDir := cLeftDown;
          end;
        end
        else if AArea.Width - X - Global_AreaBorder < AWidth then
        begin
          PrepareTurn;
        end;
      end;
  end;
  case FDir of
    cLeftUp, cRightUp:
      begin
        Y := Y - LSpeed;
        if Y < AArea.Top then
        begin
          CheckTurn;
          Y := AArea.Top;
          if FDir = cLeftUp then
            FDir := cLeftDown
          else
            FDir := cRightDown;
        end
        else if Y - Global_AreaBorder < AArea.Top then
        begin
          PrepareTurn;
        end;
      end;
    cLeftDown, cRightDown:
      begin
        Y := Y + LSpeed;
        if AArea.Height - Y < AHeight then
        begin
          CheckTurn;
          Y := AArea.Height - AHeight;
          if FDir = cLeftDown then
            FDir := cLeftUp
          else
            FDir := cRightUp;
        end
        else if AArea.Height - Y - Global_AreaBorder < AHeight then
        begin
          PrepareTurn;
        end;
      end;
  end;
  case FDir of
    cLeft:
      begin
        if Random(cMaxR) < cPercent then
        begin
          if Random(1) = 0 then
            FDir := cLeftDown
          else
            FDir := cLeftUp;
          CheckTurn;
        end;
      end;
    cRight:
      begin
        if Random(cMaxR) < cPercent then
        begin
          if Random(1) = 0 then
            FDir := cRightDown
          else
            FDir := cRightUp;
          CheckTurn;
        end;
      end;
    cLeftUp:
      begin
        if Random(cMaxR) < cPercent then
        begin
          FDir := cLeftDown;
          CheckTurn;
        end;
      end;
    cLeftDown:
      begin
        if Random(cMaxR) < cPercent then
        begin
          FDir := cLeftUp;
          CheckTurn;
        end;
      end;
    cRightUp:
      begin
        if Random(cMaxR) < cPercent then
        begin
          FDir := cRightDown;
          CheckTurn;
        end;
      end;
    cRightDown:
      begin
        if Random(cMaxR) < cPercent then
        begin
          FDir := cRightUp;
          CheckTurn;
        end;
      end;
  end;
{$IFDEF DEBUG}
  // if FDir <> old then
  // Utils.Log('Changed Direction: ' + GetEnumName(TypeInfo(TDirection), integer(FDir)));
{$ENDIF}
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.InitTextures(const APath: string);
var
  Ltexture: TButterflyTexture;
  Ltexmap: TMapInfo;
begin
  inherited;
{$IFDEF DEBUG}
  Glitch.Utils.Log('Butterfly InitTextures');
{$ENDIF}
  for Ltexture := Low(TButterflyTexture) to High(TButterflyTexture) do
  begin
    Ltexmap := ButterflyTextures[Ltexture];
{$IFDEF ALLINONE}
    FTextures[Ltexture].LoadFromRes(Ltexmap.ResID, //
{$ELSE}
    FTextures[Ltexture].LoadFromFilename(APath + Butterfly_Path + '\' + Ltexmap.ResFile, //
{$ENDIF}
      Ltexmap.Rows, //
      Ltexmap.Cols, //
      Ltexmap.FreeSpace, GetSizeFloat(Ltexture));
  end;
  glColor4f(0.7, 0.7, 0.7, 1.0);
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.DeInitTextures;
var
  Ltexture: TButterflyTexture;
begin
  inherited;
  for Ltexture := Low(TButterflyTexture) to High(TButterflyTexture) do
    if FTextures[Ltexture] <> nil then
    begin
      FTextures[Ltexture].Free;
      FTextures[Ltexture] := nil;
    end;
end;

{ ------------------------------------------------------------------------------ }

destructor TButterfly.Destroy;
begin
  DeInitTextures;
  inherited;
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.Drop;
begin
  // nop
end;

{ ------------------------------------------------------------------------------ }

function TButterfly.getFlipByDirection(dir: TDirection): boolean;
begin
  result := (dir in [cLeft, cLeftUp, cLeftDown]);
end;

{ ------------------------------------------------------------------------------ }

function TButterfly.GetSizeFloat(Ateaxture: TButterflyTexture): single;
begin
  case FSize of
    cSmall:
      result := ButterflyTextures[Ateaxture].ZoomSmall;
  else
    result := ButterflyTextures[Ateaxture].Zoom;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.UpdateSizeFloat;
var
  Lteaxture: TButterflyTexture;
begin
  for Lteaxture := Low(TButterflyTexture) to High(TButterflyTexture) do
    FTextures[Lteaxture].Size := GetSizeFloat(Lteaxture);
end;

{ ------------------------------------------------------------------------------ }

class function TButterfly.WindowHeight: integer;
begin
  result := Butterfly_Height;
end;

{ ------------------------------------------------------------------------------ }

class function TButterfly.WindowWidth: integer;
begin
  result := Butterfly_Width;
end;

{ ------------------------------------------------------------------------------ }

procedure TButterfly.RenderObj;
var
  LMap: TTextureMap;
begin
  if FHover then
    LMap := FTextures[cbtTop]
  else if FWillChangeDirection or (FWillChangeDirectionCounter > 0) then
  begin
    // if (FWillChangeDirectionCounter > 5) then
    // LMap := FTextures[cbtAngle2]
    // else
    LMap := FTextures[cbtAngle1];
    dec(FWillChangeDirectionCounter);
  end
  else
    LMap := FTextures[cbtSide];
  if FLastMap <> LMap then
  begin
    FLastMap := LMap;
    LMap.Bind;
  end;
  LMap.Render(LMap.Current.Next, getFlipByDirection(FDir));
end;

{ ------------------------------------------------------------------------------ }

end.
