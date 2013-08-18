;retrieve version of the program from exe
#define AppVersion GetFileVersion("run\AwsmBttrflyEx.exe")
#define AppVersion Copy(AppVersion, 1, RPos('.', AppVersion) - 1)
#define AppVersion Copy(AppVersion, 1, RPos('.', AppVersion) - 1)
 
[Setup]
AppId={{7F446740-486C-458F-8C77-3B95DDA83762}
AppVerName=AwsmBttrfly v.{#AppVersion}
AppVersion=AwsmBttrfly v.{#AppVersion}
UninstallDisplayName=AwsmBttrfly
VersionInfoTextVersion={#AppVersion}
OutputBaseFilename=AwsmBttrflySetup{#AppVersion}
VersionInfoVersion={#AppVersion}
AppName=AwsmBttrfly
AppPublisher=ffalt
AppPublisherURL=https://github.com/ffalt/awsmbttrfly
AppSupportURL=https://github.com/ffalt/awsmbttrfly
AppUpdatesURL=https://github.com/ffalt/awsmbttrfly/tree/master/dist
DefaultDirName={pf}\AwsmBttrfly
OutputDir=.\dist
AppCopyright=ffalt
AppMutex=AwsmBttrfly.Mtx
UsePreviousUserInfo=false
UninstallDisplayIcon={app}\AwsmBttrflyEx.exe
UpdateUninstallLogAppName=true
EnableDirDoesntExistWarning=false
AllowRootDirectory=true
UsePreviousAppDir=true
UninstallLogMode=append
DisableStartupPrompt=true
SolidCompression=true
Compression=lzma
VersionInfoCompany=ffalt
VersionInfoDescription=AwsmBttrfly
ShowLanguageDialog=no
DirExistsWarning=no
ShowTasksTreeLines=true
PrivilegesRequired=poweruser
UseSetupLdr=true
InternalCompressLevel=ultra
VersionInfoCopyright=ffalt
UsePreviousGroup=False
DisableProgramGroupPage=yes

[Languages]
Name: de; MessagesFile: compiler:\Languages\German.isl

[CustomMessages]
CreateShortcutIcons=Shortcut Icons:
CreateDesktopIcon=Create a &desktop icon
CreateStartMenuIcon=Create a &startmenu icon
CreateQuickStartIcon=Create a &quickstart icon
de.CreateDesktopIcon=Verknüpfung auf &Desktop erstellen
de.CreateStartMenuIcon=Verknüpfung im &Startmenü erstellen
de.CreateQuickStartIcon=Verknüpfung in der &Schnellstart-Leiste erstellen
de.CreateShortcutIcons=Verknüpfungen:

[Tasks]
Name: desktopicon; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:CreateShortcutIcons}"
Name: startmenuicon; Description: "{cm:CreateStartMenuIcon}"; GroupDescription: "{cm:CreateShortcutIcons}"
Name: quicklaunchicon; Description: "{cm:CreateQuickStartIcon}"; OnlyBelowVersion: 0,6; GroupDescription: "{cm:CreateShortcutIcons}"

[Files]
Source: run\AwsmBttrflyEx.exe; DestDir: {app}; Flags: ignoreversion
Source: run\images\butterfly\*.*; DestDir: {app}\images\butterfly; Flags: ignoreversion recursesubdirs createallsubdirs
Source: run\images\caterpillar\*.*; DestDir: {app}\images\caterpillar; Flags: ignoreversion recursesubdirs createallsubdirs
Source: run\images\kitty\*.*; DestDir: {app}\images\kitty; Flags: ignoreversion recursesubdirs createallsubdirs
Source: run\images\milk\*.*; DestDir: {app}\images\milk; Flags: ignoreversion recursesubdirs createallsubdirs
Source: run\images\piggy\*.*; DestDir: {app}\images\piggy; Flags: ignoreversion recursesubdirs createallsubdirs
Source: run\images\piglet\*.*; DestDir: {app}\images\piglet; Flags: ignoreversion recursesubdirs createallsubdirs
Source: run\sounds\*.*; DestDir: {app}\sounds; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: {userstartmenu}\AwsmBttrfly; Filename: {app}\AwsmBttrflyEx.exe; Tasks: startmenuicon; IconIndex: 0; Flags: useapppaths; WorkingDir: {app}
Name: {userdesktop}\AwsmBttrfly; Filename: {app}\AwsmBttrflyEx.exe; Tasks: desktopicon; IconIndex: 0; Flags: useapppaths; WorkingDir: {app}
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\AwsmBttrfly; Filename: {app}\AwsmBttrflyEx.exe; OnlyBelowVersion: 0,6; Tasks: quicklaunchicon; IconIndex: 0; Flags: useapppaths; WorkingDir: {app}

