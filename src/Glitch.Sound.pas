unit Glitch.Sound;

interface

type
  TSound = (cpLa, cpBounce, cpAhh, cpDrink, cpNibble);

const
{$IFDEF ALLINONE}
  ResIds: array [TSound] of string = ('LA', 'BOUNCE', 'AHH', 'DRINK', 'NIBBLE');
{$ELSE}
  ResFiles: array [TSound] of string = ( //
    'la.wav', //
    'bounce.wav', //
    'ahh.wav', //
    'drink.wav', //
    'nibble.wav' //
    );
{$ENDIF}
procedure Play(snd: TSound);

var
  SoundPath: string;

implementation

uses
  Winapi.Windows,
  Glitch.Utils;

const
{$EXTERNALSYM SND_ASYNC}
  SND_ASYNC = $0001; { play asynchronously }
{$EXTERNALSYM SND_MEMORY}
  SND_MEMORY = $0004; { lpszSoundName points to a memory file }
{$EXTERNALSYM SND_RESOURCE}
  SND_RESOURCE = $00040004; { name is resource name or atom }

  { ------------------------------------------------------------------------------ }

{$EXTERNALSYM PlaySound}
function PlaySound(pszSound: PWideChar; hmod: HMODULE; fdwSound: DWORD): BOOL; stdcall; external 'winmm.dll' Name 'PlaySoundW';

{ ------------------------------------------------------------------------------ }

{$IFDEF ALLINONE}

procedure Play(snd: TSound);
begin
  if not PlaySound(PChar(ResIds[snd]), hInstance, SND_ASYNC or SND_MEMORY or SND_RESOURCE) then
  begin
{$IFDEF DEBUG}
    Glitch.Utils.Log('No sound ' + ResIds[snd] + ' :(');
{$ENDIF}
  end;
end;

{$ELSE}

procedure Play(snd: TSound);
begin
  if not PlaySound(PChar(SoundPath + ResFiles[snd]), hInstance, SND_ASYNC) then
  begin
{$IFDEF DEBUG}
    Glitch.Utils.Log('No sound ' + SoundPath + ResFiles[snd] + ' :(');
{$ENDIF}
  end;
end;

{$ENDIF}

{ ------------------------------------------------------------------------------ }

end.
