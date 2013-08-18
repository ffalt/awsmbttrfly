program AwsmBttrflyStandalone;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}

uses
  Glitch.Main in 'src\Glitch.Main.pas',
  Glitch.Sprite.Butterfly in 'src\Glitch.Sprite.Butterfly.pas',
  Glitch.Texture in 'src\Glitch.Texture.pas',
  Glitch.Consts in 'src\Glitch.Consts.pas',
  Glitch.Application in 'src\Glitch.Application.pas',
  Glitch.Sound in 'src\Glitch.Sound.pas',
  Glitch.Sprite in 'src\Glitch.Sprite.pas',
  Glitch.Utils in 'src\Glitch.Utils.pas',
  KOL_png in 'src\kol\KOL_png.pas',
  KOL_zlib in 'src\kol\KOL_zlib.pas',
  Glitch.Sprite.Milk in 'src\Glitch.Sprite.Milk.pas',
  Glitch.Utils.IntHash in 'src\Glitch.Utils.IntHash.pas',
  Glitch.Sprite.Caterpillar in 'src\Glitch.Sprite.Caterpillar.pas',
  KOL_glBitmap in 'src\kol\KOL_glBitmap.pas',
  KOL in 'src\kol\KOL.pas',
  KOL_err in 'src\kol\KOL_err.pas',
  KOL_gl in 'src\kol\KOL_gl.pas',
  Glitch.Sprite.Piggy in 'src\Glitch.Sprite.Piggy.pas',
  Glitch.Dialog in 'src\Glitch.Dialog.pas',
  Glitch.Sprite.Kitty in 'src\Glitch.Sprite.Kitty.pas',
  Glitch.Sprite.Piglet in 'src\Glitch.Sprite.Piglet.pas';

{$R 'AwsmBttrfly.res'}

begin
  WinMain(hInstance, System.hPrevInst, System.CmdLine, System.CmdShow);

end.
