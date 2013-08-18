{ ***********************************************************
  glBitmap by Steffen Xonna aka Lossy eX (2003-2008)
  http://www.opengl24.de/index.php?cat=header&file=glbitmap
  ------------------------------------------------------------
  The contents of this file are used with permission, subject to
  the Mozilla Public License Version 1.1 (the "License"); you may
  not use this file except in compliance with the License. You may
  obtain a copy of the License at
  http://www.mozilla.org/MPL/MPL-1.1.html
  ------------------------------------------------------------
  Version 2.0.3
  ------------------------------------------------------------
  History
  21-03-2010
  - The define GLB_DELPHI dosn't check versions anymore. If you say you are using delphi
  then it's your problem if that isn't true. This prevents the unit for incompatibility
  with newer versions of Delphi.
  - Problems with D2009+ resolved (Thanks noeska and all i forgot)
  - GetPixel isn't set if you are loading textures inside the constructor (Thanks Wilson)
  10-08-2008
  - AddAlphaFromglBitmap used the custom pointer instead the imagedatapointer (Thanks Wilson)
  - Additional Datapointer for functioninterface now has the name CustomData
  24-07-2008
  - AssigneAlphaToBitmap overwrites his own palette (Thanks Wilson)
  - If you load an texture from an file the property Filename will be set to the name of the file
  - Three new properties to attach custom data to the Texture objects
  - CustomName  (free for use string)
  - CustomNameW (free for use widestring)
  - CustomDataPointer (free for use pointer to attach other objects or complex structures)
  27-05-2008
  - RLE TGAs loaded much faster
  26-05-2008
  - fixed some problem with reading RLE TGAs.
  21-05-2008
  - function clone now only copys data if it's assigned and now it also copies the ID
  - it seems that lazarus dont like comments in comments.
  01-05-2008
  - It's possible to set the id of the texture
  - define GLB_NO_NATIVE_GL deactivated by default
  27-04-2008
  - Now supports the following libraries
  - SDL and SDL_image
  - libPNG
  - libJPEG
  - Linux compatibillity via free pascal compatibility (delphi sources optional)
  - BMPs now loaded manuel
  - Large restructuring
  - Property DataPtr now has the name Data
  - Functions are more flexible between RGB(A) and BGR(A). RGB can be saved as Bitmap and will be saved as BGR
  - Unused Depth removed
  - Function FreeData to freeing image data added
  24-10-2007
  - ImageID flag of TGAs was ignored. (Thanks Zwoetzen)
  15-11-2006
  - Function SetBorderColor implemented (only used by opengl if wrap is set to GL_CLAMP_TO_BORDER)
  - Function AddAlphaFromValue implemented to use an fixed Value as Alphachannel
  - Function ReadOpenGLExtension is now only intern
  29-06-2006
  - pngimage now disabled by default like all other versions.
  26-06-2006
  - Setting up an anisotropic filter of 0 isnt allowed by nvidia (Thanks Ogridi)
  22-06-2006
  - Fixed some Problem with Delphi 5
  - Now uses the newest version of pngimage. Makes saving pngs much easier.
  22-03-2006
  - Property IsCompressed and Size removed. Not really supported by Spec (Thanks Ogridi)
  09-03-2006
  - Internal Format ifDepth8 added
  - function GrabScreen now supports all uncompressed formats
  31-01-2006
  - AddAlphaFromglBitmap implemented
  29-12-2005
  - LoadFromResource and LoadFromResourceId now needs an Instance and an ResourceType (for ID)
  28-12-2005
  - Width, Height and Depth internal changed to TglBitmapPixelPosition.
  property Width, Height, Depth are still existing and new property Dimension are avail
  11-12-2005
  - Added native OpenGL Support. Breaking the dglOpenGL "barrier".
  19-10-2005
  - Added function GrabScreen to class TglBitmap2D
  18-10-2005
  - Added support to Save images
  - Added function Clone to Clone Instance
  11-10-2005
  - Functions now works with Cardinals for each channel. Up to 32 Bits per channel.
  Usefull for Future
  - Several speed optimizations
  09-10-2005
  - Internal structure change. Loading of TGA, PNG and DDS improved.
  Data, format and size will now set directly with SetDataPtr.
  - AddFunc now works with all Types of Images and Formats
  - Some Funtions moved to Baseclass TglBitmap
  06-10-2005
  - Added Support to decompress DXT3 and DXT5 compressed Images.
  - Added Mapping to convert data from one format into an other.
  05-10-2005
  - Added method ConvertTo in Class TglBitmap2D. Method allows to convert every
  supported Input format (supported by GetPixel) into any uncompresed Format
  - Added Support to decompress DXT1 compressed Images.
  - SwapColors replaced by ConvertTo
  04-10-2005
  - Added Support for compressed DDSs
  - Added new internal formats (DXT1, DXT3, DXT5)
  29-09-2005
  - Parameter Components renamed to InternalFormat
  23-09-2005
  - Some AllocMem replaced with GetMem (little speed change)
  - better exception handling. Better protection from memory leaks.
  22-09-2005
  - Added support for Direct Draw Surfaces (.DDS) (uncompressed images only)
  - Added new internal formats (RGB8, RGBA8, RGBA4, RGB5A1, RGB10A2, R5G6B5)
  07-09-2005
  - Added support for Grayscale textures
  - Added internal formats (Alpha, Luminance, LuminanceAlpha, BGR8, BGRA8)
  10-07-2005
  - Added support for GL_VERSION_2_0
  - Added support for GL_EXT_texture_filter_anisotropic
  04-07-2005
  - Function FillWithColor fills the Image with one Color
  - Function LoadNormalMap added
  30-06-2005
  - ToNormalMap allows to Create an NormalMap from the Alphachannel
  - ToNormalMap now supports Sobel (nmSobel) function.
  29-06-2005
  - support for RLE Compressed RGB TGAs added
  28-06-2005
  - Class TglBitmapNormalMap added to support Normalmap generation
  - Added function ToNormalMap in class TglBitmap2D to genereate normal maps from textures.
  3 Filters are supported. (4 Samples, 3x3 and 5x5)
  16-06-2005
  - Method LoadCubeMapClass removed
  - LoadCubeMap returnvalue is now the Texture paramter. Such as LoadTextures
  - virtual abstract method GenTexture in class TglBitmap now is protected
  12-06-2005
  - now support DescriptionFlag in LoadTga. Allows vertical flipped images to be loaded as normal
  10-06-2005
  - little enhancement for IsPowerOfTwo
  - TglBitmap1D.GenTexture now tests NPOT Textures
  06-06-2005
  - some little name changes. All properties or function with Texture in name are
  now without texture in name. We have allways texture so we dosn't name it.
  03-06-2005
  - GenTexture now tests if texture is NPOT and NPOT-Texture are supported or
  TextureTarget is GL_TEXTURE_RECTANGLE. Else it raised an exception.
  02-06-2005
  - added support for GL_ARB_texture_rectangle, GL_EXT_texture_rectangle and GL_NV_texture_rectangle
  25-04-2005
  - Function Unbind added
  - call of SetFilter or SetTextureWrap if TextureID exists results in setting properties to opengl texture.
  21-04-2005
  - class TglBitmapCubeMap added (allows to Create Cubemaps)
  29-03-2005
  - Added Support for PNG Images. (http://pngdelphi.sourceforge.net/)
  To Enable png's use the define pngimage
  22-03-2005
  - New Functioninterface added
  - Function GetPixel added
  27-11-2004
  - Property BuildMipMaps renamed to MipMap
  21-11-2004
  - property Name removed.
  - BuildMipMaps is now a set of 3 values. None, GluBuildMipmaps and SGIS_generate_mipmap
  22-05-2004
  - property name added. Only used in glForms!
  26-11-2003
  - property FreeDataAfterGenTexture is now available as default (default = true)
  - BuildMipmaps now implemented in TglBitmap1D (i've forgotten it)
  - function MoveMemory replaced with function Move (little speed change)
  - several calculations stored in variables (little speed change)
  29-09-2003
  - property BuildMipsMaps added (default = True)
  if BuildMipMaps isn't set GenTextures uses glTexImage[12]D else it use gluBuild[12]dMipmaps
  - property FreeDataAfterGenTexture added (default = True)
  if FreeDataAfterGenTexture is set the texturedata were deleted after the texture was generated.
  - parameter DisableOtherTextureUnits of Bind removed
  - parameter FreeDataAfterGeneration of GenTextures removed
  12-09-2003
  - TglBitmap dosn't delete data if class was destroyed (fixed)
  09-09-2003
  - Bind now enables TextureUnits (by params)
  - GenTextures can leave data (by param)
  - LoadTextures now optimal
  03-09-2003
  - Performance optimization in AddFunc
  - procedure Bind moved to subclasses
  - Added new Class TglBitmap1D to support real OpenGL 1D Textures
  19-08-2003
  - Texturefilter and texturewrap now also as defaults
  Minfilter = GL_LINEAR_MIPMAP_LINEAR
  Magfilter = GL_LINEAR
  Wrap(str) = GL_CLAMP_TO_EDGE
  - Added new format tfCompressed to create a compressed texture.
  - propertys IsCompressed, TextureSize and IsResident added
  IsCompressed and TextureSize only contains data from level 0
  18-08-2003
  - Added function AddFunc to add PerPixelEffects to Image
  - LoadFromFunc now based on AddFunc
  - Invert now based on AddFunc
  - SwapColors now based on AddFunc
  16-08-2003
  - Added function FlipHorz
  15-08-2003
  - Added function LaodFromFunc to create images with function
  - Added function FlipVert
  - Added internal format RGB(A) if GL_EXT_bgra or OpenGL 1.2 isn't supported
  29-07-2003
  - Added Alphafunctions to calculate alpha per function
  - Added Alpha from ColorKey using alphafunctions
  28-07-2003
  - First full functionally Version of glBitmap
  - Support for 24Bit and 32Bit TGA Pictures added
  25-07-2003
  - begin of programming
  *********************************************************** }
unit KOL_glBitmap;

{ .$message warn 'Hey. I''m the glBitmap.pas and i need to be configured. My master tell me your preferences! ;)' }
// Please uncomment the defines below to configure the glBitmap to your preferences.
// If you have configured the unit you can uncomment the warning above.


// ###### Start of preferences ################################################

{ .$define GLB_NO_NATIVE_GL }
// To enable the dglOpenGL.pas Header
// With native GL then bindings are staticlly declared to support other headers
// or use the glBitmap inside of DLLs (minimize codesize).

{ .$define GLB_SDL }
// To enable the support for SDL_surfaces

{$define GLB_DELPHI}
// To enable the loading from resource  from Delphi (not lazarus)

{ .$define GLB_DELPHI_DIALOGS }

{ .$define GLB_DELPHI_GRAPHICS }
// To enable the support for TBitmap from Delphi (not lazarus)


// *** image libs ***

{ .$define GLB_SDL_IMAGE }
// To enable the support of SDL_image to load files. (READ ONLY)
// If you enable SDL_image all other libraries will be ignored!

{$define KOL_PNGIMAGE}
// to enable png support with the unit KOLPng (loading only)

{ .$define GLB_PNGIMAGE }
// to enable png support with the unit pngimage. You can download it from http://pngdelphi.sourceforge.net/
// if you enable pngimage the libPNG will be ignored

{ .$define GLB_LIB_PNG }
// to use the libPNG http://www.libpng.org/
// You will need an aditional header.
// http://www.opengl24.de/index.php?cat=header&file=libpng

{ .$define GLB_DELPHI_JPEG }
// if you enable delphi jpegs the libJPEG will be ignored

{ .$define GLB_LIB_JPEG }
// to use the libJPEG http://www.ijg.org/
// You will need an aditional header.
// http://www.opengl24.de/index.php?cat=header&file=libjpeg

// ###### End of preferences ##################################################


// ###### PRIVATE. Do not change anything. ####################################
// *** old defines for compatibility ***
{$ifdef NO_NATIVE_GL}
{$define GLB_NO_NATIVE_GL}
{$endif}
{$ifdef pngimage}
{$definde GLB_PNGIMAGE}
{$endif}
// *** Delphi Versions ***
{$ifdef fpc}
{$MODE Delphi}
{$ifdef CPUI386}
{$define CPU386}
{$asmmode INTEL}
{$endif}
{$ifndef WIN32}
{$linklib c}
{$endif}
{$endif}
// *** checking define combinations ***
{$ifdef GLB_SDL_IMAGE}
{$ifndef GLB_SDL}
{$message warn 'SDL_image won''t work without SDL. SDL will be activated.'}
{$define GLB_SDL}
{$endif}
{$ifdef GLB_PNGIMAGE}
{$message warn 'The unit pngimage will be ignored because you are using SDL_image.'}
{$undef GLB_PNGIMAGE}
{$endif}
{$ifdef GLB_DELPHI_JPEG}
{$message warn 'The unit JPEG will be ignored because you are using SDL_image.'}
{$undef GLB_DELPHI_JPEG}
{$endif}
{$ifdef GLB_LIB_PNG}
{$message warn 'The library libPNG will be ignored because you are using SDL_image.'}
{$undef GLB_LIB_PNG}
{$endif}
{$ifdef GLB_LIB_JPEG}
{$message warn 'The library libJPEG will be ignored because you are using SDL_image.'}
{$undef GLB_LIB_JPEG}
{$endif}
{$define GLB_SUPPORT_PNG_READ}
{$define GLB_SUPPORT_JPEG_READ}
{$endif}
{$ifdef GLB_PNGIMAGE}
{$ifdef GLB_LIB_PNG}
{$message warn 'The library libPNG will be ignored if you are using pngimage.'}
{$undef GLB_LIB_PNG}
{$endif}
{$define GLB_SUPPORT_PNG_READ}
{$define GLB_SUPPORT_PNG_WRITE}
{$endif}
{$ifdef KOL_PNGIMAGE}
{$ifdef GLB_LIB_PNG}
{$message warn 'The library libPNG will be ignored if you are using pngimage.'}
{$undef GLB_LIB_PNG}
{$endif}
{$ifdef GLB_PNGIMAGE}
{$message warn 'The unit pngimage will be ignored because you are using SDL_image.'}
{$undef GLB_PNGIMAGE}
{$endif}
{$define GLB_SUPPORT_PNG_READ}
{$endif}
{$ifdef GLB_LIB_PNG}
{$define GLB_SUPPORT_PNG_READ}
{$define GLB_SUPPORT_PNG_WRITE}
{$endif}
{$ifdef GLB_DELPHI_JPEG}
{$ifdef GLB_LIB_JPEG}
{$message warn 'The library libJPEG will be ignored if you are using the unit JPEG.'}
{$undef GLB_LIB_JPEG}
{$endif}
{$define GLB_SUPPORT_JPEG_READ}
{$define GLB_SUPPORT_JPEG_WRITE}
{$endif}
{$ifdef GLB_LIB_JPEG}
{$define GLB_SUPPORT_JPEG_READ}
{$define GLB_SUPPORT_JPEG_WRITE}
{$endif}
// *** general options ***
{$EXTENDEDSYNTAX ON}
{$LONGSTRINGS ON}
{$ALIGN ON}
{$ifndef fpc}
{$OPTIMIZATION ON}
{$endif}

interface

uses
  WinApi.OpenGL
  ,Kol_gl
{$IFDEF GLB_NO_NATIVE_GL} , dglOpenGL {$ENDIF}
{$IFDEF GLB_SDL} , SDL {$ENDIF}
{$IFDEF GLB_DELPHI} , WinApi.Windows {$ENDIF}
{$IFDEF GLB_DELPHI_GRAPHICS} , Graphics {$ENDIF}
{$IFDEF GLB_DELPHI_DIALOGS} , Dialogs {$ENDIF}
{$IFDEF GLB_DELPHI_SysUtils} , SysUtils {$ENDIF}
{$IFDEF GLB_SDL_IMAGE} , SDL_image {$ENDIF}
{$IFDEF GLB_PNGIMAGE} , pngimage {$ENDIF}
{$IFDEF KOL_PNGIMAGE} , kol, kol_png, kol_err {$ENDIF}
{$IFDEF GLB_LIB_PNG} , libPNG {$ENDIF}
{$IFDEF GLB_DELPHI_JPEG} , JPEG {$ENDIF}
{$IFDEF GLB_LIB_JPEG} , libJPEG {$ENDIF}
    ;

{$IFNDEF GLB_DELPHI_SysUtils}

const
  fmOpenRead = $0000;
  fmCreate = $FF00;
{$ENDIF}
{$IFNDEF GLB_DELPHI}

type
  HGLRC = Cardinal;
  DWORD = Cardinal;
  PDWORD = ^DWORD;

  TRGBQuad = packed record
    rgbBlue: Byte;
    rgbGreen: Byte;
    rgbRed: Byte;
    rgbReserved: Byte;
  end;
{$ENDIF}
{$IFNDEF GLB_NO_NATIVE_GL}
{$IFDEF GLB_DELPHI}

var
  gLastContext: HGLRC;
{$ENDIF}

  // Extensions
var
  GL_VERSION_1_2, //
    GL_VERSION_1_3, //
    GL_VERSION_1_4, //
    GL_VERSION_2_0, //
    GL_ARB_texture_border_clamp, //
    GL_ARB_texture_cube_map, //
    GL_ARB_texture_compression, //
    GL_ARB_texture_non_power_of_two, //
    GL_ARB_texture_rectangle, //
    GL_ARB_texture_mirrored_repeat, //
    GL_EXT_bgra, //
    GL_EXT_texture_edge_clamp, //
    GL_EXT_texture_cube_map, //
    GL_EXT_texture_compression_s3tc, //
    GL_EXT_texture_filter_anisotropic, //
    GL_EXT_texture_rectangle, //
    GL_NV_texture_rectangle, //
    GL_IBM_texture_mirrored_repeat, //
    GL_SGIS_generate_mipmap: Boolean;

var
  glCompressedTexImage2D: procedure(target: Cardinal; level: Integer; internalformat: Cardinal; width, height: Integer; border: Integer; imageSize: Integer; const Data: Pointer); {$IFDEF Win32}stdcall; {$ELSE}cdecl; {$ENDIF}
  glCompressedTexImage1D: procedure(target: Cardinal; level: Integer; internalformat: Cardinal; width: Integer; border: Integer; imageSize: Integer; const Data: Pointer); {$IFDEF Win32}stdcall; {$ELSE}cdecl; {$ENDIF}
  glGetCompressedTexImage: procedure(target: Cardinal; level: Integer; img: Pointer); {$IFDEF Win32}stdcall; {$ELSE}cdecl; {$ENDIF}

  {$ENDIF}

type
  // Exception
  EglBitmapException = Exception;
  EglBitmapSizeToLargeException = EglBitmapException;
  EglBitmapNonPowerOfTwoException = EglBitmapException;
  EglBitmapUnsupportedInternalFormat = EglBitmapException;

  // Functions
  TglBitmapPixelDesc = packed record
    RedRange: Cardinal;
    RedShift: Shortint;
    GreenRange: Cardinal;
    GreenShift: Shortint;
    BlueRange: Cardinal;
    BlueShift: Shortint;
    AlphaRange: Cardinal;
    AlphaShift: Shortint;
  end;

  TglBitmapPixelData = packed record
    Red: Cardinal;
    Green: Cardinal;
    Blue: Cardinal;
    Alpha: Cardinal;

    PixelDesc: TglBitmapPixelDesc;
  end;

  TglBitmapPixelPositionFields = set of (ffX, ffY);

  TglBitmapPixelPosition = record
    Fields: TglBitmapPixelPositionFields;
    X: Word;
    Y: Word;
  end;

const
  cNullSize: TglBitmapPixelPosition = (Fields: []; X: 0; Y: 0);

type
  TglBitmap = class;

  TglBitmapFunctionRec = record
    Sender: TglBitmap;
    Size: TglBitmapPixelPosition;
    Position: TglBitmapPixelPosition;
    Source: TglBitmapPixelData;
    Dest: TglBitmapPixelData;
    CustomData: Pointer;
  end;

  TglBitmapFunction = procedure(var FuncRec: TglBitmapFunctionRec);

  TglBitmapGetPixel = procedure(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData) of object;

  TglBitmapSetPixel = procedure(const Pos: TglBitmapPixelPosition; const Pixel: TglBitmapPixelData) of object;

  // Settings
  TglBitmapFileType = (
{$IFDEF GLB_SUPPORT_PNG_WRITE} ftPNG, {$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_WRITE}ftJPEG, {$ENDIF}
    ftDDS, ftTGA, ftBMP);
  TglBitmapFileTypes = set of TglBitmapFileType;

  TglBitmapFormat = (tfDefault, tf4BitsPerChanel, tf8BitsPerChanel, tfCompressed);
  TglBitmapMipMap = (mmNone, mmMipmap, mmMipmapGlu);
  TglBitmapNormalMapFunc = (nm4Samples, nmSobel, nm3x3, nm5x5);
  TglBitmapInternalFormat = (ifEmpty,
    // 4 Bit
    ifDXT1,
    // 8 Bit
    ifDXT3, ifDXT5, ifAlpha, ifLuminance, ifDepth8,
    // 16 Bit
    ifLuminanceAlpha, ifRGBA4, ifR5G6B5, ifRGB5A1,
    // 24 Bit
    ifBGR8, ifRGB8,
    // 32 Bit
    ifBGRA8, ifRGBA8, ifRGB10A2);

  // Pixelmapping
  TglBitmapMapFunc = procedure(const Pixel: TglBitmapPixelData; var pDest: pByte);
  TglBitmapUnMapFunc = procedure(var pData: pByte; var Pixel: TglBitmapPixelData);

  // Base Class
  TglBitmap = class
  protected
    fID: Cardinal;
    fTarget: Cardinal;
    fFormat: TglBitmapFormat;
    fMipMap: TglBitmapMipMap;
    fAnisotropic: Integer;
    fBorderColor: array [0 .. 3] of single;

    fDeleteTextureOnFree: Boolean;
    fFreeDataAfterGenTexture: Boolean;

    // Propertys
    fData: pByte;
    fInternalFormat: TglBitmapInternalFormat;
    fDimension: TglBitmapPixelPosition;

    fIsResident: Boolean;

    // Mapping
    fPixelSize: Integer;
    fRowSize: Integer;
    fUnmapFunc: TglBitmapUnMapFunc;
    fMapFunc: TglBitmapMapFunc;

    // Filtering
    fFilterMin: Integer;
    fFilterMag: Integer;

    // Texturwarp
    fWrapS: Integer;
    fWrapT: Integer;
    fWrapR: Integer;

    fGetPixelFunc: TglBitmapGetPixel;
    fSetPixelFunc: TglBitmapSetPixel;

    // custom data
    fFilename: String;
    fCustomName: String;
    fCustomNameW: WideString;
    fCustomDataPointer: Pointer;

    procedure SetDataPointer(NewData: pByte; Format: TglBitmapInternalFormat; width: Integer = -1; height: Integer = -1); virtual;

{$IFDEF GLB_SUPPORT_PNG_READ}
    function LoadPNG(Stream: PStream): Boolean; virtual;
{$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_READ}
    function LoadJPEG(Stream: PStream): Boolean; virtual;
{$ENDIF}
    function LoadDDS(Stream: PStream): Boolean; virtual;
    function LoadTGA(Stream: PStream): Boolean; virtual;
    function LoadBMP(Stream: PStream): Boolean; virtual;

{$IFDEF GLB_SUPPORT_PNG_WRITE}
    procedure SavePNG(Stream: PStream); virtual;
{$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_WRITE}
    procedure SaveJPEG(Stream: PStream); virtual;
{$ENDIF}
    procedure SaveDDS(Stream: PStream); virtual;
    procedure SaveTGA(Stream: PStream); virtual;
    procedure SaveBMP(Stream: PStream); virtual;

    procedure CreateID;
    procedure SetupParameters(var BuildWithGlu: Boolean);
    procedure SelectFormat(DataFormat: TglBitmapInternalFormat; var glFormat, glInternalFormat, glType: Cardinal; CanConvertImage: Boolean = True);

    procedure GenTexture(TestTextureSize: Boolean = True); virtual; abstract;

    procedure SetAnisotropic(const Value: Integer);
    procedure SetInternalFormat(const Value: TglBitmapInternalFormat);

    function FlipHorz: Boolean; virtual;
    function FlipVert: Boolean; virtual;

    function GetHeight: Integer;
    function GetWidth: Integer;

    function GetFileHeight: Integer;
    function GetFileWidth: Integer;

    property width: Integer read GetWidth;
    property height: Integer read GetHeight;

    property FileWidth: Integer read GetFileWidth;
    property FileHeight: Integer read GetFileHeight;
  public
    // propertys
    property ID: Cardinal read fID write fID;
    property target: Cardinal read fTarget write fTarget;
    property Format: TglBitmapFormat read fFormat write fFormat;
    property internalformat: TglBitmapInternalFormat read fInternalFormat write SetInternalFormat;
    property Dimension: TglBitmapPixelPosition read fDimension;

    property Data: pByte read fData;

    property MipMap: TglBitmapMipMap read fMipMap write fMipMap;
    property Anisotropic: Integer read fAnisotropic write SetAnisotropic;

    property DeleteTextureOnFree: Boolean read fDeleteTextureOnFree write fDeleteTextureOnFree;
    property FreeDataAfterGenTexture: Boolean read fFreeDataAfterGenTexture write fFreeDataAfterGenTexture;

    property IsResident: Boolean read fIsResident;

    // propertys for custom data
    property Filename: String read fFilename;
    property CustomName: String read fCustomName write fCustomName;
    property CustomNameW: WideString read fCustomNameW write fCustomNameW;
    property CustomDataPointer: Pointer read fCustomDataPointer write fCustomDataPointer;

    // Construction and Destructions Methods
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    constructor Create(); overload;
    constructor Create(Filename: String); overload;
    constructor Create(Stream: PStream); overload;
{$IFDEF GLB_DELPHI}
    constructor CreateFromResourceName(Instance: Cardinal; Resource: String; ResType: PChar = nil);
    constructor Create(Instance: Cardinal; Resource: String; ResType: PChar = nil); overload;
    constructor Create(Instance: Cardinal; ResourceID: Integer; ResType: PChar); overload;
{$ENDIF}
    constructor Create(Size: TglBitmapPixelPosition; Format: TglBitmapInternalFormat); overload;
    constructor Create(Size: TglBitmapPixelPosition; Format: TglBitmapInternalFormat; Func: TglBitmapFunction; CustomData: Pointer = nil); overload;

    function Clone: TglBitmap;

    procedure FreeData;

    // Loading Methods
    procedure LoadFromFile(Filename: String);
    procedure LoadFromStream(Stream: PStream); virtual;
{$IFDEF GLB_DELPHI}
    procedure LoadFromResource(Instance: Cardinal; Resource: String; ResType: PChar = nil);
    procedure LoadFromResourceID(Instance: Cardinal; ResourceID: Integer; ResType: PChar);
{$ENDIF}
    procedure LoadFromFunc(Size: TglBitmapPixelPosition; Func: TglBitmapFunction; Format: TglBitmapInternalFormat; CustomData: Pointer = nil);

    procedure SaveToFile(Filename: String; FileType: TglBitmapFileType);
    procedure SaveToStream(Stream: PStream; FileType: TglBitmapFileType); virtual;

    function AddFunc(Source: TglBitmap; Func: TglBitmapFunction; CreateTemp: Boolean; Format: TglBitmapInternalFormat; CustomData: Pointer = nil): Boolean; overload;
    function AddFunc(Func: TglBitmapFunction; CreateTemp: Boolean; CustomData: Pointer = nil): Boolean; overload;

{$IFDEF GLB_SDL}
    function AssignToSurface(out Surface: PSDL_Surface): Boolean;
    function AssignFromSurface(const Surface: PSDL_Surface): Boolean;
    function AssignAlphaToSurface(out Surface: PSDL_Surface): Boolean;

    function AddAlphaFromSurface(Surface: PSDL_Surface; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;
{$ENDIF}
{$IFDEF GLB_DELPHI_GRAPHICS}
    function AssignToBitmap(const Bitmap: TBitmap): Boolean;
    function AssignFromBitmap(const Bitmap: TBitmap): Boolean;
    function AssignAlphaToBitmap(const Bitmap: TBitmap): Boolean;

    function AddAlphaFromBitmap(Bitmap: TBitmap; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;
{$ENDIF}
    function AddAlphaFromFunc(Func: TglBitmapFunction; CustomData: Pointer = nil): Boolean; virtual;
    function AddAlphaFromFile(Filename: String; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;
    function AddAlphaFromStream(Stream: PStream; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;
{$IFDEF GLB_DELPHI}
    function AddAlphaFromResource(Instance: Cardinal; Resource: String; ResType: PChar = nil; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;
    function AddAlphaFromResourceID(Instance: Cardinal; ResourceID: Integer; ResType: PChar; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;
{$ENDIF}
    function AddAlphaFromglBitmap(glBitmap: TglBitmap; Func: TglBitmapFunction = nil; CustomData: Pointer = nil): Boolean;

    function AddAlphaFromColorKey(Red, Green, Blue: Byte; Deviation: Byte = 0): Boolean;
    function AddAlphaFromColorKeyRange(Red, Green, Blue: Cardinal; Deviation: Cardinal = 0): Boolean;
    function AddAlphaFromColorKeyFloat(Red, Green, Blue: single; Deviation: single = 0): Boolean;

    function AddAlphaFromValue(Alpha: Byte): Boolean;
    function AddAlphaFromValueRange(Alpha: Cardinal): Boolean;
    function AddAlphaFromValueFloat(Alpha: single): Boolean;

    function RemoveAlpha: Boolean; virtual;

    function ConvertTo(NewFormat: TglBitmapInternalFormat): Boolean; virtual;

    // Other
    procedure FillWithColor(Red, Green, Blue: Byte; Alpha: Byte = 255);
    procedure FillWithColorRange(Red, Green, Blue: Cardinal; Alpha: Cardinal = $FFFFFFFF);
    procedure FillWithColorFloat(Red, Green, Blue: single; Alpha: single = 1);

    procedure Invert(UseRGB: Boolean = True; UseAlpha: Boolean = false);

    procedure SetFilter(Min, Mag: Integer);
    procedure SetWrap(S: Integer = GL_CLAMP_TO_EDGE; T: Integer = GL_CLAMP_TO_EDGE; R: Integer = GL_CLAMP_TO_EDGE);

    procedure SetBorderColor(Red, Green, Blue, Alpha: single);

    procedure GetPixel(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData); virtual;
    procedure SetPixel(const Pos: TglBitmapPixelPosition; const Pixel: TglBitmapPixelData); virtual;

    // Generation
    procedure Unbind(DisableTextureUnit: Boolean = True); virtual;
    procedure Bind(EnableTextureUnit: Boolean = True); virtual;
  end;

  TglBitmap2D = class(TglBitmap)
  protected
    // Bildeinstellungen
    fLines: array of pByte;

    procedure GetDXTColorBlock(pData: pByte; relX, relY: Integer; var Pixel: TglBitmapPixelData);
    procedure GetPixel2DDXT1(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
    procedure GetPixel2DDXT3(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
    procedure GetPixel2DDXT5(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
    procedure GetPixel2DUnmap(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);

    procedure SetPixel2DUnmap(const Pos: TglBitmapPixelPosition; const Pixel: TglBitmapPixelData);

    function GetScanline(Index: Integer): Pointer;

    procedure SetDataPointer(Data: pByte; Format: TglBitmapInternalFormat; width: Integer = -1; height: Integer = -1); override;
    procedure UploadData(target, Format, internalformat, Typ: Cardinal; BuildWithGlu: Boolean);
  public
    // propertys
    property width;
    property height;

    property Scanline[Index: Integer]: Pointer read GetScanline;

    procedure AfterConstruction; override;

    procedure GrabScreen(Top, Left, Right, Bottom: Integer; Format: TglBitmapInternalFormat);
    procedure GetDataFromTexture;

    // Other
    function FlipHorz: Boolean; override;
    function FlipVert: Boolean; override;

    procedure ToNormalMap(Func: TglBitmapNormalMapFunc = nm3x3; Scale: single = 2; UseAlpha: Boolean = false);

    // Generation
    procedure GenTexture(TestTextureSize: Boolean = True); override;
  end;

  TglBitmapCubeMap = class(TglBitmap2D)
  protected
    fGenMode: Integer;

    // Hide GenTexture
    procedure GenTexture(TestTextureSize: Boolean = True); reintroduce;
  public
    procedure AfterConstruction; override;

    procedure GenerateCubeMap(CubeTarget: Cardinal; TestTextureSize: Boolean = True);

    procedure Unbind(DisableTexCoordsGen: Boolean = True; DisableTextureUnit: Boolean = True); reintroduce; virtual;
    procedure Bind(EnableTexCoordsGen: Boolean = True; EnableTextureUnit: Boolean = True); reintroduce; virtual;
  end;

  TglBitmapNormalMap = class(TglBitmapCubeMap)
  public
    procedure AfterConstruction; override;

    procedure GenerateNormalMap(Size: Integer = 32; TestTextureSize: Boolean = True);
  end;

  TglBitmap1D = class(TglBitmap)
  protected
    procedure GetPixel1DUnmap(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);

    procedure SetDataPointer(Data: pByte; Format: TglBitmapInternalFormat; width: Integer = -1; height: Integer = -1); override;
    procedure UploadData(target, Format, internalformat, Typ: Cardinal; BuildWithGlu: Boolean);
  public
    // propertys
    property width;

    procedure AfterConstruction; override;

    // Other
    function FlipHorz: Boolean; override;

    // Generation
    procedure GenTexture(TestTextureSize: Boolean = True); override;
  end;

  // methods and vars for Defaults
procedure glBitmapSetDefaultFormat(Format: TglBitmapFormat);
procedure glBitmapSetDefaultFilter(Min, Mag: Integer);
procedure glBitmapSetDefaultWrap(S: Integer = GL_CLAMP_TO_EDGE; T: Integer = GL_CLAMP_TO_EDGE; R: Integer = GL_CLAMP_TO_EDGE);

procedure glBitmapSetDefaultDeleteTextureOnFree(DeleteTextureOnFree: Boolean);
procedure glBitmapSetDefaultFreeDataAfterGenTexture(FreeData: Boolean);

function glBitmapGetDefaultFormat: TglBitmapFormat;
procedure glBitmapGetDefaultFilter(var Min, Mag: Integer);
procedure glBitmapGetDefaultTextureWrap(var S, T, R: Integer);

function glBitmapGetDefaultDeleteTextureOnFree: Boolean;
function glBitmapGetDefaultFreeDataAfterGenTexture: Boolean;

// position / size
function glBitmapPosition(X: Integer = -1; Y: Integer = -1): TglBitmapPixelPosition;

// Formatfunctions
function FormatGetSize(Format: TglBitmapInternalFormat): single;

function FormatIsCompressed(Format: TglBitmapInternalFormat): Boolean;
function FormatIsUncompressed(Format: TglBitmapInternalFormat): Boolean;
function FormatIsEmpty(Format: TglBitmapInternalFormat): Boolean;
function FormatHasAlpha(Format: TglBitmapInternalFormat): Boolean;

procedure FormatPreparePixel(var Pixel: TglBitmapPixelData; Format: TglBitmapInternalFormat);

function FormatGetWithoutAlpha(Format: TglBitmapInternalFormat): TglBitmapInternalFormat;
function FormatGetWithAlpha(Format: TglBitmapInternalFormat): TglBitmapInternalFormat;

function FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask: Cardinal; Format: TglBitmapInternalFormat): Boolean;

// Call LoadingMethods
function LoadTexture(Filename: String; var Texture: Cardinal{$IFDEF GLB_DELPHI}; LoadFromRes: Boolean; Instance: Cardinal = 0{$ENDIF}): Boolean;

function LoadCubeMap(PositiveX, NegativeX, PositiveY, NegativeY, PositiveZ, NegativeZ: String; var Texture: Cardinal{$IFDEF GLB_DELPHI}; LoadFromRes: Boolean; Instance: Cardinal = 0{$ENDIF}): Boolean;

function LoadNormalMap(Size: Integer; var Texture: Cardinal): Boolean;

var
  glBitmapDefaultFormat: TglBitmapFormat;
  glBitmapDefaultFilterMin: Integer;
  glBitmapDefaultFilterMag: Integer;
  glBitmapDefaultWrapS: Integer;
  glBitmapDefaultWrapT: Integer;
  glBitmapDefaultWrapR: Integer;

  glBitmapDefaultDeleteTextureOnFree: Boolean;
  glBitmapDefaultFreeDataAfterGenTextures: Boolean;

{$IFDEF GLB_DELPHI}
function CreateGrayPalette: HPALETTE;
{$ENDIF}

implementation

{$IFNDEF GLB_NO_NATIVE_GL}

procedure ReadOpenGLExtensions;
var
{$IFDEF GLB_DELPHI}
  Context: HGLRC;
{$ENDIF}
  Buffer: AnsiString;
  MajorVersion, MinorVersion: Integer;

  procedure TrimVersionString(Buffer: AnsiString; var Major, Minor: Integer);
  var
    Separator: Integer;
  begin
    Minor := 0;
    Major := 0;

    Separator := Pos(AnsiString('.'), Buffer);

    if (Separator > 1) and (Separator < Length(Buffer)) and (Buffer[Separator - 1] in ['0' .. '9']) and (Buffer[Separator + 1] in ['0' .. '9']) then
    begin

      Dec(Separator);
      while (Separator > 0) and (Buffer[Separator] in ['0' .. '9']) do
        Dec(Separator);

      Delete(Buffer, 1, Separator);
      Separator := Pos(AnsiString('.'), Buffer) + 1;

      while (Separator <= Length(Buffer)) and (AnsiChar(Buffer[Separator]) in ['0' .. '9']) do
        Inc(Separator);

      Delete(Buffer, Separator, 255);
      Separator := Pos(AnsiString('.'), Buffer);

      Major := kol.Str2Int(Copy(String(Buffer), 1, Separator - 1));
      Minor := kol.Str2Int(Copy(String(Buffer), Separator + 1, 1));
    end;
  end;

  function CheckExtension(const Extension: AnsiString): Boolean;
  var
    ExtPos: Integer;
  begin
    ExtPos := Pos(Extension, Buffer);
    Result := ExtPos > 0;

    if Result then
      Result := ((ExtPos + Length(Extension) - 1) = Length(Buffer)) or not(Buffer[ExtPos + Length(Extension)] in ['_', 'A' .. 'Z', 'a' .. 'z']);
  end;

  function glLoad(aFunc: pAnsiChar): Pointer;
  begin
{$IFDEF LINUX}
    Result := glXGetProcAddress(aFunc);
{$ELSE}
    Result := wglGetProcAddress(aFunc);
{$ENDIF}
  end;

begin
{$IFDEF GLB_DELPHI}
  Context := wglGetCurrentContext;

  if Context <> gLastContext then
  begin
    gLastContext := Context;
{$ENDIF}
    // Version
    Buffer := glGetString(GL_VERSION);
    TrimVersionString(Buffer, MajorVersion, MinorVersion);

    GL_VERSION_1_2 := false;
    GL_VERSION_1_3 := false;
    GL_VERSION_1_4 := false;
    GL_VERSION_2_0 := false;

    if MajorVersion = 1 then
    begin
      if MinorVersion >= 1 then
      begin
        if MinorVersion >= 2 then
          GL_VERSION_1_2 := True;

        if MinorVersion >= 3 then
          GL_VERSION_1_3 := True;

        if MinorVersion >= 4 then
          GL_VERSION_1_4 := True;
      end;
    end;

    if MajorVersion >= 2 then
    begin
      GL_VERSION_1_2 := True;
      GL_VERSION_1_3 := True;
      GL_VERSION_1_4 := True;
      GL_VERSION_2_0 := True;
    end;

    // Extensions
    Buffer := glGetString(GL_EXTENSIONS);
    GL_ARB_texture_border_clamp := CheckExtension('GL_ARB_texture_border_clamp');
    GL_ARB_texture_cube_map := CheckExtension('GL_ARB_texture_cube_map');
    GL_ARB_texture_compression := CheckExtension('GL_ARB_texture_compression');
    GL_ARB_texture_non_power_of_two := CheckExtension('GL_ARB_texture_non_power_of_two');
    GL_ARB_texture_rectangle := CheckExtension('GL_ARB_texture_rectangle');
    GL_ARB_texture_mirrored_repeat := CheckExtension('GL_ARB_texture_mirrored_repeat');
    GL_EXT_bgra := CheckExtension('GL_EXT_bgra');
    GL_EXT_texture_edge_clamp := CheckExtension('GL_EXT_texture_edge_clamp');
    GL_EXT_texture_cube_map := CheckExtension('GL_EXT_texture_cube_map');
    GL_EXT_texture_compression_s3tc := CheckExtension('GL_EXT_texture_compression_s3tc');
    GL_EXT_texture_filter_anisotropic := CheckExtension('GL_EXT_texture_filter_anisotropic');
    GL_EXT_texture_rectangle := CheckExtension('GL_EXT_texture_rectangle');
    GL_NV_texture_rectangle := CheckExtension('GL_NV_texture_rectangle');
    GL_IBM_texture_mirrored_repeat := CheckExtension('GL_IBM_texture_mirrored_repeat');
    GL_SGIS_generate_mipmap := CheckExtension('GL_SGIS_generate_mipmap');

    // Funtions
    if GL_VERSION_1_3 then
    begin
      // Loading Core
      glCompressedTexImage1D := glLoad('glCompressedTexImage1D');
      glCompressedTexImage2D := glLoad('glCompressedTexImage2D');
      glGetCompressedTexImage := glLoad('glGetCompressedTexImage');
    end
    else

    begin
      // Try loading Extension
      glCompressedTexImage1D := glLoad('glCompressedTexImage1DARB');
      glCompressedTexImage2D := glLoad('glCompressedTexImage2DARB');
      glGetCompressedTexImage := glLoad('glGetCompressedTexImageARB');
    end;
{$IFDEF GLB_DELPHI}
  end;
{$ENDIF}
end;
{$ENDIF}

function glBitmapPosition(X, Y: Integer): TglBitmapPixelPosition;
begin
  Result.Fields := [];

  if X >= 0 then
    Result.Fields := Result.Fields + [ffX];
  if Y >= 0 then
    Result.Fields := Result.Fields + [ffY];

  Result.X := Max(0, X);
  Result.Y := Max(0, Y);
end;

const
  UNSUPPORTED_INTERNAL_FORMAT = 'the given format isn''t supported by this function.';

  PIXEL_DESC_ALPHA: TglBitmapPixelDesc = (RedRange: $00; RedShift: 0; GreenRange: $00; GreenShift: 0; BlueRange: $00; BlueShift: 0; AlphaRange: $FF; AlphaShift: 0);

  PIXEL_DESC_LUMINANCE: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 0; GreenRange: $FF; GreenShift: 0; BlueRange: $FF; BlueShift: 0; AlphaRange: $00; AlphaShift: 0);

  PIXEL_DESC_DEPTH8: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 0; GreenRange: $FF; GreenShift: 0; BlueRange: $FF; BlueShift: 0; AlphaRange: $00; AlphaShift: 0);

  PIXEL_DESC_LUMINANCEALPHA: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 0; GreenRange: $FF; GreenShift: 0; BlueRange: $FF; BlueShift: 0; AlphaRange: $FF; AlphaShift: 8);

  PIXEL_DESC_RGBA4: TglBitmapPixelDesc = (RedRange: $0F; RedShift: 8; GreenRange: $0F; GreenShift: 4; BlueRange: $0F; BlueShift: 0; AlphaRange: $0F; AlphaShift: 12);

  PIXEL_DESC_R5G6B5: TglBitmapPixelDesc = (RedRange: $1F; RedShift: 11; GreenRange: $3F; GreenShift: 5; BlueRange: $1F; BlueShift: 0; AlphaRange: $00; AlphaShift: 0);

  PIXEL_DESC_RGB5A1: TglBitmapPixelDesc = (RedRange: $1F; RedShift: 10; GreenRange: $1F; GreenShift: 5; BlueRange: $1F; BlueShift: 0; AlphaRange: $01; AlphaShift: 15);

  PIXEL_DESC_RGB8: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 0; GreenRange: $FF; GreenShift: 8; BlueRange: $FF; BlueShift: 16; AlphaRange: $00; AlphaShift: 0);

  PIXEL_DESC_RGBA8: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 0; GreenRange: $FF; GreenShift: 8; BlueRange: $FF; BlueShift: 16; AlphaRange: $FF; AlphaShift: 24);

  PIXEL_DESC_BGR8: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 16; GreenRange: $FF; GreenShift: 8; BlueRange: $FF; BlueShift: 0; AlphaRange: $00; AlphaShift: 0);

  PIXEL_DESC_BGRA8: TglBitmapPixelDesc = (RedRange: $FF; RedShift: 16; GreenRange: $FF; GreenShift: 8; BlueRange: $FF; BlueShift: 0; AlphaRange: $FF; AlphaShift: 24);

  PIXEL_DESC_RGB10A2: TglBitmapPixelDesc = (RedRange: $3FF; RedShift: 20; GreenRange: $3FF; GreenShift: 10; BlueRange: $3FF; BlueShift: 0; AlphaRange: $003; AlphaShift: 30);

  { *
    ** Mapping
    * }

procedure MapAlpha(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pDest^ := Pixel.Alpha;
  Inc(pDest);
end;

procedure MapLuminance(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pDest^ := Trunc(Pixel.Red * 0.3 + Pixel.Green * 0.59 + Pixel.Blue * 0.11);
  Inc(pDest);
end;

procedure MapDepth8(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pDest^ := (Pixel.Red + Pixel.Green + Pixel.Blue) div 3;
  Inc(pDest);
end;

procedure MapLuminanceAlpha(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pDest^ := Trunc(Pixel.Red * 0.3 + Pixel.Green * 0.59 + Pixel.Blue * 0.11);
  Inc(pDest);

  pDest^ := Pixel.Alpha;
  Inc(pDest);
end;

procedure MapRGBA4(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pWord(pDest)^ := Pixel.Alpha shl PIXEL_DESC_RGBA4.AlphaShift or Pixel.Red shl PIXEL_DESC_RGBA4.RedShift or Pixel.Green shl PIXEL_DESC_RGBA4.GreenShift or Pixel.Blue;

  Inc(pDest, 2);
end;

procedure MapR5G6B5(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pWord(pDest)^ := Pixel.Red shl PIXEL_DESC_R5G6B5.RedShift or Pixel.Green shl PIXEL_DESC_R5G6B5.GreenShift or Pixel.Blue;

  Inc(pDest, 2);
end;

procedure MapRGB5A1(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pWord(pDest)^ := Pixel.Alpha shl PIXEL_DESC_RGB5A1.AlphaShift or Pixel.Red shl PIXEL_DESC_RGB5A1.RedShift or Pixel.Green shl PIXEL_DESC_RGB5A1.GreenShift or Pixel.Blue;

  Inc(pDest, 2);
end;

procedure MapRGB8(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pDest^ := Pixel.Red;
  Inc(pDest);

  pDest^ := Pixel.Green;
  Inc(pDest);

  pDest^ := Pixel.Blue;
  Inc(pDest);
end;

procedure MapBGR8(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  pDest^ := Pixel.Blue;
  Inc(pDest);

  pDest^ := Pixel.Green;
  Inc(pDest);

  pDest^ := Pixel.Red;
  Inc(pDest);
end;

procedure MapRGBA8(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  PDWORD(pDest)^ := Pixel.Alpha shl PIXEL_DESC_RGBA8.AlphaShift or Pixel.Blue shl PIXEL_DESC_RGBA8.BlueShift or Pixel.Green shl PIXEL_DESC_RGBA8.GreenShift or Pixel.Red;

  Inc(pDest, 4);
end;

procedure MapBGRA8(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  PDWORD(pDest)^ := Pixel.Alpha shl PIXEL_DESC_BGRA8.AlphaShift or Pixel.Red shl PIXEL_DESC_BGRA8.RedShift or Pixel.Green shl PIXEL_DESC_BGRA8.GreenShift or Pixel.Blue;

  Inc(pDest, 4);
end;

procedure MapRGB10A2(const Pixel: TglBitmapPixelData; var pDest: pByte);
begin
  PDWORD(pDest)^ := Pixel.Alpha shl PIXEL_DESC_RGB10A2.AlphaShift or Pixel.Red shl PIXEL_DESC_RGB10A2.RedShift or Pixel.Green shl PIXEL_DESC_RGB10A2.GreenShift or Pixel.Blue;

  Inc(pDest, 4);
end;

function FormatGetMapFunc(Format: TglBitmapInternalFormat): TglBitmapMapFunc;
begin
  case Format of
    ifAlpha:
      Result := MapAlpha;
    ifLuminance:
      Result := MapLuminance;
    ifDepth8:
      Result := MapDepth8;
    ifLuminanceAlpha:
      Result := MapLuminanceAlpha;
    ifRGBA4:
      Result := MapRGBA4;
    ifR5G6B5:
      Result := MapR5G6B5;
    ifRGB5A1:
      Result := MapRGB5A1;
    ifRGB8:
      Result := MapRGB8;
    ifBGR8:
      Result := MapBGR8;
    ifRGBA8:
      Result := MapRGBA8;
    ifBGRA8:
      Result := MapBGRA8;
    ifRGB10A2:
      Result := MapRGB10A2;
  else
    raise EglBitmapUnsupportedInternalFormat.Create('FormatGetMapFunc - ' + UNSUPPORTED_INTERNAL_FORMAT);
  end;
end;

{ *
  ** Unmapping
  * }
procedure UnMapAlpha(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Alpha := pData^;
  Pixel.Red := Pixel.PixelDesc.RedRange;
  Pixel.Green := Pixel.PixelDesc.GreenRange;
  Pixel.Blue := Pixel.PixelDesc.BlueRange;

  Inc(pData);
end;

procedure UnMapLuminance(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Alpha := 255;
  Pixel.Red := pData^;
  Pixel.Green := pData^;
  Pixel.Blue := pData^;

  Inc(pData);
end;

procedure UnMapDepth8(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Alpha := 255;
  Pixel.Red := pData^;
  Pixel.Green := pData^;
  Pixel.Blue := pData^;

  Inc(pData);
end;

procedure UnMapLuminanceAlpha(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Red := pData^;
  Pixel.Green := pData^;
  Pixel.Blue := pData^;
  Inc(pData);

  Pixel.Alpha := pData^;
  Inc(pData);
end;

procedure UnMapRGBA4(var pData: pByte; var Pixel: TglBitmapPixelData);
var
  Temp: Word;
begin
  Temp := pWord(pData)^;

  Pixel.Alpha := Temp shr PIXEL_DESC_RGBA4.AlphaShift and PIXEL_DESC_RGBA4.AlphaRange;
  Pixel.Red := Temp shr PIXEL_DESC_RGBA4.RedShift and PIXEL_DESC_RGBA4.RedRange;
  Pixel.Green := Temp shr PIXEL_DESC_RGBA4.GreenShift and PIXEL_DESC_RGBA4.GreenRange;
  Pixel.Blue := Temp and PIXEL_DESC_RGBA4.BlueRange;

  Inc(pData, 2);
end;

procedure UnMapR5G6B5(var pData: pByte; var Pixel: TglBitmapPixelData);
var
  Temp: Word;
begin
  Temp := pWord(pData)^;

  Pixel.Alpha := Pixel.PixelDesc.AlphaRange;
  Pixel.Red := Temp shr PIXEL_DESC_R5G6B5.RedShift and PIXEL_DESC_R5G6B5.RedRange;
  Pixel.Green := Temp shr PIXEL_DESC_R5G6B5.GreenShift and PIXEL_DESC_R5G6B5.GreenRange;
  Pixel.Blue := Temp and PIXEL_DESC_R5G6B5.BlueRange;

  Inc(pData, 2);
end;

procedure UnMapRGB5A1(var pData: pByte; var Pixel: TglBitmapPixelData);
var
  Temp: Word;
begin
  Temp := pWord(pData)^;

  Pixel.Alpha := Temp shr PIXEL_DESC_RGB5A1.AlphaShift and PIXEL_DESC_RGB5A1.AlphaRange;
  Pixel.Red := Temp shr PIXEL_DESC_RGB5A1.RedShift and PIXEL_DESC_RGB5A1.RedRange;
  Pixel.Green := Temp shr PIXEL_DESC_RGB5A1.GreenShift and PIXEL_DESC_RGB5A1.GreenRange;
  Pixel.Blue := Temp and PIXEL_DESC_RGB5A1.BlueRange;

  Inc(pData, 2);
end;

procedure UnMapRGB8(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Alpha := Pixel.PixelDesc.AlphaRange;

  Pixel.Red := pData^;
  Inc(pData);

  Pixel.Green := pData^;
  Inc(pData);

  Pixel.Blue := pData^;
  Inc(pData);
end;

procedure UnMapBGR8(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Alpha := Pixel.PixelDesc.AlphaRange;

  Pixel.Blue := pData^;
  Inc(pData);

  Pixel.Green := pData^;
  Inc(pData);

  Pixel.Red := pData^;
  Inc(pData);
end;

procedure UnMapRGBA8(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Red := pData^;
  Inc(pData);

  Pixel.Green := pData^;
  Inc(pData);

  Pixel.Blue := pData^;
  Inc(pData);

  Pixel.Alpha := pData^;
  Inc(pData);
end;

procedure UnMapBGRA8(var pData: pByte; var Pixel: TglBitmapPixelData);
begin
  Pixel.Blue := pData^;
  Inc(pData);

  Pixel.Green := pData^;
  Inc(pData);

  Pixel.Red := pData^;
  Inc(pData);

  Pixel.Alpha := pData^;
  Inc(pData);
end;

procedure UnMapRGB10A2(var pData: pByte; var Pixel: TglBitmapPixelData);
var
  Temp: DWORD;
begin
  Temp := PDWORD(pData)^;

  Pixel.Alpha := Temp shr PIXEL_DESC_RGB10A2.AlphaShift and PIXEL_DESC_RGB10A2.AlphaRange;
  Pixel.Red := Temp shr PIXEL_DESC_RGB10A2.RedShift and PIXEL_DESC_RGB10A2.RedRange;
  Pixel.Green := Temp shr PIXEL_DESC_RGB10A2.GreenShift and PIXEL_DESC_RGB10A2.GreenRange;
  Pixel.Blue := Temp and PIXEL_DESC_RGB10A2.BlueRange;

  Inc(pData, 4);
end;

function FormatGetUnMapFunc(Format: TglBitmapInternalFormat): TglBitmapUnMapFunc;
begin
  case Format of
    ifAlpha:
      Result := UnMapAlpha;
    ifLuminance:
      Result := UnMapLuminance;
    ifDepth8:
      Result := UnMapDepth8;
    ifLuminanceAlpha:
      Result := UnMapLuminanceAlpha;
    ifRGBA4:
      Result := UnMapRGBA4;
    ifR5G6B5:
      Result := UnMapR5G6B5;
    ifRGB5A1:
      Result := UnMapRGB5A1;
    ifRGB8:
      Result := UnMapRGB8;
    ifBGR8:
      Result := UnMapBGR8;
    ifRGBA8:
      Result := UnMapRGBA8;
    ifBGRA8:
      Result := UnMapBGRA8;
    ifRGB10A2:
      Result := UnMapRGB10A2;
  else
    raise EglBitmapUnsupportedInternalFormat.Create('FormatGetUnMapFunc - ' + UNSUPPORTED_INTERNAL_FORMAT);
  end;
end;

{ *
  ** Tools
  * }
function FormatGetSize(Format: TglBitmapInternalFormat): single;
begin
  case Format of
    ifEmpty:
      Result := 0;
    ifDXT1:
      Result := 0.5;
    ifAlpha, ifLuminance, ifDepth8, ifDXT3, ifDXT5:
      Result := 1;
    ifLuminanceAlpha, ifRGBA4, ifRGB5A1, ifR5G6B5:
      Result := 2;
    ifBGR8, ifRGB8:
      Result := 3;
    ifBGRA8, ifRGBA8, ifRGB10A2:
      Result := 4;
  else
    raise EglBitmapUnsupportedInternalFormat.Create('FormatGetSize - ' + UNSUPPORTED_INTERNAL_FORMAT);
  end;
end;

function FormatIsCompressed(Format: TglBitmapInternalFormat): Boolean;
begin
  Result := Format in [ifDXT1, ifDXT3, ifDXT5];
end;

function FormatIsUncompressed(Format: TglBitmapInternalFormat): Boolean;
begin
  Result := Format in [ifAlpha, ifLuminance, ifDepth8, ifLuminanceAlpha, ifRGBA4, ifRGB5A1, ifR5G6B5, ifBGR8, ifRGB8, ifBGRA8, ifRGBA8, ifRGB10A2];
end;

function FormatIsEmpty(Format: TglBitmapInternalFormat): Boolean;
begin
  Result := Format = ifEmpty;
end;

function FormatHasAlpha(Format: TglBitmapInternalFormat): Boolean;
begin
  Result := Format in [ifDXT1, ifDXT3, ifDXT5, ifAlpha, ifLuminanceAlpha, ifRGBA4, ifRGB5A1, ifBGRA8, ifRGBA8, ifRGB10A2];
end;

procedure FormatPreparePixel(var Pixel: TglBitmapPixelData; Format: TglBitmapInternalFormat);
begin
  FillChar(Pixel, SizeOf(Pixel), #0);

  case Format of
    ifAlpha:
      Pixel.PixelDesc := PIXEL_DESC_ALPHA;
    ifLuminance:
      Pixel.PixelDesc := PIXEL_DESC_LUMINANCE;
    ifDepth8:
      Pixel.PixelDesc := PIXEL_DESC_DEPTH8;
    ifLuminanceAlpha:
      Pixel.PixelDesc := PIXEL_DESC_LUMINANCEALPHA;
    ifRGBA4:
      Pixel.PixelDesc := PIXEL_DESC_RGBA4;
    ifR5G6B5:
      Pixel.PixelDesc := PIXEL_DESC_R5G6B5;
    ifRGB5A1:
      Pixel.PixelDesc := PIXEL_DESC_RGB5A1;
    ifDXT1, ifDXT3, ifDXT5, ifBGRA8:
      Pixel.PixelDesc := PIXEL_DESC_BGRA8;
    ifBGR8:
      Pixel.PixelDesc := PIXEL_DESC_BGR8;
    ifRGB8:
      Pixel.PixelDesc := PIXEL_DESC_RGB8;
    ifRGBA8:
      Pixel.PixelDesc := PIXEL_DESC_RGBA8;
    ifRGB10A2:
      Pixel.PixelDesc := PIXEL_DESC_RGB10A2;
  end;

  Pixel.Red := Pixel.PixelDesc.RedRange;
  Pixel.Green := Pixel.PixelDesc.GreenRange;
  Pixel.Blue := Pixel.PixelDesc.BlueRange;
  Pixel.Alpha := Pixel.PixelDesc.AlphaRange;
end;

function FormatGetWithoutAlpha(Format: TglBitmapInternalFormat): TglBitmapInternalFormat;
begin
  case Format of
    ifAlpha:
      Result := ifLuminance;
    ifLuminanceAlpha:
      Result := ifLuminance;
    ifRGBA4:
      Result := ifR5G6B5;
    ifRGB5A1:
      Result := ifR5G6B5;
    ifBGRA8:
      Result := ifBGR8;
    ifRGBA8:
      Result := ifRGB8;
    ifRGB10A2:
      Result := ifRGB8;
  else
    Result := Format;
  end;
end;

function FormatGetWithAlpha(Format: TglBitmapInternalFormat): TglBitmapInternalFormat;
begin
  case Format of
    ifLuminance:
      Result := ifLuminanceAlpha;
    ifR5G6B5:
      Result := ifRGB5A1;
    ifBGR8:
      Result := ifBGRA8;
    ifRGB8:
      Result := ifRGBA8;
  else
    Result := Format;
  end;
end;

function FormatGetUncompressed(Format: TglBitmapInternalFormat): TglBitmapInternalFormat;
begin
  case Format of
    ifDXT1:
      Result := ifRGB5A1;
    ifDXT3:
      Result := ifRGBA8;
    ifDXT5:
      Result := ifRGBA8;
  else
    Result := Format;
  end;
end;

function FormatGetImageSize(Size: TglBitmapPixelPosition; Format: TglBitmapInternalFormat): Integer;
begin
  if (Size.X = 0) and (Size.Y = 0) then
    Result := 0
  else
    Result := Trunc(Max(Size.Y, 1) * Max(Size.X, 1) * FormatGetSize(Format));
end;

function FormatGetSupportedFiles(Format: TglBitmapInternalFormat): TglBitmapFileTypes;
begin
  Result := [];

{$IFDEF GLB_SUPPORT_PNG_WRITE}
  if Format in [ifLuminance, ifAlpha, ifDepth8, ifLuminanceAlpha, ifBGR8, ifBGRA8, ifRGB8, ifRGBA8] then
    Result := Result + [ftPNG];
{$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_WRITE}
  if Format in [ifLuminance, ifAlpha, ifDepth8, ifRGB8, ifBGR8] then
    Result := Result + [ftJPEG];
{$ENDIF}
  Result := Result + [ftDDS];

  if Format in [ifLuminance, ifAlpha, ifDepth8, ifLuminanceAlpha, ifBGR8, ifRGB8, ifBGRA8, ifRGBA8] then
    Result := Result + [ftTGA];

  if Format in [ifLuminance, ifAlpha, ifDepth8, ifLuminanceAlpha, ifRGBA4, ifRGB5A1, ifR5G6B5, ifRGB8, ifBGR8, ifRGBA8, ifBGRA8, ifRGB10A2] then
    Result := Result + [ftBMP];
end;

function FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask: Cardinal; Format: TglBitmapInternalFormat): Boolean;
var
  Pix: TglBitmapPixelData;
begin
  Result := false;

  if (RedMask = 0) and (GreenMask = 0) and (BlueMask = 0) and (AlphaMask = 0) then
    raise EglBitmapException.Create('FormatCheckFormat - All Masks are 0');

  FormatPreparePixel(Pix, Format);

  with Pix.PixelDesc do
  begin
    if RedMask <> 0 then
      if (RedMask <> (RedRange shl RedShift)) then
        Exit;

    if GreenMask <> 0 then
      if (GreenMask <> (GreenRange shl GreenShift)) then
        Exit;

    if BlueMask <> 0 then
      if (BlueMask <> (BlueRange shl BlueShift)) then
        Exit;

    if AlphaMask <> 0 then
      if (AlphaMask <> (AlphaRange shl AlphaShift)) then
        Exit;

    Result := True;
  end;
end;

function IsPowerOfTwo(Number: Integer): Boolean;
begin
  while Number and 1 = 0 do
    Number := Number shr 1;

  Result := Number = 1;
end;

function GetBitSize(BitSet: Cardinal): Integer;
begin
  Result := 0;

  while BitSet > 0 do
  begin
    if (BitSet and $1) = 1 then
      Inc(Result);

    BitSet := BitSet shr 1;
  end;
end;

procedure SwapRGB(pData: pByte; width: Integer; HasAlpha: Boolean);
type
  PRGBPix = ^TRGBPix;
  TRGBPix = array [0 .. 2] of Byte;
var
  Temp: Byte;
begin
  while width > 0 do
  begin
    Temp := PRGBPix(pData)^[0];
    PRGBPix(pData)^[0] := PRGBPix(pData)^[2];
    PRGBPix(pData)^[2] := Temp;

    if HasAlpha then
      Inc(pData, 4)
    else
      Inc(pData, 3);

    Dec(width);
  end;
end;

{$IFDEF GLB_DELPHI}

function CreateGrayPalette: HPALETTE;
var
  Idx: Integer;
  Pal: PLogPalette;
begin
  GetMem(Pal, SizeOf(TLogPalette) + (SizeOf(TPaletteEntry) * 256));

  Pal.palVersion := $300;
  Pal.palNumEntries := 256;

{$IFOPT R+}
{$DEFINE GLB_TEMPRANGECHECK}
{$R-}
{$ENDIF}
  for Idx := 0 to 256 - 1 do
  begin
    Pal.palPalEntry[Idx].peRed := Idx;
    Pal.palPalEntry[Idx].peGreen := Idx;
    Pal.palPalEntry[Idx].peBlue := Idx;
    Pal.palPalEntry[Idx].peFlags := 0;
  end;

{$IFDEF GLB_TEMPRANGECHECK}
{$UNDEF GLB_TEMPRANGECHECK}
{$R+}
{$ENDIF}
  Result := CreatePalette(Pal^);

  FreeMem(Pal);
end;
{$ENDIF}
{$IFDEF GLB_SDL_IMAGE}

function glBitmapRWseek(Context: PSDL_RWops; offset: Integer; whence: Integer): Integer; cdecl;
begin
  Result := PStream(Context^.unknown.data1).Seek(offset, whence);
end;

function glBitmapRWread(Context: PSDL_RWops; Ptr: Pointer; Size: Integer; maxnum: Integer): Integer; cdecl;
begin
  Result := PStream(Context^.unknown.data1).Read(Ptr^, Size * maxnum);
end;

function glBitmapRWwrite(Context: PSDL_RWops; Ptr: Pointer; Size: Integer; num: Integer): Integer; cdecl;
begin
  Result := PStream(Context^.unknown.data1).Write(Ptr^, Size * num);
end;

function glBitmapRWclose(Context: PSDL_RWops): Integer; cdecl;
begin
  Result := 0;
end;

function glBitmapCreateRWops(Stream: PStream): PSDL_RWops;
begin
  Result := SDL_AllocRW;

  if Result = nil then
    raise EglBitmapException.Create('glBitmapCreateRWops - SDL_AllocRW failed.');

  Result^.Seek := glBitmapRWseek;
  Result^.Read := glBitmapRWread;
  Result^.Write := glBitmapRWwrite;
  Result^.close := glBitmapRWclose;
  Result^.unknown.data1 := Stream;
end;
{$ENDIF}

{ *
  ** Helper functions
  * }
function LoadTexture(Filename: String; var Texture: Cardinal{$IFDEF GLB_DELPHI}; LoadFromRes: Boolean; Instance: Cardinal{$ENDIF}): Boolean;
var
  glBitmap: TglBitmap2D;
begin
  Result := false;
  Texture := 0;

{$IFDEF GLB_DELPHI}
  if Instance = 0 then
    Instance := HInstance;

  if (LoadFromRes) then
    glBitmap := TglBitmap2D.CreateFromResourceName(Instance, Filename)
  else
{$ENDIF}
    glBitmap := TglBitmap2D.Create(Filename);

  try
    glBitmap.DeleteTextureOnFree := false;
    glBitmap.FreeDataAfterGenTexture := false;
    glBitmap.GenTexture(True);
    if (glBitmap.ID > 0) then
    begin
      Texture := glBitmap.ID;
      Result := True;
    end;
  finally
    glBitmap.Free;
  end;
end;

function LoadCubeMap(PositiveX, NegativeX, PositiveY, NegativeY, PositiveZ, NegativeZ: String; var Texture: Cardinal{$IFDEF GLB_DELPHI}; LoadFromRes: Boolean; Instance: Cardinal{$ENDIF}): Boolean;
var
  CM: TglBitmapCubeMap;
begin
  Texture := 0;

{$IFDEF GLB_DELPHI}
  if Instance = 0 then
    Instance := HInstance;
{$ENDIF}
  CM := TglBitmapCubeMap.Create;
  try
    CM.DeleteTextureOnFree := false;

    // Maps
{$IFDEF GLB_DELPHI}
    if (LoadFromRes) then
      CM.LoadFromResource(Instance, PositiveX)
    else
{$ENDIF}
      CM.LoadFromFile(PositiveX);
    CM.GenerateCubeMap(GL_TEXTURE_CUBE_MAP_POSITIVE_X);

{$IFDEF GLB_DELPHI}
    if (LoadFromRes) then
      CM.LoadFromResource(Instance, NegativeX)
    else
{$ENDIF}
      CM.LoadFromFile(NegativeX);
    CM.GenerateCubeMap(GL_TEXTURE_CUBE_MAP_NEGATIVE_X);

{$IFDEF GLB_DELPHI}
    if (LoadFromRes) then
      CM.LoadFromResource(Instance, PositiveY)
    else
{$ENDIF}
      CM.LoadFromFile(PositiveY);
    CM.GenerateCubeMap(GL_TEXTURE_CUBE_MAP_POSITIVE_Y);

{$IFDEF GLB_DELPHI}
    if (LoadFromRes) then
      CM.LoadFromResource(Instance, NegativeY)
    else
{$ENDIF}
      CM.LoadFromFile(NegativeY);
    CM.GenerateCubeMap(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y);

{$IFDEF GLB_DELPHI}
    if (LoadFromRes) then
      CM.LoadFromResource(Instance, PositiveZ)
    else
{$ENDIF}
      CM.LoadFromFile(PositiveZ);
    CM.GenerateCubeMap(GL_TEXTURE_CUBE_MAP_POSITIVE_Z);

{$IFDEF GLB_DELPHI}
    if (LoadFromRes) then
      CM.LoadFromResource(Instance, NegativeZ)
    else
{$ENDIF}
      CM.LoadFromFile(NegativeZ);
    CM.GenerateCubeMap(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z);

    Texture := CM.ID;
    Result := True;
  finally
    CM.Free;
  end;
end;

function LoadNormalMap(Size: Integer; var Texture: Cardinal): Boolean;
var
  NM: TglBitmapNormalMap;
begin
  Texture := 0;

  NM := TglBitmapNormalMap.Create;
  try
    NM.DeleteTextureOnFree := false;
    NM.GenerateNormalMap(Size);

    Texture := NM.ID;
    Result := True;
  finally
    NM.Free;
  end;
end;

{ *
  ** Defaults
  * }
procedure glBitmapSetDefaultFormat(Format: TglBitmapFormat);
begin
  glBitmapDefaultFormat := Format;
end;

procedure glBitmapSetDefaultDeleteTextureOnFree(DeleteTextureOnFree: Boolean);
begin
  glBitmapDefaultDeleteTextureOnFree := DeleteTextureOnFree;
end;

procedure glBitmapSetDefaultFilter(Min, Mag: Integer);
begin
  glBitmapDefaultFilterMin := Min;
  glBitmapDefaultFilterMag := Mag;
end;

procedure glBitmapSetDefaultWrap(S: Integer; T: Integer; R: Integer);
begin
  glBitmapDefaultWrapS := S;
  glBitmapDefaultWrapT := T;
  glBitmapDefaultWrapR := R;
end;

procedure glBitmapSetDefaultFreeDataAfterGenTexture(FreeData: Boolean);
begin
  glBitmapDefaultFreeDataAfterGenTextures := FreeData;
end;

function glBitmapGetDefaultFormat: TglBitmapFormat;
begin
  Result := glBitmapDefaultFormat;
end;

function glBitmapGetDefaultDeleteTextureOnFree: Boolean;
begin
  Result := glBitmapDefaultDeleteTextureOnFree;
end;

procedure glBitmapGetDefaultFilter(var Min, Mag: Integer);
begin
  Min := glBitmapDefaultFilterMin;
  Mag := glBitmapDefaultFilterMag;
end;

procedure glBitmapGetDefaultTextureWrap(var S, T, R: Integer);
begin
  S := glBitmapDefaultWrapS;
  T := glBitmapDefaultWrapT;
  R := glBitmapDefaultWrapR;
end;

function glBitmapGetDefaultFreeDataAfterGenTexture: Boolean;
begin
  Result := glBitmapDefaultFreeDataAfterGenTextures;
end;

{ TglBitmap }

procedure TglBitmap.AfterConstruction;
begin
  inherited;

  fID := 0;
  fTarget := 0;
  fMipMap := mmMipmap;
  fIsResident := false;

  // get defaults
  fFreeDataAfterGenTexture := glBitmapGetDefaultFreeDataAfterGenTexture;
  fDeleteTextureOnFree := glBitmapGetDefaultDeleteTextureOnFree;

  fFormat := glBitmapGetDefaultFormat;

  glBitmapGetDefaultFilter(fFilterMin, fFilterMag);
  glBitmapGetDefaultTextureWrap(fWrapS, fWrapT, fWrapR);
end;

procedure TglBitmap.BeforeDestruction;
begin
  SetDataPointer(nil, ifEmpty);

  if ((ID > 0) and (fDeleteTextureOnFree)) then
    glDeleteTextures(1, @ID);

  inherited;
end;

constructor TglBitmap.Create;
begin
{$IFNDEF GLB_NO_NATIVE_GL}
  ReadOpenGLExtensions;
{$ENDIF}
  if (ClassType = TglBitmap) then
    raise EglBitmapException.Create('Don''t create TglBitmap directly. Use one of the deviated classes (TglBitmap2D) instead.');

  inherited Create;
end;

constructor TglBitmap.Create(Filename: String);
begin
  Create;
  LoadFromFile(Filename);
end;

constructor TglBitmap.Create(Stream: PStream);
begin
  Create;
  LoadFromStream(Stream);
end;

{$IFDEF GLB_DELPHI}

constructor TglBitmap.CreateFromResourceName(Instance: Cardinal; Resource: String; ResType: PChar);
begin
  Create;
  LoadFromResource(Instance, Resource, ResType);
end;

constructor TglBitmap.Create(Instance: Cardinal; Resource: String; ResType: PChar);
begin
  Create;
  LoadFromResource(Instance, Resource, ResType);
end;

constructor TglBitmap.Create(Instance: Cardinal; ResourceID: Integer; ResType: PChar);
begin
  Create;
  LoadFromResourceID(Instance, ResourceID, ResType);
end;
{$ENDIF}

constructor TglBitmap.Create(Size: TglBitmapPixelPosition; Format: TglBitmapInternalFormat);
var
  Image: pByte;
  imageSize: Integer;
begin
  Create;

  imageSize := FormatGetImageSize(Size, Format);
  GetMem(Image, imageSize);
  try
    FillChar(Image^, imageSize, #$FF);

    SetDataPointer(Image, Format, Size.X, Size.Y);
  except
    FreeMem(Image);
    raise;
  end;
end;

constructor TglBitmap.Create(Size: TglBitmapPixelPosition; Format: TglBitmapInternalFormat; Func: TglBitmapFunction; CustomData: Pointer);
begin
  Create;
  LoadFromFunc(Size, Func, Format, CustomData);
end;

function TglBitmap.Clone: TglBitmap;
var
  Temp: TglBitmap;
  TempPtr: pByte;
  Size: Integer;
begin
  Temp := ClassType.Create as TglBitmap;
  try
    // copy texture data if assigned
    if Assigned(Data) then
    begin
      Size := FormatGetImageSize(glBitmapPosition(width, height), internalformat);

      GetMem(TempPtr, Size);
      try
        Move(Data^, TempPtr^, Size);
        Temp.SetDataPointer(TempPtr, internalformat, width, height);
      except
        FreeMem(TempPtr);
        raise;
      end;
    end
    else
      Temp.SetDataPointer(nil, internalformat, width, height);

    // copy properties
    Temp.fID := ID;
    Temp.fTarget := target;
    Temp.fFormat := Format;
    Temp.fMipMap := MipMap;
    Temp.fAnisotropic := Anisotropic;
    Temp.fBorderColor := fBorderColor;
    Temp.fDeleteTextureOnFree := DeleteTextureOnFree;
    Temp.fFreeDataAfterGenTexture := FreeDataAfterGenTexture;
    Temp.fFilterMin := fFilterMin;
    Temp.fFilterMag := fFilterMag;
    Temp.fWrapS := fWrapS;
    Temp.fWrapT := fWrapT;
    Temp.fWrapR := fWrapR;
    Temp.fFilename := fFilename;
    Temp.fCustomName := fCustomName;
    Temp.fCustomNameW := fCustomNameW;
    Temp.fCustomDataPointer := fCustomDataPointer;

    Result := Temp;
  except
    Temp.Free;
    raise;
  end;
end;

procedure TglBitmap.LoadFromFile(Filename: String);
var
  FS: PStream;
begin
  fFilename := Filename;
  FS := NewReadFileStream(Filename);
  try
    FS.Position := 0;
    LoadFromStream(FS);
  finally
    FS.Free;
  end;
end;

procedure TglBitmap.LoadFromStream(Stream: PStream);
begin
{$IFDEF GLB_SUPPORT_PNG_READ}
  if not LoadPNG(Stream) then
{$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_READ}
    if not LoadJPEG(Stream) then
{$ENDIF}
      if not LoadDDS(Stream) then
        if not LoadTGA(Stream) then
          if not LoadBMP(Stream) then
            raise EglBitmapException.Create('LoadFromStream - Couldn''t load Stream. It''s possible to be an unknown Streamtype.');
end;

{$IFDEF GLB_DELPHI}

procedure TglBitmap.LoadFromResource(Instance: Cardinal; Resource: String; ResType: PChar);
var
  RS: PStream;
  TempPos: Integer;
  ResTypeStr: String;
  TempResType: PChar;
begin
  if Assigned(ResType) then
    TempResType := ResType
  else
  begin
    TempPos := Pos('.', Resource);
    ResTypeStr := UpperCase(Copy(Resource, TempPos + 1, Length(Resource) - TempPos));
    Resource := UpperCase(Copy(Resource, 0, TempPos - 1));
    TempResType := PChar(ResTypeStr);
  end;
  RS := NewResourceStream(Instance, PChar(Resource), TempResType);
  try
    LoadFromStream(RS);
  finally
    RS.Free;
  end;
end;

procedure TglBitmap.LoadFromResourceID(Instance: Cardinal; ResourceID: Integer; ResType: PChar);
var
  RS: PStream;
begin
  RS := NewResourceStreamID(Instance, ResourceID, ResType);
  try
    LoadFromStream(RS);
  finally
    RS.Free;
  end;
end;
{$ENDIF}

procedure TglBitmap.LoadFromFunc(Size: TglBitmapPixelPosition; Func: TglBitmapFunction; Format: TglBitmapInternalFormat; CustomData: Pointer);
var
  Image: pByte;
  imageSize: Integer;
begin
  imageSize := FormatGetImageSize(Size, Format);
  GetMem(Image, imageSize);
  try
    FillChar(Image^, imageSize, #$FF);

    SetDataPointer(Image, Format, Size.X, Size.Y);
  except
    FreeMem(Image);
    raise;
  end;

  AddFunc(Self, Func, false, Format, CustomData)
end;

procedure TglBitmap.SaveToFile(Filename: String; FileType: TglBitmapFileType);
var
  FS: PStream;
begin
  FS := NewWriteFileStream(Filename);
  try
    FS.Position := 0;
    SaveToStream(FS, FileType);
  finally
    FS.Free;
  end;
end;

procedure TglBitmap.SaveToStream(Stream: PStream; FileType: TglBitmapFileType);
begin
  case FileType of
{$IFDEF GLB_SUPPORT_PNG_WRITE}
    ftPNG:
      SavePNG(Stream);
{$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_WRITE}
    ftJPEG:
      SaveJPEG(Stream);
{$ENDIF}
    ftDDS:
      SaveDDS(Stream);
    ftTGA:
      SaveTGA(Stream);
    ftBMP:
      SaveBMP(Stream);
  end;
end;

{$IFDEF GLB_SDL}

function TglBitmap.AssignToSurface(out Surface: PSDL_Surface): Boolean;
var
  Row, RowSize: Integer;
  pSource, pData: pByte;
  TempDepth: Integer;
  Pix: TglBitmapPixelData;

  function GetRowPointer(Row: Integer): pByte;
  begin
    Result := Surface.pixels;
    Inc(Result, Row * RowSize);
  end;

begin
  Result := false;

  if not FormatIsUncompressed(internalformat) then
    raise EglBitmapUnsupportedInternalFormat.Create('AssignToSurface - ' + UNSUPPORTED_INTERNAL_FORMAT);

  if Assigned(Data) then
  begin
    case Trunc(FormatGetSize(internalformat)) of
      1:
        TempDepth := 8;
      2:
        TempDepth := 16;
      3:
        TempDepth := 24;
      4:
        TempDepth := 32;
    else
      raise EglBitmapException.Create('AssignToSurface - ' + UNSUPPORTED_INTERNAL_FORMAT);
    end;

    FormatPreparePixel(Pix, internalformat);

    with Pix.PixelDesc do
      Surface := SDL_CreateRGBSurface(SDL_SWSURFACE, width, height, TempDepth, RedRange shl RedShift, GreenRange shl GreenShift, BlueRange shl BlueShift, AlphaRange shl AlphaShift);

    pSource := Data;
    RowSize := Trunc(FileWidth * FormatGetSize(internalformat));

    for Row := 0 to FileHeight - 1 do
    begin
      pData := GetRowPointer(Row);

      if Assigned(pData) then
      begin
        Move(pSource^, pData^, RowSize);
        Inc(pSource, RowSize);
      end;
    end;

    Result := True;
  end;
end;

function TglBitmap.AssignFromSurface(const Surface: PSDL_Surface): Boolean;
var
  pSource, pData, pTempData: pByte;
  Row, RowSize, TempWidth, TempHeight: Integer;
  IntFormat: TglBitmapInternalFormat;

  function GetRowPointer(Row: Integer): pByte;
  begin
    Result := Surface^.pixels;
    Inc(Result, Row * RowSize);
  end;

begin
  Result := false;

  if (Assigned(Surface)) then
  begin
    with Surface^.Format^ do
    begin
      if FormatCheckFormat(RMask, GMask, BMask, AMask, ifLuminance) then
        IntFormat := ifLuminance
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifLuminanceAlpha) then
        IntFormat := ifLuminanceAlpha
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifRGBA4) then
        IntFormat := ifRGBA4
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifR5G6B5) then
        IntFormat := ifR5G6B5
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifRGB5A1) then
        IntFormat := ifRGB5A1
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifBGR8) then
        IntFormat := ifBGR8
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifRGB8) then
        IntFormat := ifRGB8
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifBGRA8) then
        IntFormat := ifBGRA8
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifRGBA8) then
        IntFormat := ifRGBA8
      else

        if FormatCheckFormat(RMask, GMask, BMask, AMask, ifRGB10A2) then
        IntFormat := ifRGB10A2
      else
        raise EglBitmapException.Create('AssignFromSurface - Invalid Pixelformat.');
    end;

    TempWidth := Surface^.w;
    TempHeight := Surface^.h;

    RowSize := Trunc(TempWidth * FormatGetSize(IntFormat));

    GetMem(pData, TempHeight * RowSize);
    try
      pTempData := pData;

      for Row := 0 to TempHeight - 1 do
      begin
        pSource := GetRowPointer(Row);

        if (Assigned(pSource)) then
        begin
          Move(pSource^, pTempData^, RowSize);
          Inc(pTempData, RowSize);
        end;
      end;

      SetDataPointer(pData, IntFormat, TempWidth, TempHeight);

      Result := True;
    except
      FreeMem(pData);
      raise;
    end;
  end;
end;

function TglBitmap.AssignAlphaToSurface(out Surface: PSDL_Surface): Boolean;
var
  Row, Col, AlphaInterleave: Integer;
  pSource, pDest: pByte;

  function GetRowPointer(Row: Integer): pByte;
  begin
    Result := Surface.pixels;
    Inc(Result, Row * width);
  end;

begin
  Result := false;

  if Assigned(Data) then
  begin
    if internalformat in [ifAlpha, ifLuminanceAlpha, ifBGRA8, ifRGBA8] then
    begin
      Surface := SDL_CreateRGBSurface(SDL_SWSURFACE, width, height, 8, $FF, $FF, $FF, 0);

      case internalformat of
        ifLuminanceAlpha:
          AlphaInterleave := 1;
        ifBGRA8, ifRGBA8:
          AlphaInterleave := 3;
      else
        AlphaInterleave := 0;
      end;

      // Copy Data
      pSource := Data;

      for Row := 0 to height - 1 do
      begin
        pDest := GetRowPointer(Row);

        if Assigned(pDest) then
        begin
          for Col := 0 to width - 1 do
          begin
            Inc(pSource, AlphaInterleave);
            pDest^ := pSource^;
            Inc(pDest);
            Inc(pSource);
          end;
        end;
      end;

      Result := True;
    end;
  end;
end;

function TglBitmap.AddAlphaFromSurface(Surface: PSDL_Surface; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  glBitmap: TglBitmap2D;
begin
  glBitmap := TglBitmap2D.Create;
  try
    glBitmap.AssignFromSurface(Surface);

    Result := AddAlphaFromglBitmap(glBitmap, Func, CustomData);
  finally
    glBitmap.Free;
  end;
end;
{$ENDIF}
{$IFDEF GLB_DELPHI_GRAPHICS}

function TglBitmap.AssignFromBitmap(const Bitmap: TBitmap): Boolean;
var
  pSource, pData, pTempData: pByte;
  Row, RowSize, TempWidth, TempHeight: Integer;
  IntFormat: TglBitmapInternalFormat;
begin
  Result := false;

  if (Assigned(Bitmap)) then
  begin
    case Bitmap.PixelFormat of
      pf8bit:
        IntFormat := ifLuminance;
      pf15bit:
        IntFormat := ifRGB5A1;
      pf16bit:
        IntFormat := ifR5G6B5;
      pf24bit:
        IntFormat := ifBGR8;
      pf32bit:
        IntFormat := ifBGRA8;
    else
      raise EglBitmapException.Create('AssignFromBitmap - Invalid Pixelformat.');
    end;

    TempWidth := Bitmap.width;
    TempHeight := Bitmap.height;

    RowSize := Trunc(TempWidth * FormatGetSize(IntFormat));

    GetMem(pData, TempHeight * RowSize);
    try
      pTempData := pData;

      for Row := 0 to TempHeight - 1 do
      begin
        pSource := Bitmap.Scanline[Row];

        if (Assigned(pSource)) then
        begin
          Move(pSource^, pTempData^, RowSize);
          Inc(pTempData, RowSize);
        end;
      end;

      SetDataPointer(pData, IntFormat, TempWidth, TempHeight);

      Result := True;
    except
      FreeMem(pData);
      raise;
    end;
  end;
end;

function TglBitmap.AssignToBitmap(const Bitmap: TBitmap): Boolean;
var
  Row: Integer;
  pSource, pData: pByte;
begin
  Result := false;

  if Assigned(Data) then
  begin
    if Assigned(Bitmap) then
    begin
      Bitmap.width := width;
      Bitmap.height := height;

      case internalformat of
        ifAlpha, ifLuminance, ifDepth8:
          begin
            Bitmap.PixelFormat := pf8bit;
            Bitmap.Palette := CreateGrayPalette;
          end;
        ifRGB5A1:
          Bitmap.PixelFormat := pf15bit;
        ifR5G6B5:
          Bitmap.PixelFormat := pf16bit;
        ifRGB8, ifBGR8:
          Bitmap.PixelFormat := pf24bit;
        ifRGBA8, ifBGRA8:
          Bitmap.PixelFormat := pf32bit;
      else
        raise EglBitmapException.Create('AssignToBitmap - Invalid Pixelformat.');
      end;

      pSource := Data;
      for Row := 0 to FileHeight - 1 do
      begin
        pData := Bitmap.Scanline[Row];

        Move(pSource^, pData^, fRowSize);
        Inc(pSource, fRowSize);

        // swap RGB(A) to BGR(A)
        if internalformat in [ifRGB8, ifRGBA8] then
          SwapRGB(pData, FileWidth, internalformat = ifRGBA8);
      end;

      Result := True;
    end;
  end;
end;

function TglBitmap.AssignAlphaToBitmap(const Bitmap: TBitmap): Boolean;
var
  Row, Col, AlphaInterleave: Integer;
  pSource, pDest: pByte;
begin
  Result := false;

  if Assigned(Data) then
  begin
    if internalformat in [ifAlpha, ifLuminanceAlpha, ifRGBA8, ifBGRA8] then
    begin
      if Assigned(Bitmap) then
      begin
        Bitmap.PixelFormat := pf8bit;
        Bitmap.Palette := CreateGrayPalette;
        Bitmap.width := width;
        Bitmap.height := height;

        case internalformat of
          ifLuminanceAlpha:
            AlphaInterleave := 1;
          ifRGBA8, ifBGRA8:
            AlphaInterleave := 3;
        else
          AlphaInterleave := 0;
        end;

        // Copy Data
        pSource := Data;

        for Row := 0 to height - 1 do
        begin
          pDest := Bitmap.Scanline[Row];

          if Assigned(pDest) then
          begin
            for Col := 0 to width - 1 do
            begin
              Inc(pSource, AlphaInterleave);
              pDest^ := pSource^;
              Inc(pDest);
              Inc(pSource);
            end;
          end;
        end;

        Result := True;
      end;
    end;
  end;
end;

function TglBitmap.AddAlphaFromBitmap(Bitmap: TBitmap; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  glBitmap: TglBitmap2D;
begin
  glBitmap := TglBitmap2D.Create;
  try
    glBitmap.AssignFromBitmap(Bitmap);

    Result := AddAlphaFromglBitmap(glBitmap, Func, CustomData);
  finally
    glBitmap.Free;
  end;
end;
{$ENDIF}

function TglBitmap.AddAlphaFromFile(Filename: String; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  FS: PStream;
begin
  FS := NewReadFileStream(Filename);
  try
    Result := AddAlphaFromStream(FS, Func, CustomData);
  finally
    FS.Free;
  end;
end;

function TglBitmap.AddAlphaFromStream(Stream: PStream; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  glBitmap: TglBitmap2D;
begin
  glBitmap := TglBitmap2D.Create(Stream);
  try
    Result := AddAlphaFromglBitmap(glBitmap, Func, CustomData);
  finally
    glBitmap.Free;
  end;
end;

{$IFDEF GLB_DELPHI}

function TglBitmap.AddAlphaFromResource(Instance: Cardinal; Resource: String; ResType: PChar; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  RS: PStream;
  TempPos: Integer;
  ResTypeStr: String;
  TempResType: PChar;
begin
  if Assigned(ResType) then
    TempResType := ResType
  else
  begin
    TempPos := Pos('.', Resource);
    ResTypeStr := UpperCase(Copy(Resource, TempPos + 1, Length(Resource) - TempPos));
    Resource := UpperCase(Copy(Resource, 0, TempPos - 1));
    TempResType := PChar(ResTypeStr);
  end;

  RS := NewResourceStream(Instance, Resource, TempResType);
  try
    Result := AddAlphaFromStream(RS, Func, CustomData);
  finally
    RS.Free;
  end;
end;

function TglBitmap.AddAlphaFromResourceID(Instance: Cardinal; ResourceID: Integer; ResType: PChar; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  RS: PStream;
begin
  RS := NewResourceStreamID(Instance, ResourceID, ResType);
  try
    Result := AddAlphaFromStream(RS, Func, CustomData);
  finally
    RS.Free;
  end;
end;
{$ENDIF}

procedure glBitmapColorKeyAlphaFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
  begin
    Dest.Red := Source.Red;
    Dest.Green := Source.Green;
    Dest.Blue := Source.Blue;

    with TglBitmapPixelData(CustomData^) do
      if ((Dest.Red <= Red) and (Dest.Red >= PixelDesc.RedRange) and (Dest.Green <= Green) and (Dest.Green >= PixelDesc.GreenRange) and (Dest.Blue <= Blue) and (Dest.Blue >= PixelDesc.BlueRange)) then
        Dest.Alpha := 0
      else
        Dest.Alpha := Dest.PixelDesc.AlphaRange;
  end;
end;

function TglBitmap.AddAlphaFromColorKey(Red, Green, Blue, Deviation: Byte): Boolean;
begin
  Result := AddAlphaFromColorKeyFloat(Red / $FF, Green / $FF, Blue / $FF, Deviation / $FF);
end;

function TglBitmap.AddAlphaFromColorKeyRange(Red, Green, Blue: Cardinal; Deviation: Cardinal = 0): Boolean;
var
  PixelData: TglBitmapPixelData;
begin
  FormatPreparePixel(PixelData, FormatGetWithAlpha(internalformat));

  Result := AddAlphaFromColorKeyFloat(Red / PixelData.PixelDesc.RedRange, Green / PixelData.PixelDesc.GreenRange, Blue / PixelData.PixelDesc.BlueRange, Deviation / Max(PixelData.PixelDesc.RedRange, Max(PixelData.PixelDesc.GreenRange, PixelData.PixelDesc.BlueRange)));
end;

function TglBitmap.AddAlphaFromColorKeyFloat(Red, Green, Blue: single; Deviation: single = 0): Boolean;
var
  TempR, TempG, TempB: Cardinal;
  PixelData: TglBitmapPixelData;
begin
  FormatPreparePixel(PixelData, FormatGetWithAlpha(internalformat));

  // Calculate Colorrange
  with PixelData.PixelDesc do
  begin
    TempR := Trunc(RedRange * Deviation);
    TempG := Trunc(GreenRange * Deviation);
    TempB := Trunc(BlueRange * Deviation);

    PixelData.Red := Min(RedRange, Trunc(RedRange * Red) + TempR);
    RedRange := Max(0, Trunc(RedRange * Red) - TempR);
    PixelData.Green := Min(GreenRange, Trunc(GreenRange * Green) + TempG);
    GreenRange := Max(0, Trunc(GreenRange * Green) - TempG);
    PixelData.Blue := Min(BlueRange, Trunc(BlueRange * Blue) + TempB);
    BlueRange := Max(0, Trunc(BlueRange * Blue) - TempB);
    PixelData.Alpha := 0;
    AlphaRange := 0;
  end;

  Result := AddAlphaFromFunc(glBitmapColorKeyAlphaFunc, @PixelData);
end;

procedure glBitmapValueAlphaFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
  begin
    Dest.Red := Source.Red;
    Dest.Green := Source.Green;
    Dest.Blue := Source.Blue;

    with TglBitmapPixelData(CustomData^) do
      Dest.Alpha := Alpha;
  end;
end;

function TglBitmap.AddAlphaFromValue(Alpha: Byte): Boolean;
begin
  Result := AddAlphaFromValueFloat(Alpha / $FF);
end;

function TglBitmap.AddAlphaFromValueFloat(Alpha: single): Boolean;
var
  PixelData: TglBitmapPixelData;
begin
  FormatPreparePixel(PixelData, FormatGetWithAlpha(internalformat));

  with PixelData.PixelDesc do
    PixelData.Alpha := Min(AlphaRange, Max(0, Round(AlphaRange * Alpha)));

  Result := AddAlphaFromFunc(glBitmapValueAlphaFunc, @PixelData);
end;

function TglBitmap.AddAlphaFromValueRange(Alpha: Cardinal): Boolean;
var
  PixelData: TglBitmapPixelData;
begin
  FormatPreparePixel(PixelData, FormatGetWithAlpha(internalformat));

  Result := AddAlphaFromValueFloat(Alpha / PixelData.PixelDesc.AlphaRange);
end;

procedure glBitmapInvertFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
  begin
    Dest.Red := Source.Red;
    Dest.Green := Source.Green;
    Dest.Blue := Source.Blue;
    Dest.Alpha := Source.Alpha;

    if (Integer(CustomData) and $1 > 0) then
    begin
      Dest.Red := Dest.Red xor Dest.PixelDesc.RedRange;
      Dest.Green := Dest.Green xor Dest.PixelDesc.GreenRange;
      Dest.Blue := Dest.Blue xor Dest.PixelDesc.BlueRange;
    end;

    if (Integer(CustomData) and $2 > 0) then
    begin
      Dest.Alpha := Dest.Alpha xor Dest.PixelDesc.AlphaRange;
    end;
  end;
end;

procedure TglBitmap.Invert(UseRGB, UseAlpha: Boolean);
begin
  if ((UseRGB) or (UseAlpha)) then
    AddFunc(glBitmapInvertFunc, false, Pointer(Integer(UseAlpha) shl 1 or Integer(UseRGB)));
end;

procedure TglBitmap.SetFilter(Min, Mag: Integer);
begin
  case Min of
    GL_NEAREST:
      fFilterMin := GL_NEAREST;
    GL_LINEAR:
      fFilterMin := GL_LINEAR;
    GL_NEAREST_MIPMAP_NEAREST:
      fFilterMin := GL_NEAREST_MIPMAP_NEAREST;
    GL_LINEAR_MIPMAP_NEAREST:
      fFilterMin := GL_LINEAR_MIPMAP_NEAREST;
    GL_NEAREST_MIPMAP_LINEAR:
      fFilterMin := GL_NEAREST_MIPMAP_LINEAR;
    GL_LINEAR_MIPMAP_LINEAR:
      fFilterMin := GL_LINEAR_MIPMAP_LINEAR;
  else
    raise EglBitmapException.Create('SetFilter - Unknown Minfilter.');
  end;

  case Mag of
    GL_NEAREST:
      fFilterMag := GL_NEAREST;
    GL_LINEAR:
      fFilterMag := GL_LINEAR;
  else
    raise EglBitmapException.Create('SetFilter - Unknown Magfilter.');
  end;

  // If texture is created then assign filter
  if ID > 0 then
  begin
    Bind(false);

    glTexParameteri(target, GL_TEXTURE_MAG_FILTER, fFilterMag);

    if (MipMap = mmNone) or (target = GL_TEXTURE_RECTANGLE_ARB) then
    begin
      case fFilterMin of
        GL_NEAREST, GL_LINEAR:
          glTexParameteri(target, GL_TEXTURE_MIN_FILTER, fFilterMin);
        GL_NEAREST_MIPMAP_NEAREST, GL_NEAREST_MIPMAP_LINEAR:
          glTexParameteri(target, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        GL_LINEAR_MIPMAP_NEAREST, GL_LINEAR_MIPMAP_LINEAR:
          glTexParameteri(target, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
      end;
    end
    else
      glTexParameteri(target, GL_TEXTURE_MIN_FILTER, fFilterMin);
  end;
end;

procedure TglBitmap.SetWrap(S: Integer; T: Integer; R: Integer);
begin
  case S of
    GL_CLAMP:
      fWrapS := GL_CLAMP;
    GL_REPEAT:
      fWrapS := GL_REPEAT;
    GL_CLAMP_TO_EDGE:
      begin
        if GL_VERSION_1_2 or GL_EXT_texture_edge_clamp then
          fWrapS := GL_CLAMP_TO_EDGE
        else
          fWrapS := GL_CLAMP;
      end;
    GL_CLAMP_TO_BORDER:
      begin
        if GL_VERSION_1_3 or GL_ARB_texture_border_clamp then
          fWrapS := GL_CLAMP_TO_BORDER
        else
          fWrapS := GL_CLAMP;
      end;
    GL_MIRRORED_REPEAT:
      begin
        if GL_VERSION_1_4 or GL_ARB_texture_mirrored_repeat or GL_IBM_texture_mirrored_repeat then
          fWrapS := GL_MIRRORED_REPEAT
        else
          raise EglBitmapException.Create('SetWrap - Unsupported Texturewrap GL_MIRRORED_REPEAT (S).');
      end;
  else
    raise EglBitmapException.Create('SetWrap - Unknow Texturewrap (S).');
  end;

  case T of
    GL_CLAMP:
      fWrapT := GL_CLAMP;
    GL_REPEAT:
      fWrapT := GL_REPEAT;
    GL_CLAMP_TO_EDGE:
      begin
        if GL_VERSION_1_2 or GL_EXT_texture_edge_clamp then
          fWrapT := GL_CLAMP_TO_EDGE
        else
          fWrapT := GL_CLAMP;
      end;
    GL_CLAMP_TO_BORDER:
      begin
        if GL_VERSION_1_3 or GL_ARB_texture_border_clamp then
          fWrapT := GL_CLAMP_TO_BORDER
        else
          fWrapT := GL_CLAMP;
      end;
    GL_MIRRORED_REPEAT:
      begin
        if GL_VERSION_1_4 or GL_ARB_texture_mirrored_repeat or GL_IBM_texture_mirrored_repeat then
          fWrapT := GL_MIRRORED_REPEAT
        else
          raise EglBitmapException.Create('SetWrap - Unsupported Texturewrap GL_MIRRORED_REPEAT (T).');
      end;
  else
    raise EglBitmapException.Create('SetWrap - Unknow Texturewrap (T).');
  end;

  case R of
    GL_CLAMP:
      fWrapR := GL_CLAMP;
    GL_REPEAT:
      fWrapR := GL_REPEAT;
    GL_CLAMP_TO_EDGE:
      begin
        if GL_VERSION_1_2 or GL_EXT_texture_edge_clamp then
          fWrapR := GL_CLAMP_TO_EDGE
        else
          fWrapR := GL_CLAMP;
      end;
    GL_CLAMP_TO_BORDER:
      begin
        if GL_VERSION_1_3 or GL_ARB_texture_border_clamp then
          fWrapR := GL_CLAMP_TO_BORDER
        else
          fWrapR := GL_CLAMP;
      end;
    GL_MIRRORED_REPEAT:
      begin
        if GL_VERSION_1_4 or GL_ARB_texture_mirrored_repeat or GL_IBM_texture_mirrored_repeat then
          fWrapR := GL_MIRRORED_REPEAT
        else
          raise EglBitmapException.Create('SetWrap - Unsupported Texturewrap GL_MIRRORED_REPEAT (R).');
      end;
  else
    raise EglBitmapException.Create('SetWrap - Unknow Texturewrap (R).');
  end;

  if ID > 0 then
  begin
    Bind(false);
    glTexParameteri(target, GL_TEXTURE_WRAP_S, fWrapS);
    glTexParameteri(target, GL_TEXTURE_WRAP_T, fWrapT);
    glTexParameteri(target, GL_TEXTURE_WRAP_R, fWrapR);
  end;
end;

procedure TglBitmap.SetDataPointer(NewData: pByte; Format: TglBitmapInternalFormat; width, height: Integer);
begin
  // Data
  if Data <> NewData then
  begin
    if (Assigned(Data)) then
      FreeMem(Data);

    fData := NewData;
  end;

  if Data = nil then
  begin
    fInternalFormat := ifEmpty;
    fPixelSize := 0;
    fRowSize := 0;
  end
  else
  begin
    if width <> -1 then
    begin
      fDimension.Fields := fDimension.Fields + [ffX];
      fDimension.X := width;
    end;

    if height <> -1 then
    begin
      fDimension.Fields := fDimension.Fields + [ffY];
      fDimension.Y := height;
    end;

    fInternalFormat := Format;
    fPixelSize := Trunc(FormatGetSize(internalformat));
    fRowSize := Trunc(FormatGetSize(internalformat) * Self.width);
  end;
end;

{$IFDEF GLB_SUPPORT_PNG_READ}
{$IFDEF GLB_LIB_PNG}

procedure glBitmap_libPNG_read_func(png: png_structp; Buffer: png_bytep; Size: Cardinal); cdecl;
begin
  PStream(png_get_io_ptr(png)).Read(Buffer^, Size);
end;
{$ENDIF}

function TglBitmap.LoadPNG(Stream: PStream): Boolean;
{$IFDEF GLB_SDL_IMAGE}
var
  Surface: PSDL_Surface;
  RWops: PSDL_RWops;
begin
  Result := false;

  RWops := glBitmapCreateRWops(Stream);
  try
    if IMG_isPNG(RWops) > 0 then
    begin
      Surface := IMG_LoadPNG_RW(RWops);
      try
        AssignFromSurface(Surface);
        Result := True;
      finally
        SDL_FreeSurface(Surface);
      end;
    end;
  finally
    SDL_FreeRW(RWops);
  end;
end;
{$ENDIF}
{$IFDEF GLB_LIB_PNG}

var
  StreamPos: Int64;
  signature: array [0 .. 7] of Byte;
  png: png_structp;
  png_info: png_infop;

  TempHeight, TempWidth: Integer;
  Format: TglBitmapInternalFormat;

  png_data: pByte;
  png_rows: array of pByte;
  Row, LineSize: Integer;
begin
  Result := false;

  if not init_libPNG then
    raise Exception.Create('LoadPNG - unable to initialize libPNG.');

  try
    // signature
    StreamPos := Stream.Position;
    Stream.Read(signature, 8);
    Stream.Position := StreamPos;

    if png_check_sig(@signature, 8) <> 0 then
    begin
      // png read struct
      png := png_create_read_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil);
      if png = nil then
        raise EglBitmapException.Create('LoadPng - couldn''t create read struct.');

      // png info
      png_info := png_create_info_struct(png);
      if png_info = nil then
      begin
        png_destroy_read_struct(@png, nil, nil);
        raise EglBitmapException.Create('LoadPng - couldn''t create info struct.');
      end;

      // set read callback
      png_set_read_fn(png, Stream, glBitmap_libPNG_read_func);

      // read informations
      png_read_info(png, png_info);

      // size
      TempHeight := png_get_image_height(png, png_info);
      TempWidth := png_get_image_width(png, png_info);

      // format
      case png_get_color_type(png, png_info) of
        PNG_COLOR_TYPE_GRAY:
          Format := ifLuminance;
        PNG_COLOR_TYPE_GRAY_ALPHA:
          Format := ifLuminanceAlpha;
        PNG_COLOR_TYPE_RGB:
          Format := ifRGB8;
        PNG_COLOR_TYPE_RGB_ALPHA:
          Format := ifRGBA8;
      else
        raise EglBitmapException.Create('LoadPng - Unsupported Colortype found.');
      end;

      // cut upper 8 bit from 16 bit formats
      if png_get_bit_depth(png, png_info) > 8 then
        png_set_strip_16(png);

      // expand bitdepth smaller than 8
      if png_get_bit_depth(png, png_info) < 8 then
        png_set_expand(png);

      // allocating mem for scanlines
      LineSize := png_get_rowbytes(png, png_info);
      GetMem(png_data, TempHeight * LineSize);
      try
        SetLength(png_rows, TempHeight);
        for Row := Low(png_rows) to High(png_rows) do
        begin
          png_rows[Row] := png_data;
          Inc(png_rows[Row], Row * LineSize);
        end;

        // read complete image into scanlines
        png_read_image(png, @png_rows[0]);

        // read end
        png_read_end(png, png_info);

        // destroy read struct
        png_destroy_read_struct(@png, @png_info, nil);

        SetLength(png_rows, 0);

        // set new data
        SetDataPointer(png_data, Format, TempWidth, TempHeight);

        Result := True;
      except
        FreeMem(png_data);
        raise;
      end;
    end;
  finally
    quit_libPNG;
  end;
end;
{$ENDIF}
{$IFDEF KOL_PNGIMAGE}

var
  StreamPos: Int64;
  png: PPNGObject;
  Header: Array [0 .. 7] of AnsiChar;
  Row, Col, PixSize, LineSize: Integer;
  NewImage, pSource, pDest, pAlpha: pByte;
  Format: TglBitmapInternalFormat;

const
  PngHeader: Array [0 .. 7] of AnsiChar = (#137, #80, #78, #71, #13, #10, #26, #10);

begin
  Result := false;

  StreamPos := Stream.Position;
  Stream.Read(Header[0], SizeOf(Header));
  Stream.Position := StreamPos;

  { Test if the header matches }
  if Header = PngHeader then
  begin
    png := NewPngObject;
    try
      png.LoadFromStream(Stream);
      case png.Header.ColorType of
        COLOR_GRAYSCALE:
          Format := ifLuminance;
        COLOR_GRAYSCALEALPHA:
          Format := ifLuminanceAlpha;
        COLOR_RGB:
          Format := ifBGR8;
        COLOR_RGBALPHA:
          Format := ifBGRA8;
      else
        raise EglBitmapException.Create('LoadPng - Unsupported Colortype found.');
      end;

      PixSize := Trunc(FormatGetSize(Format));
      LineSize := Integer(png.Header.width) * PixSize;

      GetMem(NewImage, LineSize * Integer(png.Header.height));
      try
        pDest := NewImage;

        case png.Header.ColorType of
          COLOR_RGB, COLOR_GRAYSCALE:
            begin
              for Row := 0 to png.height - 1 do
              begin
                Move(png.Scanline[Row]^, pDest^, LineSize);
                Inc(pDest, LineSize);
              end;
            end;
          COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA:
            begin
              PixSize := PixSize - 1;

              for Row := 0 to png.height - 1 do
              begin
                pSource := png.Scanline[Row];
                pAlpha := pByte(png.AlphaScanline[Row]);

                for Col := 0 to png.width - 1 do
                begin
                  Move(pSource^, pDest^, PixSize);
                  Inc(pSource, PixSize);
                  Inc(pDest, PixSize);

                  pDest^ := pAlpha^;
                  Inc(pAlpha);
                  Inc(pDest);
                end;
              end;
            end;
        else
          raise EglBitmapException.Create('LoadPng - Unsupported Colortype found.');
        end;

        SetDataPointer(NewImage, Format, png.Header.width, png.Header.height);

        Result := True;
      except
        FreeMem(NewImage);
        raise;
      end;
    finally
      png.Free;
    end;
  end;
end;
{$ENDIF}
{$IFDEF GLB_PNGIMAGE}

var
  StreamPos: Int64;
  png: TPNGObject;
  Header: Array [0 .. 7] of Byte;
  Row, Col, PixSize, LineSize: Integer;
  NewImage, pSource, pDest, pAlpha: pByte;
  Format: TglBitmapInternalFormat;

const
  PngHeader: Array [0 .. 7] of Byte = (#137, #80, #78, #71, #13, #10, #26, #10);

begin
  Result := false;

  StreamPos := Stream.Position;
  Stream.Read(Header[0], SizeOf(Header));
  Stream.Position := StreamPos;

  { Test if the header matches }
  if Header = PngHeader then
  begin
    png := TPNGObject.Create;
    try
      png.LoadFromStream(Stream);

      case png.Header.ColorType of
        COLOR_GRAYSCALE:
          Format := ifLuminance;
        COLOR_GRAYSCALEALPHA:
          Format := ifLuminanceAlpha;
        COLOR_RGB:
          Format := ifBGR8;
        COLOR_RGBALPHA:
          Format := ifBGRA8;
      else
        raise EglBitmapException.Create('LoadPng - Unsupported Colortype found.');
      end;

      PixSize := Trunc(FormatGetSize(Format));
      LineSize := Integer(png.Header.width) * PixSize;

      GetMem(NewImage, LineSize * Integer(png.Header.height));
      try
        pDest := NewImage;

        case png.Header.ColorType of
          COLOR_RGB, COLOR_GRAYSCALE:
            begin
              for Row := 0 to png.height - 1 do
              begin
                Move(png.Scanline[Row]^, pDest^, LineSize);
                Inc(pDest, LineSize);
              end;
            end;
          COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA:
            begin
              PixSize := PixSize - 1;

              for Row := 0 to png.height - 1 do
              begin
                pSource := png.Scanline[Row];
                pAlpha := pByte(png.AlphaScanline[Row]);

                for Col := 0 to png.width - 1 do
                begin
                  Move(pSource^, pDest^, PixSize);
                  Inc(pSource, PixSize);
                  Inc(pDest, PixSize);

                  pDest^ := pAlpha^;
                  Inc(pAlpha);
                  Inc(pDest);
                end;
              end;
            end;
        else
          raise EglBitmapException.Create('LoadPng - Unsupported Colortype found.');
        end;

        SetDataPointer(NewImage, Format, png.Header.width, png.Header.height);

        Result := True;
      except
        FreeMem(NewImage);
        raise;
      end;
    finally
      png.Free;
    end;
  end;
end;
{$ENDIF}
{$ENDIF}
{$IFDEF GLB_LIB_JPEG}

type
  glBitmap_libJPEG_source_mgr_ptr = ^glBitmap_libJPEG_source_mgr;

  glBitmap_libJPEG_source_mgr = record
    pub: jpeg_source_mgr;

    SrcStream: PStream;
    SrcBuffer: array [1 .. 4096] of Byte;
  end;

  glBitmap_libJPEG_dest_mgr_ptr = ^glBitmap_libJPEG_dest_mgr;

  glBitmap_libJPEG_dest_mgr = record
    pub: jpeg_destination_mgr;

    DesPStream: PStream;
    DestBuffer: array [1 .. 4096] of Byte;
  end;

procedure glBitmap_libJPEG_error_exit(cinfo: j_common_ptr); cdecl;
// var
// Msg: String;
begin
  // SetLength(Msg, 256);
  // cinfo^.err^.format_message(cinfo, pChar(Msg));

  // Writeln('ERROR [' + IntToStr(cinfo^.err^.msg_code) + '] ' + Msg);

  // cinfo^.global_state := 0;

  // jpeg_abort(cinfo);
end;

procedure glBitmap_libJPEG_output_message(cinfo: j_common_ptr); cdecl;
// var
// Msg: String;
begin
  // SetLength(Msg, 256);
  // cinfo^.err^.format_message(cinfo, pChar(Msg));

  // Writeln('OUTPUT [' + IntToStr(cinfo^.err^.msg_code) + '] ' + Msg);

  // cinfo^.global_state := 0;
end;

procedure glBitmap_libJPEG_init_source(cinfo: j_decompress_ptr); cdecl;
begin
end;

function glBitmap_libJPEG_fill_input_buffer(cinfo: j_decompress_ptr): Boolean; cdecl;
var
  src: glBitmap_libJPEG_source_mgr_ptr;
  bytes: Integer;
begin
  src := glBitmap_libJPEG_source_mgr_ptr(cinfo^.src);

  bytes := src^.SrcStream.Read(src^.SrcBuffer[1], 4096);
  if (bytes <= 0) then
  begin
    src^.SrcBuffer[1] := $FF;
    src^.SrcBuffer[2] := JPEG_EOI;
    bytes := 2;
  end;

  src^.pub.next_input_byte := @(src^.SrcBuffer[1]);
  src^.pub.bytes_in_buffer := bytes;

  Result := True;
end;

procedure glBitmap_libJPEG_skip_input_data(cinfo: j_decompress_ptr; num_bytes: Longint); cdecl;
var
  src: glBitmap_libJPEG_source_mgr_ptr;
begin
  src := glBitmap_libJPEG_source_mgr_ptr(cinfo^.src);

  if num_bytes > 0 then
  begin
    // wanted byte isn't in buffer so set stream position and read buffer
    if num_bytes > src^.pub.bytes_in_buffer then
    begin
      src^.SrcStream.Position := src^.SrcStream.Position + num_bytes - src^.pub.bytes_in_buffer;
      src^.pub.fill_input_buffer(cinfo);
    end
    else
    begin
      // wanted byte is in buffer so only skip
      Inc(src^.pub.next_input_byte, num_bytes);
      Dec(src^.pub.bytes_in_buffer, num_bytes);
    end;
  end;
end;

procedure glBitmap_libJPEG_term_source(cinfo: j_decompress_ptr); cdecl;
begin
end;

procedure glBitmap_libJPEG_init_destination(cinfo: j_compress_ptr); cdecl;
begin
end;

function glBitmap_libJPEG_empty_output_buffer(cinfo: j_compress_ptr): Boolean; cdecl;
var
  Dest: glBitmap_libJPEG_dest_mgr_ptr;
begin
  Dest := glBitmap_libJPEG_dest_mgr_ptr(cinfo^.Dest);

  if Dest^.pub.free_in_buffer < Cardinal(Length(Dest^.DestBuffer)) then
  begin
    // write complete buffer
    Dest^.DesPStream.Write(Dest^.DestBuffer[1], SizeOf(Dest^.DestBuffer));

    // reset buffer
    Dest^.pub.next_output_byte := @Dest^.DestBuffer[1];
    Dest^.pub.free_in_buffer := Length(Dest^.DestBuffer);
  end;

  Result := True;
end;

procedure glBitmap_libJPEG_term_destination(cinfo: j_compress_ptr); cdecl;
var
  Idx: Integer;
  Dest: glBitmap_libJPEG_dest_mgr_ptr;
begin
  Dest := glBitmap_libJPEG_dest_mgr_ptr(cinfo^.Dest);

  for Idx := Low(Dest^.DestBuffer) to High(Dest^.DestBuffer) do
  begin
    // check for endblock
    if (Idx < High(Dest^.DestBuffer)) and (Dest^.DestBuffer[Idx] = $FF) and (Dest^.DestBuffer[Idx + 1] = JPEG_EOI) then
    begin
      // write endblock
      Dest^.DesPStream.Write(Dest^.DestBuffer[Idx], 2);

      // leave
      Break;
    end
    else
      Dest^.DesPStream.Write(Dest^.DestBuffer[Idx], 1);
  end;
end;
{$ENDIF}
{$IFDEF GLB_SUPPORT_JPEG_READ}

function TglBitmap.LoadJPEG(Stream: PStream): Boolean;
{$IFDEF GLB_SDL_IMAGE}
var
  Surface: PSDL_Surface;
  RWops: PSDL_RWops;
begin
  Result := false;

  RWops := glBitmapCreateRWops(Stream);
  try
    if IMG_isJPG(RWops) > 0 then
    begin
      Surface := IMG_LoadJPG_RW(RWops);
      try
        AssignFromSurface(Surface);
        Result := True;
      finally
        SDL_FreeSurface(Surface);
      end;
    end;
  finally
    SDL_FreeRW(RWops);
  end;
end;
{$ENDIF}
{$IFDEF GLB_LIB_JPEG}

var
  StreamPos: Int64;
  Temp: array [0 .. 1] of Byte;

  JPEG: jpeg_decompress_struct;
  jpeg_err: jpeg_error_mgr;

  IntFormat: TglBitmapInternalFormat;
  pImage: pByte;
  TempHeight, TempWidth: Integer;

  pTemp: pByte;
  Row: Integer;
begin
  Result := false;

  if not init_libJPEG then
    raise Exception.Create('LoadJPG - unable to initialize libJPEG.');

  try
    // reading first two bytes to test file and set cursor back to begin
    StreamPos := Stream.Position;
    Stream.Read(Temp[0], 2);
    Stream.Position := StreamPos;

    // if Bitmap then read file.
    if ((Temp[0] = $FF) and (Temp[1] = $D8)) then
    begin
      FillChar(JPEG, SizeOf(jpeg_decompress_struct), $00);
      FillChar(jpeg_err, SizeOf(jpeg_error_mgr), $00);

      // error managment
      JPEG.err := jpeg_std_error(@jpeg_err);
      jpeg_err.error_exit := glBitmap_libJPEG_error_exit;
      jpeg_err.output_message := glBitmap_libJPEG_output_message;

      // decompression struct
      jpeg_create_decompress(@JPEG);

      // allocation space for streaming methods
      JPEG.src := JPEG.mem^.alloc_small(@JPEG, JPOOL_PERMANENT, SizeOf(glBitmap_libJPEG_source_mgr));

      // seeting up custom functions
      with glBitmap_libJPEG_source_mgr_ptr(JPEG.src)^ do
      begin
        pub.init_source := glBitmap_libJPEG_init_source;
        pub.fill_input_buffer := glBitmap_libJPEG_fill_input_buffer;
        pub.skip_input_data := glBitmap_libJPEG_skip_input_data;
        pub.resync_to_restart := jpeg_resync_to_restart; // use default method
        pub.term_source := glBitmap_libJPEG_term_source;

        pub.bytes_in_buffer := 0; // forces fill_input_buffer on first read
        pub.next_input_byte := nil; // until buffer loaded

        SrcStream := Stream;
      end;

      // set global decoding state
      JPEG.global_state := DSTATE_START;

      // read header of jpeg
      jpeg_read_header(@JPEG, false);

      // setting output parameter
      case JPEG.jpeg_color_space of
        JCS_GRAYSCALE:
          begin
            JPEG.out_color_space := JCS_GRAYSCALE;
            IntFormat := ifLuminance;
          end;
      else
        JPEG.out_color_space := JCS_RGB;
        IntFormat := ifRGB8;
      end;

      // reading image
      jpeg_start_decompress(@JPEG);

      TempHeight := JPEG.output_height;
      TempWidth := JPEG.output_width;

      // creating new image
      GetMem(pImage, FormatGetImageSize(glBitmapPosition(TempWidth, TempHeight), IntFormat));
      try
        pTemp := pImage;

        for Row := 0 to TempHeight - 1 do
        begin
          jpeg_read_scanlines(@JPEG, @pTemp, 1);
          Inc(pTemp, Trunc(FormatGetSize(IntFormat) * TempWidth));
        end;

        // finish decompression
        jpeg_finish_decompress(@JPEG);

        // destroy decompression
        jpeg_destroy_decompress(@JPEG);

        SetDataPointer(pImage, IntFormat, TempWidth, TempHeight);

        Result := True;
      except
        FreeMem(pImage);
        raise;
      end;
    end;
  finally
    quit_libJPEG;
  end;
end;
{$ENDIF}
{$IFDEF GLB_DELPHI_JPEG}

var
  bmp: TBitmap;
  jpg: TJPEGImage;
  StreamPos: Int64;
  Temp: array [0 .. 1] of Byte;
begin
  Result := false;

  // reading first two bytes to test file and set cursor back to begin
  StreamPos := Stream.Position;
  Stream.Read(Temp[0], 2);
  Stream.Position := StreamPos;

  // if Bitmap then read file.
  if ((Temp[0] = $FF) and (Temp[1] = $D8)) then
  begin
    bmp := TBitmap.Create;
    try
      jpg := TJPEGImage.Create;
      try
        jpg.LoadFromStream(Stream);
        bmp.Assign(jpg);
        Result := AssignFromBitmap(bmp);
      finally
        jpg.Free;
      end;
    finally
      bmp.Free;
    end;
  end;
end;
{$ENDIF}
{$ENDIF}

const
  BMP_MAGIC = $4D42;

  BMP_COMP_RGB = 0;
  BMP_COMP_RLE8 = 1;
  BMP_COMP_RLE4 = 2;
  BMP_COMP_BITFIELDS = 3;

type
  TBMPHeader = packed record
    bfType: Word;
    bfSize: Cardinal;
    bfReserved1: Word;
    bfReserved2: Word;
    bfOffBits: Cardinal;
  end;

  TBMPInfo = packed record
    biSize: Cardinal;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
    biCompression: Cardinal;
    biSizeImage: Cardinal;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed: Cardinal;
    biClrImportant: Cardinal;
  end;

  TBMPInfoOS = packed record
    biSize: Cardinal;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
  end;

  // TBMPPalette = record
  // case Boolean of
  // True : (Colors: array[Byte] of TRGBQUAD);
  // False: (redMask, greenMask, blueMask: Cardinal);
  // end;

function TglBitmap.LoadBMP(Stream: PStream): Boolean;
var
  StreamPos: Int64;
  Header: TBMPHeader;
  Info: TBMPInfo;
  NewImage, pData: pByte;

  Format: TglBitmapInternalFormat;
  LineSize, Padding, LineIdx: Integer;
  RedMask, GreenMask, BlueMask, AlphaMask: Cardinal;

  PaddingBuff: Cardinal;

  function GetLineWidth: Integer;
  begin
    Result := ((Info.biWidth * Info.biBitCount + 31) and -32) shr 3;
  end;

begin
  Result := false;

  RedMask := 0;
  GreenMask := 0;
  BlueMask := 0;
  Format := ifEmpty;

  // Header
  StreamPos := Stream.Position;
  Stream.Read(Header, SizeOf(Header));

  if Header.bfType = BMP_MAGIC then
  begin
    Stream.Read(Info, SizeOf(Info));

    // Check for Compression
    if Info.biCompression <> BMP_COMP_RGB then
    begin
      if Info.biCompression = BMP_COMP_BITFIELDS then
      begin
        // Read Bitmasks for 16 or 32 Bit (24 Bit dosn't support Bitmasks!)
        if (Info.biBitCount = 16) or (Info.biBitCount = 32) then
        begin
          Stream.Read(RedMask, SizeOf(Cardinal));
          Stream.Read(GreenMask, SizeOf(Cardinal));
          Stream.Read(BlueMask, SizeOf(Cardinal));
          Stream.Read(AlphaMask, SizeOf(Cardinal));
        end;
      end
      else
      begin
        // RLE compression is unsupported
        Stream.Position := StreamPos;

        Exit;
      end;
    end;

    // Skip palette
    if Info.biBitCount < 16 then
      Stream.Position := Stream.Position + Info.biClrUsed * 4;

    // Jump to the data
    Stream.Position := StreamPos + Header.bfOffBits;

    // Select Format
    case Info.biBitCount of
      8:
        Format := ifLuminance;
      16:
        begin
          if (RedMask = 0) and (GreenMask = 0) and (BlueMask = 0) then
          begin
            Format := ifRGB5A1;
          end
          else
          begin
            if FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask, ifLuminanceAlpha) then
              Format := ifLuminanceAlpha;

            if FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask, ifRGBA4) then
              Format := ifRGBA4;

            if FormatCheckFormat(RedMask, GreenMask, BlueMask, 0, ifRGB5A1) then
              Format := ifRGB5A1;

            if FormatCheckFormat(RedMask, GreenMask, BlueMask, 0, ifR5G6B5) then
              Format := ifR5G6B5;
          end;
        end;
      24:
        Format := ifBGR8;
      32:
        begin
          if (RedMask = 0) and (GreenMask = 0) and (BlueMask = 0) then
          begin
            Format := ifBGRA8;
          end
          else
          begin
            if FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask, ifRGBA8) then
              Format := ifRGBA8;

            if FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask, ifBGRA8) then
              Format := ifBGRA8;

            if FormatCheckFormat(RedMask, GreenMask, BlueMask, AlphaMask, ifRGB10A2) then
              Format := ifRGB10A2;
          end;
        end;
    end;

    if Format <> ifEmpty then
    begin
      LineSize := Trunc(Info.biWidth * FormatGetSize(Format));
      Padding := GetLineWidth - LineSize;

      // copying data
      GetMem(NewImage, Info.biHeight * LineSize);
      try
        FillChar(NewImage^, Info.biHeight * LineSize, $FF);

        // Set pData to last Line
        pData := NewImage;
        Inc(pData, LineSize * (Info.biHeight - 1));

        // Copy Image Data
        for LineIdx := 0 to Info.biHeight - 1 do
        begin
          Stream.Read(pData^, LineSize);
          Dec(pData, LineSize);

          Stream.Read(PaddingBuff, Padding);
        end;

        // Set new Image
        SetDataPointer(NewImage, Format, Info.biWidth, Info.biHeight);

        Result := True;
      except
        FreeMem(NewImage);
        raise;
      end;
    end;
  end
  else
    Stream.Position := StreamPos;
end;

const
  DDS_MAGIC = $20534444;

  // DDS_header.dwFlags
  DDSD_CAPS = $00000001;
  DDSD_HEIGHT = $00000002;
  DDSD_WIDTH = $00000004;
  DDSD_PITCH = $00000008;
  DDSD_PIXELFORMAT = $00001000;
  DDSD_MIPMAPCOUNT = $00020000;
  DDSD_LINEARSIZE = $00080000;
  DDSD_DEPTH = $00800000;

  // DDS_header.sPixelFormat.dwFlags
  DDPF_ALPHAPIXELS = $00000001;
  DDPF_FOURCC = $00000004;
  DDPF_INDEXED = $00000020;
  DDPF_RGB = $00000040;

  // DDS_header.sCaps.dwCaps1
  DDSCAPS_COMPLEX = $00000008;
  DDSCAPS_TEXTURE = $00001000;
  DDSCAPS_MIPMAP = $00400000;

  // DDS_header.sCaps.dwCaps2
  DDSCAPS2_CUBEMAP = $00000200;
  DDSCAPS2_CUBEMAP_POSITIVEX = $00000400;
  DDSCAPS2_CUBEMAP_NEGATIVEX = $00000800;
  DDSCAPS2_CUBEMAP_POSITIVEY = $00001000;
  DDSCAPS2_CUBEMAP_NEGATIVEY = $00002000;
  DDSCAPS2_CUBEMAP_POSITIVEZ = $00004000;
  DDSCAPS2_CUBEMAP_NEGATIVEZ = $00008000;
  DDSCAPS2_VOLUME = $00200000;

  D3DFMT_DXT1 = $31545844;
  D3DFMT_DXT3 = $33545844;
  D3DFMT_DXT5 = $35545844;

type
  TDDSPixelFormat = packed record
    dwSize: Cardinal;
    dwFlags: Cardinal;
    dwFourCC: Cardinal;
    dwRGBBitCount: Cardinal;
    dwRBitMask: Cardinal;
    dwGBitMask: Cardinal;
    dwBBitMask: Cardinal;
    dwAlphaBitMask: Cardinal;
  end;

  TDDSCaps = packed record
    dwCaps1: Cardinal;
    dwCaps2: Cardinal;
    dwDDSX: Cardinal;
    dwReserved: Cardinal;
  end;

  TDDSHeader = packed record
    dwMagic: Cardinal;
    dwSize: Cardinal;
    dwFlags: Cardinal;
    dwHeight: Cardinal;
    dwWidth: Cardinal;
    dwPitchOrLinearSize: Cardinal;
    dwDepth: Cardinal;
    dwMipMapCount: Cardinal;
    dwReserved: array [0 .. 10] of Cardinal;
    PixelFormat: TDDSPixelFormat;
    Caps: TDDSCaps;
    dwReserved2: Cardinal;
  end;

function TglBitmap.LoadDDS(Stream: PStream): Boolean;
var
  Header: TDDSHeader;
  StreamPos: Int64;
  Y, LineSize: Cardinal;

  // MipMapCount, X, Y, XSize, YSize: Cardinal;
  RowSize: Cardinal;
  NewImage, pData: pByte;
  Format: TglBitmapInternalFormat;

  function RaiseEx: Exception;
  begin
    Result := EglBitmapException.Create('LoadDDS - unsupported Pixelformat found.');
  end;

  function GetInternalFormat: TglBitmapInternalFormat;
  begin
    with Header.PixelFormat do
    begin
      // Compresses
      if (dwFlags and DDPF_FOURCC) > 0 then
      begin
        case Header.PixelFormat.dwFourCC of
          D3DFMT_DXT1:
            Result := ifDXT1;
          D3DFMT_DXT3:
            Result := ifDXT3;
          D3DFMT_DXT5:
            Result := ifDXT5;
        else
          raise RaiseEx;
        end;
      end
      else

        // RGB
        if (dwFlags and (DDPF_RGB or DDPF_ALPHAPIXELS)) > 0 then
        begin
          case dwRGBBitCount of
            8:
              begin
                if dwFlags and DDPF_ALPHAPIXELS > 0 then
                  Result := ifAlpha
                else
                  Result := ifLuminance;
              end;
            16:
              begin
                if dwFlags and DDPF_ALPHAPIXELS > 0 then
                begin
                  // Alpha
                  case GetBitSize(dwRBitMask) of
                    5:
                      Result := ifRGB5A1;
                    4:
                      Result := ifRGBA4;
                  else
                    Result := ifLuminanceAlpha;
                  end;
                end
                else
                begin
                  // no Alpha
                  Result := ifR5G6B5;
                end;
              end;
            24:
              begin
                if dwRBitMask > dwBBitMask then
                  Result := ifBGR8
                else
                  Result := ifRGB8;
              end;
            32:
              begin
                if GetBitSize(dwRBitMask) = 10 then
                  Result := ifRGB10A2
                else

                  if dwRBitMask > dwBBitMask then
                  Result := ifBGRA8
                else
                  Result := ifRGBA8;
              end;
          else
            raise RaiseEx;
          end;
        end
        else
          raise RaiseEx;
    end;
  end;

begin
  Result := false;

  // Header
  StreamPos := Stream.Position;
  Stream.Read(Header, SizeOf(Header));

  if ((Header.dwMagic <> DDS_MAGIC) or (Header.dwSize <> 124) or ((Header.dwFlags and DDSD_PIXELFORMAT) = 0) or ((Header.dwFlags and DDSD_CAPS) = 0)) then
  begin
    Stream.Position := StreamPos;
    Exit;
  end;

  // Pixelformat
  // if Header.dwFlags and DDSD_MIPMAPCOUNT <> 0
  // then MipMapCount := Header.dwMipMapCount
  // else MipMapCount := 1;

  Format := GetInternalFormat;
  LineSize := Trunc(Header.dwWidth * FormatGetSize(Format));

  GetMem(NewImage, Header.dwHeight * LineSize);
  try
    pData := NewImage;

    // Compressed
    if (Header.PixelFormat.dwFlags and DDPF_FOURCC) > 0 then
    begin
      RowSize := Header.dwPitchOrLinearSize div Header.dwWidth;

      for Y := 0 to Header.dwHeight - 1 do
      begin
        Stream.Read(pData^, RowSize);
        Inc(pData, LineSize);
      end;
    end
    else

      // RGB(A)
      if (Header.PixelFormat.dwFlags and (DDPF_RGB or DDPF_ALPHAPIXELS)) > 0 then
      begin
        RowSize := Header.dwPitchOrLinearSize;

        for Y := 0 to Header.dwHeight - 1 do
        begin
          Stream.Read(pData^, RowSize);
          Inc(pData, LineSize);
        end;
      end
      else
        raise RaiseEx;

    SetDataPointer(NewImage, Format, Header.dwWidth, Header.dwHeight);

    Result := True;
  except
    FreeMem(NewImage);
    raise;
  end;
end;

type
  TTGAHeader = packed record
    ImageID: Byte;
    ColorMapType: Byte;
    ImageType: Byte;
    ColorMapSpec: Array [0 .. 4] of Byte;
    OrigX: Word;
    OrigY: Word;
    width: Word;
    height: Word;
    Bpp: Byte;
    ImageDes: Byte;
  end;

const
  TGA_UNCOMPRESSED_RGB = 2;
  TGA_UNCOMPRESSED_GRAY = 3;
  TGA_COMPRESSED_RGB = 10;
  TGA_COMPRESSED_GRAY = 11;

function TglBitmap.LoadTGA(Stream: PStream): Boolean;
var
  Header: TTGAHeader;
  NewImage, pData: pByte;
  StreamPos: Int64;
  PixelSize, LineSize, YStart, YEnd, YInc: Integer;
  Format: TglBitmapInternalFormat;

const
  CACHE_SIZE = $4000;

  procedure ReadUncompressed;
  var
    RowSize: Integer;
  begin
    RowSize := Header.width * PixelSize;

    // copy line by line
    while YStart <> YEnd + YInc do
    begin
      pData := NewImage;
      Inc(pData, YStart * LineSize);

      Stream.Read(pData^, RowSize);
      Inc(YStart, YInc);
    end;
  end;

  procedure ReadCompressed;
  var
    HeaderWidth, HeaderHeight: Integer;
    LinePixelsRead, ImgPixelsRead, ImgPixelsToRead: Integer;

    Cache: pByte;
    CacheSize, CachePos: Integer;

    Temp: Byte;
    TempBuf: Array [0 .. 15] of Byte;

    PixelRepeat: Boolean;
    PixelToRead, TempPixels: Integer;

    procedure CheckLine;
    begin
      if LinePixelsRead >= HeaderWidth then
      begin
        LinePixelsRead := 0;
        pData := NewImage;
        Inc(YStart, YInc);
        Inc(pData, YStart * LineSize);
      end;
    end;

    procedure CachedRead(var Buffer; Count: Integer);
    var
      BytesRead: Integer;
    begin
      if (CachePos + Count) > CacheSize then
      begin
        BytesRead := 0;

        // Read Data
        if CacheSize - CachePos > 0 then
        begin
          BytesRead := CacheSize - CachePos;

          Move(pByteArray(Cache)^[CachePos], Buffer, BytesRead);
          Inc(CachePos, BytesRead);
        end;

        // Reload Data
        CacheSize := Min(CACHE_SIZE, Stream.Size - Stream.Position);
        Stream.Read(Cache^, CacheSize);
        CachePos := 0;

        // Read else
        if Count - BytesRead > 0 then
        begin
          Move(pByteArray(Cache)^[CachePos], TByteArray(Buffer)[BytesRead], Count - BytesRead);
          Inc(CachePos, Count - BytesRead);
        end;
      end
      else
      begin
        Move(pByteArray(Cache)^[CachePos], Buffer, Count);
        Inc(CachePos, Count);
      end;
    end;

  begin
    CacheSize := 0;
    CachePos := 0;

    HeaderWidth := Header.width;
    HeaderHeight := Header.height;

    GetMem(Cache, CACHE_SIZE); // 16K Buffer
    try
      ImgPixelsToRead := HeaderWidth * HeaderHeight;
      ImgPixelsRead := 0;
      LinePixelsRead := 0;

      pData := NewImage;
      Inc(pData, YStart * LineSize);

      // Read until all Pixels
      repeat
        CachedRead(Temp, 1);

        PixelRepeat := Temp and $80 > 0;
        PixelToRead := (Temp and $7F) + 1;

        Inc(ImgPixelsRead, PixelToRead);

        if PixelRepeat then
        begin
          // repeat one pixel x times
          CachedRead(TempBuf[0], PixelSize);

          // repeat Pixel
          while PixelToRead > 0 do
          begin
            CheckLine;

            TempPixels := HeaderWidth - LinePixelsRead;
            if PixelToRead < TempPixels then
              TempPixels := PixelToRead;

            Inc(LinePixelsRead, TempPixels);
            Dec(PixelToRead, TempPixels);

            while TempPixels > 0 do
            begin
              case PixelSize of
                1:
                  begin
                    pData^ := TempBuf[0];
                    Inc(pData);
                  end;
                2:
                  begin
                    pWord(pData)^ := pWord(@TempBuf[0])^;
                    Inc(pData, 2);
                  end;
                3:
                  begin
                    pWord(pData)^ := pWord(@TempBuf[0])^;
                    Inc(pData, 2);
                    pData^ := TempBuf[2];
                    Inc(pData);
                  end;
                4:
                  begin
                    PDWORD(pData)^ := PDWORD(@TempBuf[0])^;
                    Inc(pData, 4);
                  end;
              end;

              Dec(TempPixels);
            end;
          end;
        end
        else
        begin
          // copy x pixels
          while PixelToRead > 0 do
          begin
            CheckLine;

            TempPixels := HeaderWidth - LinePixelsRead;
            if PixelToRead < TempPixels then
              TempPixels := PixelToRead;

            CachedRead(pData^, PixelSize * TempPixels);
            Inc(pData, PixelSize * TempPixels);

            Inc(LinePixelsRead, TempPixels);

            Dec(PixelToRead, TempPixels);
          end;
        end;
      until ImgPixelsRead >= ImgPixelsToRead;
    finally
      FreeMem(Cache)
    end;
  end;

begin
  Result := false;

  // reading header to test file and set cursor back to begin
  StreamPos := Stream.Position;
  Stream.Read(Header, SizeOf(Header));

  // no colormapped files
  if (Header.ColorMapType = 0) then
  begin
    if Header.ImageType in [TGA_UNCOMPRESSED_RGB, TGA_UNCOMPRESSED_GRAY, TGA_COMPRESSED_RGB, TGA_COMPRESSED_GRAY] then
    begin
      case Header.Bpp of
        8:
          Format := ifAlpha;
        16:
          Format := ifLuminanceAlpha;
        24:
          Format := ifBGR8;
        32:
          Format := ifBGRA8;
      else
        raise EglBitmapException.Create('LoadTga - unsupported BitsPerPixel found.');
      end;

      // skip image ID
      if Header.ImageID <> 0 then
        Stream.Position := Stream.Position + Header.ImageID;

      PixelSize := Trunc(FormatGetSize(Format));
      LineSize := Trunc(Header.width * PixelSize);

      GetMem(NewImage, LineSize * Header.height);
      try
        // Row direction
        if (Header.ImageDes and $20 > 0) then
        begin
          YStart := 0;
          YEnd := Header.height - 1;
          YInc := 1;
        end
        else
        begin
          YStart := Header.height - 1;
          YEnd := 0;
          YInc := -1;
        end;

        // Read Image
        case Header.ImageType of
          TGA_UNCOMPRESSED_RGB, TGA_UNCOMPRESSED_GRAY:
            ReadUncompressed;
          TGA_COMPRESSED_RGB, TGA_COMPRESSED_GRAY:
            ReadCompressed;
        end;

        SetDataPointer(NewImage, Format, Header.width, Header.height);

        Result := True;
      except
        FreeMem(NewImage);
        raise;
      end;
    end
    else
      Stream.Position := StreamPos;
  end
  else
    Stream.Position := StreamPos;
end;

{$IFDEF GLB_SUPPORT_PNG_WRITE}
{$IFDEF GLB_LIB_PNG}

procedure glBitmap_libPNG_write_func(png: png_structp; Buffer: png_bytep; Size: Cardinal); cdecl;
begin
  PStream(png_get_io_ptr(png)).Write(Buffer^, Size);
end;
{$ENDIF}

procedure TglBitmap.SavePNG(Stream: PStream);
{$IFDEF GLB_LIB_PNG}
var
  png: png_structp;
  png_info: png_infop;
  png_rows: array of pByte;
  LineSize: Integer;
  ColorType: Integer;
  Row: Integer;
begin
  if not(ftPNG in FormatGetSupportedFiles(internalformat)) then
    raise EglBitmapUnsupportedInternalFormat.Create('SavePng - ' + UNSUPPORTED_INTERNAL_FORMAT);

  if not init_libPNG then
    raise Exception.Create('SavePNG - unable to initialize libPNG.');

  try
    case fInternalFormat of
      ifAlpha, ifLuminance, ifDepth8:
        ColorType := PNG_COLOR_TYPE_GRAY;
      ifLuminanceAlpha:
        ColorType := PNG_COLOR_TYPE_GRAY_ALPHA;
      ifBGR8, ifRGB8:
        ColorType := PNG_COLOR_TYPE_RGB;
      ifBGRA8, ifRGBA8:
        ColorType := PNG_COLOR_TYPE_RGBA;
    else
      raise EglBitmapUnsupportedInternalFormat.Create('SavePng - ' + UNSUPPORTED_INTERNAL_FORMAT);
    end;

    LineSize := Trunc(FormatGetSize(fInternalFormat) * width);

    // creating array for scanline
    SetLength(png_rows, height);
    try
      for Row := 0 to height - 1 do
      begin
        png_rows[Row] := Data;
        Inc(png_rows[Row], Row * LineSize)
      end;

      // write struct
      png := png_create_write_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil);
      if png = nil then
        raise EglBitmapException.Create('SavePng - couldn''t create write struct.');

      // create png info
      png_info := png_create_info_struct(png);
      if png_info = nil then
      begin
        png_destroy_write_struct(@png, nil);
        raise EglBitmapException.Create('SavePng - couldn''t create info struct.');
      end;

      // set read callback
      png_set_write_fn(png, Stream, glBitmap_libPNG_write_func, nil);

      // set compression
      png_set_compression_level(png, 6);

      if internalformat in [ifBGR8, ifBGRA8] then
        png_set_bgr(png);

      // setup header
      png_set_IHDR(png, png_info, width, height, 8, ColorType, PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);

      // write info
      png_write_info(png, png_info);

      // write image data
      png_write_image(png, @png_rows[0]);

      // write end
      png_write_end(png, png_info);

      // destroy write struct
      png_destroy_write_struct(@png, @png_info);
    finally
      SetLength(png_rows, 0);
    end;
  finally
    quit_libPNG;
  end;
end;
{$ENDIF}
{$IFDEF GLB_PNGIMAGE}

var
  png: TPNGObject;

  pSource, pDest: pByte;
  X, Y, PixSize: Integer;
  ColorType: Cardinal;
  Alpha: Boolean;

  pTemp: pByte;
  Temp: Byte;
begin
  if not(ftPNG in FormatGetSupportedFiles(internalformat)) then
    raise EglBitmapUnsupportedInternalFormat.Create('SavePng - ' + UNSUPPORTED_INTERNAL_FORMAT);

  case fInternalFormat of
    ifAlpha, ifLuminance, ifDepth8:
      begin
        ColorType := COLOR_GRAYSCALE;
        PixSize := 1;
        Alpha := false;
      end;
    ifLuminanceAlpha:
      begin
        ColorType := COLOR_GRAYSCALEALPHA;
        PixSize := 1;
        Alpha := True;
      end;
    ifBGR8, ifRGB8:
      begin
        ColorType := COLOR_RGB;
        PixSize := 3;
        Alpha := false;
      end;
    ifBGRA8, ifRGBA8:
      begin
        ColorType := COLOR_RGBALPHA;
        PixSize := 3;
        Alpha := True
      end;
  else
    raise EglBitmapUnsupportedInternalFormat.Create('SavePng - ' + UNSUPPORTED_INTERNAL_FORMAT);
  end;

  png := TPNGObject.CreateBlank(ColorType, 8, width, height);
  try
    // Copy ImageData
    pSource := Data;
    for Y := 0 to height - 1 do
    begin
      pDest := png.Scanline[Y];

      for X := 0 to width - 1 do
      begin
        Move(pSource^, pDest^, PixSize);

        Inc(pDest, PixSize);
        Inc(pSource, PixSize);

        if Alpha then
        begin
          png.AlphaScanline[Y]^[X] := pSource^;
          Inc(pSource);
        end;
      end;

      // convert RGB line to BGR
      if internalformat in [ifRGB8, ifRGBA8] then
      begin
        pTemp := png.Scanline[Y];

        for X := 0 to width - 1 do
        begin
          Temp := pByteArray(pTemp)^[0];
          pByteArray(pTemp)^[0] := pByteArray(pTemp)^[2];
          pByteArray(pTemp)^[2] := Temp;

          Inc(pTemp, 3);
        end;
      end;
    end;

    // Save to Stream
    png.CompressionLevel := 6;
    png.SaveToStream(Stream);
  finally
    FreeAndNil(png);
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TglBitmap.SaveDDS(Stream: PStream);
var
  Header: TDDSHeader;
  Pix: TglBitmapPixelData;
begin
  if not FormatIsUncompressed(internalformat) then
    raise EglBitmapUnsupportedInternalFormat.Create('SaveDDS - ' + UNSUPPORTED_INTERNAL_FORMAT);

  if internalformat = ifAlpha then
    FormatPreparePixel(Pix, ifLuminance)
  else
    FormatPreparePixel(Pix, internalformat);

  // Generell
  FillChar(Header, SizeOf(Header), 0);

  Header.dwMagic := DDS_MAGIC;
  Header.dwSize := 124;
  Header.dwFlags := DDSD_PITCH or DDSD_CAPS or DDSD_PIXELFORMAT;

  if width > 0 then
  begin
    Header.dwWidth := width;
    Header.dwFlags := Header.dwFlags or DDSD_WIDTH;
  end;

  if height > 0 then
  begin
    Header.dwHeight := height;
    Header.dwFlags := Header.dwFlags or DDSD_HEIGHT;
  end;

  Header.dwPitchOrLinearSize := fRowSize;
  Header.dwMipMapCount := 1;

  // Caps
  Header.Caps.dwCaps1 := DDSCAPS_TEXTURE;

  // Pixelformat
  Header.PixelFormat.dwSize := SizeOf(Header.PixelFormat);
  Header.PixelFormat.dwFlags := DDPF_RGB;

  if FormatHasAlpha(internalformat) and (internalformat <> ifAlpha) then
    Header.PixelFormat.dwFlags := Header.PixelFormat.dwFlags or DDPF_ALPHAPIXELS;

  Header.PixelFormat.dwRGBBitCount := Trunc(FormatGetSize(internalformat) * 8);
  Header.PixelFormat.dwRBitMask := Pix.PixelDesc.RedRange shl Pix.PixelDesc.RedShift;
  Header.PixelFormat.dwGBitMask := Pix.PixelDesc.GreenRange shl Pix.PixelDesc.GreenShift;
  Header.PixelFormat.dwBBitMask := Pix.PixelDesc.BlueRange shl Pix.PixelDesc.BlueShift;
  Header.PixelFormat.dwAlphaBitMask := Pix.PixelDesc.AlphaRange shl Pix.PixelDesc.AlphaShift;

  // Write
  Stream.Write(Header, SizeOf(Header));

  Stream.Write(Data^, FormatGetImageSize(glBitmapPosition(width, height), internalformat));
end;

procedure TglBitmap.SaveTGA(Stream: PStream);
var
  Header: TTGAHeader;
  Size: Integer;
  pTemp: pByte;

  procedure ConvertData(pTemp: pByte);
  var
    Idx, PixelSize: Integer;
    Temp: Byte;
  begin
    PixelSize := fPixelSize;

    for Idx := 0 to height * width do
    begin
      Temp := pByteArray(pTemp)^[2];
      pByteArray(pTemp)^[2] := pByteArray(pTemp)^[0];
      pByteArray(pTemp)^[0] := Temp;

      Inc(pTemp, PixelSize);
    end;
  end;

begin
  if not(ftTGA in FormatGetSupportedFiles(internalformat)) then
    raise EglBitmapUnsupportedInternalFormat.Create('SaveTGA - ' + UNSUPPORTED_INTERNAL_FORMAT);

  FillChar(Header, SizeOf(Header), 0);

  case internalformat of
    ifAlpha, ifLuminance, ifDepth8:
      begin
        Header.ImageType := TGA_UNCOMPRESSED_GRAY;
        Header.Bpp := 8;
      end;
    ifLuminanceAlpha:
      begin
        Header.ImageType := TGA_UNCOMPRESSED_GRAY;
        Header.Bpp := 16;
      end;
    ifRGB8, ifBGR8:
      begin
        Header.ImageType := TGA_UNCOMPRESSED_RGB;
        Header.Bpp := 24;
      end;
    ifRGBA8, ifBGRA8:
      begin
        Header.ImageType := TGA_UNCOMPRESSED_RGB;
        Header.Bpp := 32;
      end;
  else
    raise EglBitmapUnsupportedInternalFormat.Create('SaveTGA - ' + UNSUPPORTED_INTERNAL_FORMAT);
  end;

  Header.width := width;
  Header.height := height;
  Header.ImageDes := $20;

  if FormatHasAlpha(internalformat) then
    Header.ImageDes := Header.ImageDes or $08;

  Stream.Write(Header, SizeOf(Header));

  // convert RGB(A) to BGR(A)
  Size := FormatGetImageSize(glBitmapPosition(width, height), internalformat);
  if internalformat in [ifRGB8, ifRGBA8] then
  begin
    GetMem(pTemp, Size);
  end
  else
    pTemp := Data;

  try
    // convert data
    if internalformat in [ifRGB8, ifRGBA8] then
    begin
      Move(Data^, pTemp^, Size);
      ConvertData(pTemp);
    end;

    // write data
    Stream.Write(pTemp^, Size);
  finally
    // free tempdata
    if internalformat in [ifRGB8, ifRGBA8] then
      FreeMem(pTemp);
  end;
end;

{$IFDEF GLB_SUPPORT_JPEG_WRITE}

procedure TglBitmap.SaveJPEG(Stream: PStream);
{$IFDEF GLB_LIB_JPEG}
var
  JPEG: jpeg_compress_struct;
  jpeg_err: jpeg_error_mgr;
  Row: Integer;
  pTemp, pTemp2: pByte;

  procedure CopyRow(pDest, pSource: pByte);
  var
    X: Integer;
  begin
    for X := 0 to width - 1 do
    begin
      pByteArray(pDest)^[0] := pByteArray(pSource)^[2];
      pByteArray(pDest)^[1] := pByteArray(pSource)^[1];
      pByteArray(pDest)^[2] := pByteArray(pSource)^[0];

      Inc(pDest, 3);
      Inc(pSource, 3);
    end;
  end;

begin
  if not(ftJPEG in FormatGetSupportedFiles(internalformat)) then
    raise EglBitmapUnsupportedInternalFormat.Create('SaveJpg - ' + UNSUPPORTED_INTERNAL_FORMAT);

  if not init_libJPEG then
    raise Exception.Create('SaveJPG - unable to initialize libJPEG.');

  try
    FillChar(JPEG, SizeOf(jpeg_compress_struct), $00);
    FillChar(jpeg_err, SizeOf(jpeg_error_mgr), $00);

    // error managment
    JPEG.err := jpeg_std_error(@jpeg_err);
    jpeg_err.error_exit := glBitmap_libJPEG_error_exit;
    jpeg_err.output_message := glBitmap_libJPEG_output_message;

    // compression struct
    jpeg_create_compress(@JPEG);

    // allocation space for streaming methods
    JPEG.Dest := JPEG.mem^.alloc_small(@JPEG, JPOOL_PERMANENT, SizeOf(glBitmap_libJPEG_dest_mgr));

    // seeting up custom functions
    with glBitmap_libJPEG_dest_mgr_ptr(JPEG.Dest)^ do
    begin
      pub.init_destination := glBitmap_libJPEG_init_destination;
      pub.empty_output_buffer := glBitmap_libJPEG_empty_output_buffer;
      pub.term_destination := glBitmap_libJPEG_term_destination;

      pub.next_output_byte := @DestBuffer[1];
      pub.free_in_buffer := Length(DestBuffer);

      DesPStream := Stream;
    end;

    // very important state
    JPEG.global_state := CSTATE_START;

    JPEG.image_width := width;
    JPEG.image_height := height;
    case internalformat of
      ifAlpha, ifLuminance, ifDepth8:
        begin
          JPEG.input_components := 1;
          JPEG.in_color_space := JCS_GRAYSCALE;
        end;
      ifRGB8, ifBGR8:
        begin
          JPEG.input_components := 3;
          JPEG.in_color_space := JCS_RGB;
        end;
    end;

    // setting defaults
    jpeg_set_defaults(@JPEG);

    // compression quality
    jpeg_set_quality(@JPEG, 95, True);

    // start compression
    jpeg_start_compress(@JPEG, True);

    // write rows
    pTemp := Data;

    // initialing row
    if internalformat = ifBGR8 then
      GetMem(pTemp2, fRowSize)
    else
      pTemp2 := pTemp;

    try
      for Row := 0 to JPEG.image_height - 1 do
      begin
        // prepare row
        if internalformat = ifBGR8 then
          CopyRow(pTemp2, pTemp)
        else
          pTemp2 := pTemp;

        // write row
        jpeg_write_scanlines(@JPEG, @pTemp2, 1);
        Inc(pTemp, fRowSize);
      end;
    finally
      // free memory
      if internalformat = ifBGR8 then
        FreeMem(pTemp2);
    end;

    // finish compression
    jpeg_finish_compress(@JPEG);

    // destroy compression
    jpeg_destroy_compress(@JPEG);
  finally
    quit_libJPEG;
  end;
end;
{$ENDIF}
{$IFDEF GLB_DELPHI_JPEG}

var
  bmp: TBitmap;
  jpg: TJPEGImage;
begin
  if not(ftJPEG in FormatGetSupportedFiles(internalformat)) then
    raise EglBitmapUnsupportedInternalFormat.Create('SaveJpg - ' + UNSUPPORTED_INTERNAL_FORMAT);

  bmp := TBitmap.Create;
  try
    jpg := TJPEGImage.Create;
    try
      AssignToBitmap(bmp);

      if fInternalFormat in [ifAlpha, ifLuminance, ifDepth8] then
      begin
        jpg.Grayscale := True;
        jpg.PixelFormat := jf8Bit;
      end;

      jpg.Assign(bmp);

      jpg.SaveToStream(Stream);
    finally
      FreeAndNil(jpg);
    end;
  finally
    FreeAndNil(bmp);
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TglBitmap.SaveBMP(Stream: PStream);
var
  Header: TBMPHeader;
  Info: TBMPInfo;
  pData, pTemp: pByte;

  PixelFormat: TglBitmapPixelData;
  imageSize, LineSize, Padding, LineIdx, ColorIdx: Integer;
  Temp, RedMask, GreenMask, BlueMask, AlphaMask: Cardinal;

  PaddingBuff: Cardinal;

  function GetLineWidth: Integer;
  begin
    Result := ((Info.biWidth * Info.biBitCount + 31) and -32) shr 3;
  end;

begin
  if not(ftBMP in FormatGetSupportedFiles(internalformat)) then
    raise EglBitmapUnsupportedInternalFormat.Create('SaveBMP - ' + UNSUPPORTED_INTERNAL_FORMAT);

  imageSize := Trunc(width * height * FormatGetSize(internalformat));

  Header.bfType := BMP_MAGIC;
  Header.bfSize := SizeOf(Header) + SizeOf(Info) + imageSize;
  Header.bfReserved1 := 0;
  Header.bfReserved2 := 0;
  Header.bfOffBits := SizeOf(Header) + SizeOf(Info);

  FillChar(Info, SizeOf(Info), 0);
  Info.biSize := SizeOf(Info);
  Info.biWidth := width;
  Info.biHeight := height;
  Info.biPlanes := 1;
  Info.biCompression := BMP_COMP_RGB;
  Info.biSizeImage := imageSize;
  case internalformat of
    ifAlpha, ifLuminance, ifDepth8:
      begin
        Info.biBitCount := 8;

        Header.bfSize := Header.bfSize + 256 * SizeOf(Cardinal);
        Header.bfOffBits := Header.bfOffBits + 256 * SizeOf(Cardinal);

        Info.biClrUsed := 256;
        Info.biClrImportant := 256;
      end;
    ifLuminanceAlpha, ifRGBA4, ifR5G6B5, ifRGB5A1:
      begin
        Info.biBitCount := 16;
        Info.biCompression := BMP_COMP_BITFIELDS;
      end;
    ifBGR8, ifRGB8:
      Info.biBitCount := 24;
    ifBGRA8, ifRGBA8, ifRGB10A2:
      begin
        Info.biBitCount := 32;
        Info.biCompression := BMP_COMP_BITFIELDS;
      end;
  else
    raise EglBitmapUnsupportedInternalFormat.Create('SaveBMP - ' + UNSUPPORTED_INTERNAL_FORMAT);
  end;
  Info.biXPelsPerMeter := 2835;
  Info.biYPelsPerMeter := 2835;

  // prepare bitmasks
  if Info.biCompression = BMP_COMP_BITFIELDS then
  begin
    Info.biSize := Info.biSize + 4 * SizeOf(Cardinal);
    Header.bfSize := Header.bfSize + 4 * SizeOf(Cardinal);
    Header.bfOffBits := Header.bfOffBits + 4 * SizeOf(Cardinal);

    FormatPreparePixel(PixelFormat, internalformat);

    with PixelFormat.PixelDesc do
    begin
      RedMask := RedRange shl RedShift;
      GreenMask := GreenRange shl GreenShift;
      BlueMask := BlueRange shl BlueShift;
      AlphaMask := AlphaRange shl AlphaShift;
    end;
  end;

  // headers
  Stream.Write(Header, SizeOf(Header));
  Stream.Write(Info, SizeOf(Info));

  // colortable
  if Info.biBitCount = 8 then
  begin
    Temp := 0;
    for ColorIdx := Low(Byte) to High(Byte) do
    begin
      Stream.Write(Temp, 4);
      Temp := Temp + $00010101;
    end;
  end;

  // bitmasks
  if Info.biCompression = BMP_COMP_BITFIELDS then
  begin
    Stream.Write(RedMask, SizeOf(Cardinal));
    Stream.Write(GreenMask, SizeOf(Cardinal));
    Stream.Write(BlueMask, SizeOf(Cardinal));
    Stream.Write(AlphaMask, SizeOf(Cardinal));
  end;

  // image data
  LineSize := Trunc(width * FormatGetSize(internalformat));
  Padding := GetLineWidth - LineSize;
  PaddingBuff := 0;

  pData := Data;
  Inc(pData, (height - 1) * LineSize);

  // prepare row buffer. But only for RGB because RGBA supports color masks
  // so it's possible to change color within the image.
  if internalformat = ifRGB8 then
    GetMem(pTemp, fRowSize)
  else
    pTemp := nil;

  try
    // write image data
    for LineIdx := 0 to height - 1 do
    begin
      // preparing row
      if internalformat = ifRGB8 then
      begin
        Move(pData^, pTemp^, fRowSize);
        SwapRGB(pTemp, width, false);
      end
      else
        pTemp := pData;

      Stream.Write(pTemp^, LineSize);

      Dec(pData, LineSize);

      if Padding > 0 then
        Stream.Write(PaddingBuff, Padding);
    end;
  finally
    // destroy row buffer
    if internalformat = ifRGB8 then
      FreeMem(pTemp);
  end;
end;

procedure TglBitmap.Bind(EnableTextureUnit: Boolean);
begin
  if EnableTextureUnit then
    glEnable(target);

  if ID > 0 then
    glBindTexture(target, ID);
end;

procedure TglBitmap.Unbind(DisableTextureUnit: Boolean);
begin
  if DisableTextureUnit then
    glDisable(target);

  glBindTexture(target, 0);
end;

procedure TglBitmap.GetPixel(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
begin
  if Assigned(fGetPixelFunc) then
    fGetPixelFunc(Pos, Pixel);
end;

procedure TglBitmap.SetPixel(const Pos: TglBitmapPixelPosition; const Pixel: TglBitmapPixelData);
begin
  if Assigned(fSetPixelFunc) then
    fSetPixelFunc(Pos, Pixel);
end;

procedure TglBitmap.CreateID;
begin
  // Generate Texture
  if ID <> 0 then
    glDeleteTextures(1, @ID);

  glGenTextures(1, @ID);

  Bind(false);
end;

procedure TglBitmap.SetupParameters(var BuildWithGlu: Boolean);
begin
  // Set up parameters
  SetWrap(fWrapS, fWrapT, fWrapR);
  SetFilter(fFilterMin, fFilterMag);
  SetAnisotropic(fAnisotropic);
  SetBorderColor(fBorderColor[0], fBorderColor[1], fBorderColor[2], fBorderColor[3]);

  // Mip Maps generation Mode
  BuildWithGlu := false;

  if (MipMap = mmMipmap) then
  begin
    if (GL_VERSION_1_4 or GL_SGIS_generate_mipmap) then
      glTexParameteri(target, GL_GENERATE_MIPMAP, GL_TRUE)
    else
      BuildWithGlu := True;
  end
  else if (MipMap = mmMipmapGlu) then
    BuildWithGlu := True;
end;

procedure TglBitmap.SelectFormat(DataFormat: TglBitmapInternalFormat; var glFormat, glInternalFormat, glType: Cardinal; CanConvertImage: Boolean = True);

  procedure Check12;
  begin
    if not GL_VERSION_1_2 then
      raise EglBitmapUnsupportedInternalFormat.Create('SelectFormat - You need at least OpenGL 1.2 to support these format.');
  end;

begin
  glType := GL_UNSIGNED_BYTE;

  // selecting Format
  case DataFormat of
    ifAlpha:
      glFormat := GL_ALPHA;
    ifLuminance:
      glFormat := GL_LUMINANCE;
    ifDepth8:
      glFormat := GL_DEPTH_COMPONENT;
    ifLuminanceAlpha:
      glFormat := GL_LUMINANCE_ALPHA;
    ifBGR8:
      begin
        if (GL_VERSION_1_2 or GL_EXT_bgra) then
        begin
          glFormat := GL_BGR;
        end
        else
        begin
          if CanConvertImage then
            ConvertTo(ifRGB8);
          glFormat := GL_RGB;
        end;
      end;
    ifBGRA8:
      begin
        if (GL_VERSION_1_2 or GL_EXT_bgra) then
        begin
          glFormat := GL_BGRA;
        end
        else
        begin
          if CanConvertImage then
            ConvertTo(ifRGBA8);
          glFormat := GL_RGBA;
        end;
      end;
    ifRGB8:
      glFormat := GL_RGB;
    ifRGBA8:
      glFormat := GL_RGBA;
    ifRGBA4:
      begin
        Check12;
        glFormat := GL_BGRA;
        glType := GL_UNSIGNED_SHORT_4_4_4_4_REV;
      end;
    ifRGB5A1:
      begin
        Check12;
        glFormat := GL_BGRA;
        glType := GL_UNSIGNED_SHORT_1_5_5_5_REV;
      end;
    ifRGB10A2:
      begin
        Check12;
        glFormat := GL_BGRA;
        glType := GL_UNSIGNED_INT_2_10_10_10_REV;
      end;
    ifR5G6B5:
      begin
        Check12;
        glFormat := GL_RGB;
        glType := GL_UNSIGNED_SHORT_5_6_5;
      end;
  else
    glFormat := 0;
  end;

  // Selecting InternalFormat
  case DataFormat of
    ifDXT1, ifDXT3, ifDXT5:
      begin
        if GL_EXT_texture_compression_s3tc then
        begin
          case DataFormat of
            ifDXT1:
              glInternalFormat := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT;
            ifDXT3:
              glInternalFormat := GL_COMPRESSED_RGBA_S3TC_DXT3_EXT;
            ifDXT5:
              glInternalFormat := GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;
          end;
        end
        else
        begin
          // Compression isn't supported so convert to RGBA
          if CanConvertImage then
            ConvertTo(ifRGBA8);
          glFormat := GL_RGBA;
          glInternalFormat := GL_RGBA8;
        end;
      end;
    ifAlpha:
      begin
        case Format of
          tf4BitsPerChanel:
            glInternalFormat := GL_ALPHA4;
          tf8BitsPerChanel:
            glInternalFormat := GL_ALPHA8;
          tfCompressed:
            begin
              if (GL_ARB_texture_compression or GL_VERSION_1_3) then
                glInternalFormat := GL_COMPRESSED_ALPHA
              else
                glInternalFormat := GL_ALPHA;
            end;
        else
          glInternalFormat := GL_ALPHA;
        end;
      end;
    ifLuminance:
      begin
        case Format of
          tf4BitsPerChanel:
            glInternalFormat := GL_LUMINANCE4;
          tf8BitsPerChanel:
            glInternalFormat := GL_LUMINANCE8;
          tfCompressed:
            begin
              if (GL_ARB_texture_compression or GL_VERSION_1_3) then
                glInternalFormat := GL_COMPRESSED_LUMINANCE
              else
                glInternalFormat := GL_LUMINANCE;
            end;
        else
          glInternalFormat := GL_LUMINANCE;
        end;
      end;
    ifDepth8:
      begin
        glInternalFormat := GL_DEPTH_COMPONENT;
      end;
    ifLuminanceAlpha:
      begin
        case Format of
          tf4BitsPerChanel:
            glInternalFormat := GL_LUMINANCE4_ALPHA4;
          tf8BitsPerChanel:
            glInternalFormat := GL_LUMINANCE8_ALPHA8;
          tfCompressed:
            begin
              if (GL_ARB_texture_compression or GL_VERSION_1_3) then
                glInternalFormat := GL_COMPRESSED_LUMINANCE_ALPHA
              else
                glInternalFormat := GL_LUMINANCE_ALPHA;
            end;
        else
          glInternalFormat := GL_LUMINANCE_ALPHA;
        end;
      end;
    ifBGR8, ifRGB8:
      begin
        case Format of
          tf4BitsPerChanel:
            glInternalFormat := GL_RGB4;
          tf8BitsPerChanel:
            glInternalFormat := GL_RGB8;
          tfCompressed:
            begin
              if (GL_ARB_texture_compression or GL_VERSION_1_3) then
              begin
                glInternalFormat := GL_COMPRESSED_RGB
              end
              else
              begin
                if (GL_EXT_texture_compression_s3tc) then
                  glInternalFormat := GL_COMPRESSED_RGB_S3TC_DXT1_EXT
                else
                  glInternalFormat := GL_RGB;
              end;
            end;
        else
          glInternalFormat := GL_RGB;
        end;
      end;
    ifBGRA8, ifRGBA8, ifRGBA4, ifRGB5A1, ifRGB10A2, ifR5G6B5:
      begin
        case Format of
          tf4BitsPerChanel:
            glInternalFormat := GL_RGBA4;
          tf8BitsPerChanel:
            glInternalFormat := GL_RGBA8;
          tfCompressed:
            begin
              if (GL_ARB_texture_compression or GL_VERSION_1_3) then
              begin
                glInternalFormat := GL_COMPRESSED_RGBA
              end
              else
              begin
                if (GL_EXT_texture_compression_s3tc) then
                  glInternalFormat := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT
                else
                  glInternalFormat := GL_RGBA;
              end;
            end;
        else
          glInternalFormat := GL_RGBA;
        end;
      end;
  end;
end;

function TglBitmap.FlipHorz: Boolean;
begin
  Result := false;
end;

function TglBitmap.FlipVert: Boolean;
begin
  Result := false;
end;

procedure TglBitmap.FreeData;
begin
  SetDataPointer(nil, ifEmpty);
end;

procedure glBitmapFillWithColorFunc(var FuncRec: TglBitmapFunctionRec);
type
  PglBitmapPixelData = ^TglBitmapPixelData;
begin
  with FuncRec do
  begin
    Dest.Red := PglBitmapPixelData(CustomData)^.Red;
    Dest.Green := PglBitmapPixelData(CustomData)^.Green;
    Dest.Blue := PglBitmapPixelData(CustomData)^.Blue;
    Dest.Alpha := PglBitmapPixelData(CustomData)^.Alpha;
  end;
end;

procedure TglBitmap.FillWithColor(Red, Green, Blue, Alpha: Byte);
begin
  FillWithColorFloat(Red / $FF, Green / $FF, Blue / $FF, Alpha / $FF);
end;

procedure TglBitmap.FillWithColorFloat(Red, Green, Blue, Alpha: single);
var
  PixelData: TglBitmapPixelData;
begin
  FormatPreparePixel(PixelData, internalformat);

  PixelData.Red := Max(0, Min(PixelData.PixelDesc.RedRange, Trunc(PixelData.PixelDesc.RedRange * Red)));
  PixelData.Green := Max(0, Min(PixelData.PixelDesc.GreenRange, Trunc(PixelData.PixelDesc.GreenRange * Green)));
  PixelData.Blue := Max(0, Min(PixelData.PixelDesc.BlueRange, Trunc(PixelData.PixelDesc.BlueRange * Blue)));
  PixelData.Alpha := Max(0, Min(PixelData.PixelDesc.AlphaRange, Trunc(PixelData.PixelDesc.AlphaRange * Alpha)));

  AddFunc(glBitmapFillWithColorFunc, false, @PixelData);
end;

procedure TglBitmap.FillWithColorRange(Red, Green, Blue, Alpha: Cardinal);
var
  PixelData: TglBitmapPixelData;
begin
  FormatPreparePixel(PixelData, FormatGetWithAlpha(internalformat));

  FillWithColorFloat(Red / PixelData.PixelDesc.RedRange, Green / PixelData.PixelDesc.GreenRange, Blue / PixelData.PixelDesc.BlueRange, Alpha / PixelData.PixelDesc.AlphaRange);
end;

procedure TglBitmap.SetAnisotropic(const Value: Integer);
var
  MaxAniso: Integer;
begin
  fAnisotropic := Value;

  if (ID > 0) then
  begin
    if GL_EXT_texture_filter_anisotropic then
    begin
      if fAnisotropic > 0 then
      begin
        Bind(false);

        glGetIntegerv(GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT, @MaxAniso);

        if Value > MaxAniso then
          fAnisotropic := MaxAniso;

        glTexParameteri(target, GL_TEXTURE_MAX_ANISOTROPY_EXT, fAnisotropic);
      end;
    end
    else
    begin
      fAnisotropic := 0;
    end;
  end;
end;

procedure TglBitmap.SetInternalFormat(const Value: TglBitmapInternalFormat);
begin
  if internalformat <> Value then
  begin
    if FormatGetSize(Value) <> FormatGetSize(internalformat) then
      raise EglBitmapUnsupportedInternalFormat.Create('SetInternalFormat - ' + UNSUPPORTED_INTERNAL_FORMAT);

    // Update whatever
    SetDataPointer(Data, Value);
  end;
end;

function TglBitmap.AddFunc(Func: TglBitmapFunction; CreateTemp: Boolean; CustomData: Pointer): Boolean;
begin
  Result := AddFunc(Self, Func, CreateTemp, internalformat, CustomData);
end;

function TglBitmap.AddFunc(Source: TglBitmap; Func: TglBitmapFunction; CreateTemp: Boolean; Format: TglBitmapInternalFormat; CustomData: Pointer): Boolean;
var
  pDest, NewImage, pSource: pByte;
  TempHeight, TempWidth: Integer;
  MapFunc: TglBitmapMapFunc;
  UnMapFunc: TglBitmapUnMapFunc;

  FuncRec: TglBitmapFunctionRec;
begin
  Assert(Assigned(Data));
  Assert(Assigned(Source));
  Assert(Assigned(Source.Data));

  Result := false;

  if Assigned(Source.Data) and FormatIsUncompressed(Format) and ((Source.height > 0) or (Source.width > 0)) then
  begin

    // inkompatible Formats so CreateTemp
    if FormatGetSize(Format) <> FormatGetSize(internalformat) then
      CreateTemp := True;

    // Values
    TempHeight := Max(1, Source.height);
    TempWidth := Max(1, Source.width);

    FuncRec.Sender := Self;
    FuncRec.CustomData := CustomData;

    NewImage := nil;

    if CreateTemp then
    begin
      GetMem(NewImage, Trunc(FormatGetSize(Format) * TempHeight * TempWidth));
      pDest := NewImage;
    end
    else
      pDest := Data;

    try
      // Mapping
      MapFunc := FormatGetMapFunc(Format);
      FormatPreparePixel(FuncRec.Dest, Format);
      FormatPreparePixel(FuncRec.Source, Source.internalformat);

      FuncRec.Size := Source.Dimension;
      FuncRec.Position.Fields := FuncRec.Size.Fields;

      if FormatIsUncompressed(Source.internalformat) then
      begin
        // Uncompressed Images
        pSource := Source.Data;
        UnMapFunc := FormatGetUnMapFunc(Source.internalformat);

        FuncRec.Position.Y := 0;
        while FuncRec.Position.Y < TempHeight do
        begin
          FuncRec.Position.X := 0;
          while FuncRec.Position.X < TempWidth do
          begin
            // Get Data
            UnMapFunc(pSource, FuncRec.Source);
            // Func
            Func(FuncRec);
            // Set Data
            MapFunc(FuncRec.Dest, pDest);
            Inc(FuncRec.Position.X);
          end;
          Inc(FuncRec.Position.Y);
        end;
      end
      else
      begin
        // Compressed Images
        FuncRec.Position.Y := 0;
        while FuncRec.Position.Y < TempHeight do
        begin
          FuncRec.Position.X := 0;
          while FuncRec.Position.X < TempWidth do
          begin
            // Get Data
            fGetPixelFunc(FuncRec.Position, FuncRec.Source);
            // Func
            Func(FuncRec);
            // Set Data
            MapFunc(FuncRec.Dest, pDest);
            Inc(FuncRec.Position.X);
          end;
          Inc(FuncRec.Position.Y);
        end;
      end;

      // Updating Image or InternalFormat
      if CreateTemp then
        SetDataPointer(NewImage, Format)
      else

        if Format <> internalformat then
        SetInternalFormat(Format);

      Result := True;
    except
      if CreateTemp then
        FreeMem(NewImage);
      raise;
    end;
  end;
end;

procedure glBitmapConvertCopyFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
  begin
    if Source.PixelDesc.RedRange > 0 then
      Dest.Red := Source.Red;

    if Source.PixelDesc.GreenRange > 0 then
      Dest.Green := Source.Green;

    if Source.PixelDesc.BlueRange > 0 then
      Dest.Blue := Source.Blue;

    if Source.PixelDesc.AlphaRange > 0 then
      Dest.Alpha := Source.Alpha;
  end;
end;

procedure glBitmapConvertCalculateRGBAFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
  begin
    if Source.PixelDesc.RedRange > 0 then
      Dest.Red := Round(Dest.PixelDesc.RedRange * Source.Red / Source.PixelDesc.RedRange);

    if Source.PixelDesc.GreenRange > 0 then
      Dest.Green := Round(Dest.PixelDesc.GreenRange * Source.Green / Source.PixelDesc.GreenRange);

    if Source.PixelDesc.BlueRange > 0 then
      Dest.Blue := Round(Dest.PixelDesc.BlueRange * Source.Blue / Source.PixelDesc.BlueRange);

    if Source.PixelDesc.AlphaRange > 0 then
      Dest.Alpha := Round(Dest.PixelDesc.AlphaRange * Source.Alpha / Source.PixelDesc.AlphaRange);
  end;
end;

procedure glBitmapConvertShiftRGBAFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
    with TglBitmapPixelDesc(CustomData^) do
    begin
      if Source.PixelDesc.RedRange > 0 then
        Dest.Red := Source.Red shr RedShift;

      if Source.PixelDesc.GreenRange > 0 then
        Dest.Green := Source.Green shr GreenShift;

      if Source.PixelDesc.BlueRange > 0 then
        Dest.Blue := Source.Blue shr BlueShift;

      if Source.PixelDesc.AlphaRange > 0 then
        Dest.Alpha := Source.Alpha shr AlphaShift;
    end;
end;

function TglBitmap.ConvertTo(NewFormat: TglBitmapInternalFormat): Boolean;
var
  Source, Dest: TglBitmapPixelData;
  PixelDesc: TglBitmapPixelDesc;

  function CopyDirect: Boolean;
  begin
    Result := ((Source.PixelDesc.RedRange = Dest.PixelDesc.RedRange) or (Source.PixelDesc.RedRange = 0) or (Dest.PixelDesc.RedRange = 0)) and ((Source.PixelDesc.GreenRange = Dest.PixelDesc.GreenRange) or (Source.PixelDesc.GreenRange = 0) or (Dest.PixelDesc.GreenRange = 0)) and
      ((Source.PixelDesc.BlueRange = Dest.PixelDesc.BlueRange) or (Source.PixelDesc.BlueRange = 0) or (Dest.PixelDesc.BlueRange = 0)) and ((Source.PixelDesc.AlphaRange = Dest.PixelDesc.AlphaRange) or (Source.PixelDesc.AlphaRange = 0) or (Dest.PixelDesc.AlphaRange = 0));
  end;

  function CanShift: Boolean;
  begin
    Result := ((Source.PixelDesc.RedRange >= Dest.PixelDesc.RedRange) or (Source.PixelDesc.RedRange = 0) or (Dest.PixelDesc.RedRange = 0)) and ((Source.PixelDesc.GreenRange >= Dest.PixelDesc.GreenRange) or (Source.PixelDesc.GreenRange = 0) or (Dest.PixelDesc.GreenRange = 0)) and
      ((Source.PixelDesc.BlueRange >= Dest.PixelDesc.BlueRange) or (Source.PixelDesc.BlueRange = 0) or (Dest.PixelDesc.BlueRange = 0)) and ((Source.PixelDesc.AlphaRange >= Dest.PixelDesc.AlphaRange) or (Source.PixelDesc.AlphaRange = 0) or (Dest.PixelDesc.AlphaRange = 0));
  end;

  function GetShift(Source, Dest: Cardinal): Shortint;
  begin
    Result := 0;

    while (Source > Dest) and (Source > 0) do
    begin
      Inc(Result);
      Source := Source shr 1;
    end;
  end;

begin
  if NewFormat <> internalformat then
  begin
    FormatPreparePixel(Source, internalformat);
    FormatPreparePixel(Dest, NewFormat);

    if CopyDirect then
      Result := AddFunc(Self, glBitmapConvertCopyFunc, false, NewFormat)
    else if CanShift then
    begin
      PixelDesc.RedShift := GetShift(Source.PixelDesc.RedRange, Dest.PixelDesc.RedRange);
      PixelDesc.GreenShift := GetShift(Source.PixelDesc.GreenRange, Dest.PixelDesc.GreenRange);
      PixelDesc.BlueShift := GetShift(Source.PixelDesc.BlueRange, Dest.PixelDesc.BlueRange);
      PixelDesc.AlphaShift := GetShift(Source.PixelDesc.AlphaRange, Dest.PixelDesc.AlphaRange);

      Result := AddFunc(Self, glBitmapConvertShiftRGBAFunc, false, NewFormat, @PixelDesc);
    end
    else
      Result := AddFunc(Self, glBitmapConvertCalculateRGBAFunc, false, NewFormat);
  end
  else
    Result := True;
end;

function TglBitmap.RemoveAlpha: Boolean;
begin
  Result := false;

  if (Assigned(Data)) then
  begin
    if not(FormatIsUncompressed(internalformat) or FormatHasAlpha(internalformat)) then
      raise EglBitmapUnsupportedInternalFormat.Create('RemoveAlpha - ' + UNSUPPORTED_INTERNAL_FORMAT);

    Result := ConvertTo(FormatGetWithoutAlpha(internalformat));
  end;
end;

function TglBitmap.AddAlphaFromFunc(Func: TglBitmapFunction; CustomData: Pointer): Boolean;
begin
  if not FormatIsUncompressed(internalformat) then
    raise EglBitmapUnsupportedInternalFormat.Create('AddAlphaFromFunc - ' + UNSUPPORTED_INTERNAL_FORMAT);

  Result := AddFunc(Self, Func, false, FormatGetWithAlpha(internalformat), CustomData);
end;

function TglBitmap.GetHeight: Integer;
begin
  if ffY in fDimension.Fields then
    Result := fDimension.Y
  else
    Result := -1;
end;

function TglBitmap.GetWidth: Integer;
begin
  if ffX in fDimension.Fields then
    Result := fDimension.X
  else
    Result := -1;
end;

function TglBitmap.GetFileHeight: Integer;
begin
  Result := Max(1, height);
end;

function TglBitmap.GetFileWidth: Integer;
begin
  Result := Max(1, width);
end;

procedure glBitmapAlphaFunc(var FuncRec: TglBitmapFunctionRec);
var
  Temp: single;
begin
  with FuncRec do
  begin
    Temp := Source.Red / Source.PixelDesc.RedRange * 0.3 + Source.Green / Source.PixelDesc.GreenRange * 0.59 + Source.Blue / Source.PixelDesc.BlueRange * 0.11;

    Dest.Alpha := Round(Dest.PixelDesc.AlphaRange * Temp);
  end;
end;

function TglBitmap.AddAlphaFromglBitmap(glBitmap: TglBitmap; Func: TglBitmapFunction; CustomData: Pointer): Boolean;
var
  pDest, pDest2, pSource: pByte;
  TempHeight, TempWidth: Integer;
  MapFunc: TglBitmapMapFunc;
  DestUnMapFunc, UnMapFunc: TglBitmapUnMapFunc;

  FuncRec: TglBitmapFunctionRec;
begin
  Result := false;

  Assert(Assigned(Data));
  Assert(Assigned(glBitmap));
  Assert(Assigned(glBitmap.Data));

  if ((glBitmap.width = width) and (glBitmap.height = height)) then
  begin
    // Convert to Data with Alpha
    Result := ConvertTo(FormatGetWithAlpha(FormatGetUncompressed(internalformat)));

    if not Assigned(Func) then
      Func := glBitmapAlphaFunc;

    // Values
    TempHeight := glBitmap.FileHeight;
    TempWidth := glBitmap.FileWidth;

    FuncRec.Sender := Self;
    FuncRec.CustomData := CustomData;

    pDest := Data;
    pDest2 := Data;
    pSource := glBitmap.Data;

    // Mapping
    FormatPreparePixel(FuncRec.Dest, internalformat);
    FormatPreparePixel(FuncRec.Source, glBitmap.internalformat);
    MapFunc := FormatGetMapFunc(internalformat);
    DestUnMapFunc := FormatGetUnMapFunc(internalformat);
    UnMapFunc := FormatGetUnMapFunc(glBitmap.internalformat);

    FuncRec.Size := Dimension;
    FuncRec.Position.Fields := FuncRec.Size.Fields;

    FuncRec.Position.Y := 0;
    while FuncRec.Position.Y < TempHeight do
    begin
      FuncRec.Position.X := 0;
      while FuncRec.Position.X < TempWidth do
      begin
        // Get Data
        UnMapFunc(pSource, FuncRec.Source);
        DestUnMapFunc(pDest2, FuncRec.Dest);
        // Func
        Func(FuncRec);
        // Set Data
        MapFunc(FuncRec.Dest, pDest);
        Inc(FuncRec.Position.X);
      end;
      Inc(FuncRec.Position.Y);
    end;
  end;
end;

procedure TglBitmap.SetBorderColor(Red, Green, Blue, Alpha: single);
begin
  fBorderColor[0] := Red;
  fBorderColor[1] := Green;
  fBorderColor[2] := Blue;
  fBorderColor[3] := Alpha;

  if ID > 0 then
  begin
    Bind(false);

    glTexParameterfv(target, GL_TEXTURE_BORDER_COLOR, @fBorderColor[0]);
  end;
end;

{ TglBitmap2D }

procedure TglBitmap2D.SetDataPointer(Data: pByte; Format: TglBitmapInternalFormat; width, height: Integer);
var
  Idx, LineWidth: Integer;
begin
  inherited;

  // Format
  if FormatIsUncompressed(Format) then
  begin
    fUnmapFunc := FormatGetUnMapFunc(Format);
    fGetPixelFunc := GetPixel2DUnmap;

    fMapFunc := FormatGetMapFunc(Format);
    fSetPixelFunc := SetPixel2DUnmap;

    // Assigning Data
    if Assigned(Data) then
    begin
      SetLength(fLines, GetHeight);

      LineWidth := Trunc(GetWidth * FormatGetSize(internalformat));

      for Idx := 0 to GetHeight - 1 do
      begin
        fLines[Idx] := Data;
        Inc(fLines[Idx], Idx * LineWidth);
      end;
    end
    else
      SetLength(fLines, 0);
  end
  else
  begin
    SetLength(fLines, 0);

    fSetPixelFunc := nil;

    case Format of
      ifDXT1:
        fGetPixelFunc := GetPixel2DDXT1;
      ifDXT3:
        fGetPixelFunc := GetPixel2DDXT3;
      ifDXT5:
        fGetPixelFunc := GetPixel2DDXT5;
    else
      fGetPixelFunc := nil;
    end;
  end;
end;

procedure TglBitmap2D.GetDXTColorBlock(pData: pByte; relX, relY: Integer; var Pixel: TglBitmapPixelData);
type
  PDXT1Chunk = ^TDXT1Chunk;

  TDXT1Chunk = packed record
    Color1: Word;
    Color2: Word;
    pixels: array [0 .. 3] of Byte;
  end;

var
  BasePtr: PDXT1Chunk;
  PixPos: Integer;
  Colors: array [0 .. 3] of TRGBQuad;
begin
  BasePtr := PDXT1Chunk(pData);

  PixPos := BasePtr^.pixels[relY] shr (relX * 2) and $3;

  if PixPos in [0, 2, 3] then
  begin
    Colors[0].rgbRed := BasePtr^.Color1 and $F800 shr 8;
    Colors[0].rgbGreen := BasePtr^.Color1 and $07E0 shr 3;
    Colors[0].rgbBlue := BasePtr^.Color1 and $001F shl 3;
    Colors[0].rgbReserved := 255;
  end;

  if PixPos in [1, 2, 3] then
  begin
    Colors[1].rgbRed := BasePtr^.Color2 and $F800 shr 8;
    Colors[1].rgbGreen := BasePtr^.Color2 and $07E0 shr 3;
    Colors[1].rgbBlue := BasePtr^.Color2 and $001F shl 3;
    Colors[1].rgbReserved := 255;
  end;

  if PixPos = 2 then
  begin
    Colors[2].rgbRed := (Colors[0].rgbRed * 67 + Colors[1].rgbRed * 33) div 100;
    Colors[2].rgbGreen := (Colors[0].rgbGreen * 67 + Colors[1].rgbGreen * 33) div 100;
    Colors[2].rgbBlue := (Colors[0].rgbBlue * 67 + Colors[1].rgbBlue * 33) div 100;
    Colors[2].rgbReserved := 255;
  end;

  if PixPos = 3 then
  begin
    Colors[3].rgbRed := (Colors[0].rgbRed * 33 + Colors[1].rgbRed * 67) div 100;
    Colors[3].rgbGreen := (Colors[0].rgbGreen * 33 + Colors[1].rgbGreen * 67) div 100;
    Colors[3].rgbBlue := (Colors[0].rgbBlue * 33 + Colors[1].rgbBlue * 67) div 100;
    if BasePtr^.Color1 > BasePtr^.Color2 then
      Colors[3].rgbReserved := 255
    else
      Colors[3].rgbReserved := 0;
  end;

  Pixel.Red := Colors[PixPos].rgbRed;
  Pixel.Green := Colors[PixPos].rgbGreen;
  Pixel.Blue := Colors[PixPos].rgbBlue;
  Pixel.Alpha := Colors[PixPos].rgbReserved;
end;

procedure TglBitmap2D.GetPixel2DDXT1(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
var
  BasePtr: pByte;
  PosX, PosY: Integer;
begin
  inherited;

  if (Pos.Y <= height) and (Pos.X <= width) then
  begin
    PosX := Pos.X div 4;
    PosY := Pos.Y div 4;

    BasePtr := Data;
    Inc(BasePtr, (PosY * width div 4 + PosX) * 8);

    GetDXTColorBlock(BasePtr, Pos.X - PosX * 4, Pos.Y - PosY * 4, Pixel);
  end;
end;

procedure TglBitmap2D.GetPixel2DDXT3(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
type
  PDXT3AlphaChunk = ^TDXT3AlphaChunk;
  TDXT3AlphaChunk = array [0 .. 3] of Word;

var
  ColorPtr: pByte;
  AlphaPtr: PDXT3AlphaChunk;
  PosX, PosY, relX, relY: Integer;
begin
  inherited;

  if (Pos.Y <= height) and (Pos.X <= width) then
  begin
    PosX := Pos.X div 4;
    PosY := Pos.Y div 4;
    relX := Pos.X - PosX * 4;
    relY := Pos.Y - PosY * 4;

    // get color value
    AlphaPtr := PDXT3AlphaChunk(Data);
    Inc(AlphaPtr, (PosY * width div 4 + PosX) * 2);

    ColorPtr := pByte(AlphaPtr);
    Inc(ColorPtr, 8);

    GetDXTColorBlock(ColorPtr, relX, relY, Pixel);

    // extracting alpha
    Pixel.Alpha := AlphaPtr^[relY] shr (4 * relX) and $0F shl 4;
  end;
end;

procedure TglBitmap2D.GetPixel2DDXT5(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
var
  ColorPtr: pByte;
  AlphaPtr: PInt64;
  PixPos, PosX, PosY, relX, relY: Integer;
  Alpha0, Alpha1: Byte;
begin
  inherited;

  if (Pos.Y <= height) and (Pos.X <= width) then
  begin
    PosX := Pos.X div 4;
    PosY := Pos.Y div 4;
    relX := Pos.X - PosX * 4;
    relY := Pos.Y - PosY * 4;

    // get color value
    AlphaPtr := PInt64(Data);
    Inc(AlphaPtr, (PosY * width div 4 + PosX) * 2);

    ColorPtr := pByte(AlphaPtr);
    Inc(ColorPtr, 8);

    GetDXTColorBlock(ColorPtr, relX, relY, Pixel);

    // extracting alpha
    Alpha0 := AlphaPtr^ and $FF;
    Alpha1 := AlphaPtr^ shr 8 and $FF;

    PixPos := AlphaPtr^ shr (16 + (relY * 4 + relX) * 3) and $07;

    // use alpha 0
    if PixPos = 0 then
    begin
      Pixel.Alpha := Alpha0;
    end
    else

      // use alpha 1
      if PixPos = 1 then
      begin
        Pixel.Alpha := Alpha1;
      end
      else

        // alpha interpolate 7 Steps
        if Alpha0 > Alpha1 then
        begin
          Pixel.Alpha := ((8 - PixPos) * Alpha0 + (PixPos - 1) * Alpha1) div 7;
        end
        else

          // alpha is 100% transparent or not transparent
          if PixPos >= 6 then
          begin
            if PixPos = 6 then
              Pixel.Alpha := 0
            else
              Pixel.Alpha := 255;
          end
          else

          // alpha interpolate 5 Steps
          begin
            Pixel.Alpha := ((6 - PixPos) * Alpha0 + (PixPos - 1) * Alpha1) div 5;
          end;
  end;
end;

procedure TglBitmap2D.GetPixel2DUnmap(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
var
  pTemp: pByte;
begin
  pTemp := fLines[Pos.Y];
  Inc(pTemp, Pos.X * fPixelSize);

  fUnmapFunc(pTemp, Pixel);
end;

procedure TglBitmap2D.SetPixel2DUnmap(const Pos: TglBitmapPixelPosition; const Pixel: TglBitmapPixelData);
var
  pTemp: pByte;
begin
  pTemp := fLines[Pos.Y];
  Inc(pTemp, Pos.X * fPixelSize);

  fMapFunc(Pixel, pTemp);
end;

function TglBitmap2D.FlipHorz: Boolean;
var
  Col, Row: Integer;
  pTempDest, pDest, pSource: pByte;
  ImgSize: Integer;
begin
  Result := Inherited FlipHorz;

  if Assigned(Data) then
  begin
    pSource := Data;
    ImgSize := height * fRowSize;

    GetMem(pDest, ImgSize);
    try
      pTempDest := pDest;

      Dec(pTempDest, fRowSize + fPixelSize);
      for Row := 0 to height - 1 do
      begin
        Inc(pTempDest, fRowSize * 2);
        for Col := 0 to width - 1 do
        begin
          Move(pSource^, pTempDest^, fPixelSize);

          Inc(pSource, fPixelSize);
          Dec(pTempDest, fPixelSize);
        end;
      end;

      SetDataPointer(pDest, internalformat);

      Result := True;
    except
      FreeMem(pDest);
      raise;
    end;
  end;
end;

function TglBitmap2D.FlipVert: Boolean;
var
  Row: Integer;
  pTempDest, pDest, pSource: pByte;
begin
  Result := Inherited FlipVert;

  if Assigned(Data) then
  begin
    pSource := Data;
    GetMem(pDest, height * fRowSize);
    try
      pTempDest := pDest;

      Inc(pTempDest, width * (height - 1) * fPixelSize);

      for Row := 0 to height - 1 do
      begin
        Move(pSource^, pTempDest^, fRowSize);

        Dec(pTempDest, fRowSize);
        Inc(pSource, fRowSize);
      end;

      SetDataPointer(pDest, internalformat);

      Result := True;
    except
      FreeMem(pDest);
      raise;
    end;
  end;
end;

procedure TglBitmap2D.UploadData(target, Format, internalformat, Typ: Cardinal; BuildWithGlu: Boolean);
begin
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

  // Upload data
  if Self.internalformat in [ifDXT1, ifDXT3, ifDXT5] then
    glCompressedTexImage2D(target, 0, internalformat, width, height, 0, Trunc(width * height * FormatGetSize(Self.internalformat)), Data)
  else

    if BuildWithGlu then
    gluBuild2DMipmaps(target, internalformat, width, height, Format, Typ, Data)
  else
    glTexImage2D(target, 0, internalformat, width, height, 0, Format, Typ, Data);

  // Freigeben
  if (FreeDataAfterGenTexture) then
    FreeData;
end;

procedure TglBitmap2D.GenTexture(TestTextureSize: Boolean);
var
  BuildWithGlu, PotTex, TexRec: Boolean;
  glFormat, glInternalFormat, glType: Cardinal;
  TexSize: Integer;
begin
  if Assigned(Data) then
  begin
    // Check Texture Size
    if (TestTextureSize) then
    begin
      glGetIntegerv(GL_MAX_TEXTURE_SIZE, @TexSize);

      if ((height > TexSize) or (width > TexSize)) then
        raise EglBitmapSizeToLargeException.Create('TglBitmap2D.GenTexture - The size for the texture is to large. It''s may be not conform with the Hardware.');

      PotTex := IsPowerOfTwo(height) and IsPowerOfTwo(width);
      TexRec := (GL_ARB_texture_rectangle or GL_EXT_texture_rectangle or GL_NV_texture_rectangle) and (target = GL_TEXTURE_RECTANGLE_ARB);

      if not(PotTex or GL_ARB_texture_non_power_of_two or GL_VERSION_2_0 or TexRec) then
        raise EglBitmapNonPowerOfTwoException.Create('TglBitmap2D.GenTexture - Rendercontex dosn''t support non power of two texture.');
    end;

    CreateID;

    SetupParameters(BuildWithGlu);
    SelectFormat(internalformat, glFormat, glInternalFormat, glType);

    UploadData(target, glFormat, glInternalFormat, glType, BuildWithGlu);

    // Infos sammeln
    glAreTexturesResident(1, @ID, @fIsResident);
  end;
end;

procedure TglBitmap2D.AfterConstruction;
begin
  inherited;

  target := GL_TEXTURE_2D;
end;

type
  TMatrixItem = record
    X, Y: Integer;
    w: single;
  end;

  PglBitmapToNormalMapRec = ^TglBitmapToNormalMapRec;

  TglBitmapToNormalMapRec = Record
    Scale: single;
    Heights: array of single;
    MatrixU: array of TMatrixItem;
    MatrixV: array of TMatrixItem;
  end;

const
  oneover255 = 1 / 255;

procedure glBitmapToNormalMapPrepareFunc(var FuncRec: TglBitmapFunctionRec);
var
  Val: single;
begin
  with FuncRec do
  begin
    Val := Source.Red * 0.3 + Source.Green * 0.59 + Source.Blue * 0.11;
    PglBitmapToNormalMapRec(CustomData)^.Heights[Position.Y * Size.X + Position.X] := Val * oneover255;
  end;
end;

procedure glBitmapToNormalMapPrepareAlphaFunc(var FuncRec: TglBitmapFunctionRec);
begin
  with FuncRec do
    PglBitmapToNormalMapRec(CustomData)^.Heights[Position.Y * Size.X + Position.X] := Source.Alpha * oneover255;
end;

procedure glBitmapToNormalMapFunc(var FuncRec: TglBitmapFunctionRec);
type
  TVec = Array [0 .. 2] of single;
var
  Idx: Integer;
  du, dv: Double;
  Len: single;
  Vec: TVec;

  function GetHeight(X, Y: Integer): single;
  begin
    with FuncRec do
    begin
      X := Max(0, Min(Size.X - 1, X));
      Y := Max(0, Min(Size.Y - 1, Y));

      Result := PglBitmapToNormalMapRec(CustomData)^.Heights[Y * Size.X + X];
    end;
  end;

begin
  with FuncRec do
  begin
    with PglBitmapToNormalMapRec(CustomData)^ do
    begin
      du := 0;
      for Idx := Low(MatrixU) to High(MatrixU) do
        du := du + GetHeight(Position.X + MatrixU[Idx].X, Position.Y + MatrixU[Idx].Y) * MatrixU[Idx].w;

      dv := 0;
      for Idx := Low(MatrixU) to High(MatrixU) do
        dv := dv + GetHeight(Position.X + MatrixV[Idx].X, Position.Y + MatrixV[Idx].Y) * MatrixV[Idx].w;

      Vec[0] := -du * Scale;
      Vec[1] := -dv * Scale;
      Vec[2] := 1;
    end;

    // Normalize
    Len := 1 / Sqrt(Sqr(Vec[0]) + Sqr(Vec[1]) + Sqr(Vec[2]));
    if Len <> 0 then
    begin
      Vec[0] := Vec[0] * Len;
      Vec[1] := Vec[1] * Len;
      Vec[2] := Vec[2] * Len;
    end;

    // Farbe zuweisem
    Dest.Red := Trunc((Vec[0] + 1) * 127.5);
    Dest.Green := Trunc((Vec[1] + 1) * 127.5);
    Dest.Blue := Trunc((Vec[2] + 1) * 127.5);
  end;
end;

procedure TglBitmap2D.ToNormalMap(Func: TglBitmapNormalMapFunc; Scale: single; UseAlpha: Boolean);
var
  Rec: TglBitmapToNormalMapRec;

  procedure SetEntry(var Matrix: array of TMatrixItem; Index, X, Y: Integer; w: single);
  begin
    if (Index >= Low(Matrix)) and (Index <= High(Matrix)) then
    begin
      Matrix[Index].X := X;
      Matrix[Index].Y := Y;
      Matrix[Index].w := w;
    end;
  end;

begin
  if not FormatIsUncompressed(internalformat) then
    raise EglBitmapUnsupportedInternalFormat.Create('TglBitmap2D.ToNormalMap - ' + UNSUPPORTED_INTERNAL_FORMAT);

  if Scale > 100 then
    Rec.Scale := 100
  else if Scale < -100 then
    Rec.Scale := -100
  else
    Rec.Scale := Scale;

  SetLength(Rec.Heights, width * height);
  try
    case Func of
      nm4Samples:
        begin
          SetLength(Rec.MatrixU, 2);
          SetEntry(Rec.MatrixU, 0, -1, 0, -0.5);
          SetEntry(Rec.MatrixU, 1, 1, 0, 0.5);

          SetLength(Rec.MatrixV, 2);
          SetEntry(Rec.MatrixV, 0, 0, 1, 0.5);
          SetEntry(Rec.MatrixV, 1, 0, -1, -0.5);
        end;
      nmSobel:
        begin
          SetLength(Rec.MatrixU, 6);
          SetEntry(Rec.MatrixU, 0, -1, 1, -1.0);
          SetEntry(Rec.MatrixU, 1, -1, 0, -2.0);
          SetEntry(Rec.MatrixU, 2, -1, -1, -1.0);
          SetEntry(Rec.MatrixU, 3, 1, 1, 1.0);
          SetEntry(Rec.MatrixU, 4, 1, 0, 2.0);
          SetEntry(Rec.MatrixU, 5, 1, -1, 1.0);

          SetLength(Rec.MatrixV, 6);
          SetEntry(Rec.MatrixV, 0, -1, 1, 1.0);
          SetEntry(Rec.MatrixV, 1, 0, 1, 2.0);
          SetEntry(Rec.MatrixV, 2, 1, 1, 1.0);
          SetEntry(Rec.MatrixV, 3, -1, -1, -1.0);
          SetEntry(Rec.MatrixV, 4, 0, -1, -2.0);
          SetEntry(Rec.MatrixV, 5, 1, -1, -1.0);
        end;
      nm3x3:
        begin
          SetLength(Rec.MatrixU, 6);
          SetEntry(Rec.MatrixU, 0, -1, 1, -1 / 6);
          SetEntry(Rec.MatrixU, 1, -1, 0, -1 / 6);
          SetEntry(Rec.MatrixU, 2, -1, -1, -1 / 6);
          SetEntry(Rec.MatrixU, 3, 1, 1, 1 / 6);
          SetEntry(Rec.MatrixU, 4, 1, 0, 1 / 6);
          SetEntry(Rec.MatrixU, 5, 1, -1, 1 / 6);

          SetLength(Rec.MatrixV, 6);
          SetEntry(Rec.MatrixV, 0, -1, 1, 1 / 6);
          SetEntry(Rec.MatrixV, 1, 0, 1, 1 / 6);
          SetEntry(Rec.MatrixV, 2, 1, 1, 1 / 6);
          SetEntry(Rec.MatrixV, 3, -1, -1, -1 / 6);
          SetEntry(Rec.MatrixV, 4, 0, -1, -1 / 6);
          SetEntry(Rec.MatrixV, 5, 1, -1, -1 / 6);
        end;
      nm5x5:
        begin
          SetLength(Rec.MatrixU, 20);
          SetEntry(Rec.MatrixU, 0, -2, 2, -1 / 16);
          SetEntry(Rec.MatrixU, 1, -1, 2, -1 / 10);
          SetEntry(Rec.MatrixU, 2, 1, 2, 1 / 10);
          SetEntry(Rec.MatrixU, 3, 2, 2, 1 / 16);
          SetEntry(Rec.MatrixU, 4, -2, 1, -1 / 10);
          SetEntry(Rec.MatrixU, 5, -1, 1, -1 / 8);
          SetEntry(Rec.MatrixU, 6, 1, 1, 1 / 8);
          SetEntry(Rec.MatrixU, 7, 2, 1, 1 / 10);
          SetEntry(Rec.MatrixU, 8, -2, 0, -1 / 2.8);
          SetEntry(Rec.MatrixU, 9, -1, 0, -0.5);
          SetEntry(Rec.MatrixU, 10, 1, 0, 0.5);
          SetEntry(Rec.MatrixU, 11, 2, 0, 1 / 2.8);
          SetEntry(Rec.MatrixU, 12, -2, -1, -1 / 10);
          SetEntry(Rec.MatrixU, 13, -1, -1, -1 / 8);
          SetEntry(Rec.MatrixU, 14, 1, -1, 1 / 8);
          SetEntry(Rec.MatrixU, 15, 2, -1, 1 / 10);
          SetEntry(Rec.MatrixU, 16, -2, -2, -1 / 16);
          SetEntry(Rec.MatrixU, 17, -1, -2, -1 / 10);
          SetEntry(Rec.MatrixU, 18, 1, -2, 1 / 10);
          SetEntry(Rec.MatrixU, 19, 2, -2, 1 / 16);

          SetLength(Rec.MatrixV, 20);
          SetEntry(Rec.MatrixV, 0, -2, 2, 1 / 16);
          SetEntry(Rec.MatrixV, 1, -1, 2, 1 / 10);
          SetEntry(Rec.MatrixV, 2, 0, 2, 0.25);
          SetEntry(Rec.MatrixV, 3, 1, 2, 1 / 10);
          SetEntry(Rec.MatrixV, 4, 2, 2, 1 / 16);
          SetEntry(Rec.MatrixV, 5, -2, 1, 1 / 10);
          SetEntry(Rec.MatrixV, 6, -1, 1, 1 / 8);
          SetEntry(Rec.MatrixV, 7, 0, 1, 0.5);
          SetEntry(Rec.MatrixV, 8, 1, 1, 1 / 8);
          SetEntry(Rec.MatrixV, 9, 2, 1, 1 / 16);
          SetEntry(Rec.MatrixV, 10, -2, -1, -1 / 16);
          SetEntry(Rec.MatrixV, 11, -1, -1, -1 / 8);
          SetEntry(Rec.MatrixV, 12, 0, -1, -0.5);
          SetEntry(Rec.MatrixV, 13, 1, -1, -1 / 8);
          SetEntry(Rec.MatrixV, 14, 2, -1, -1 / 10);
          SetEntry(Rec.MatrixV, 15, -2, -2, -1 / 16);
          SetEntry(Rec.MatrixV, 16, -1, -2, -1 / 10);
          SetEntry(Rec.MatrixV, 17, 0, -2, -0.25);
          SetEntry(Rec.MatrixV, 18, 1, -2, -1 / 10);
          SetEntry(Rec.MatrixV, 19, 2, -2, -1 / 16);
        end;
    end;

    // Daten Sammeln
    if UseAlpha and FormatHasAlpha(internalformat) then
      AddFunc(glBitmapToNormalMapPrepareAlphaFunc, false, @Rec)
    else
      AddFunc(glBitmapToNormalMapPrepareFunc, false, @Rec);

    // Neues Bild berechnen
    AddFunc(glBitmapToNormalMapFunc, false, @Rec);
  finally
    SetLength(Rec.Heights, 0);
  end;
end;

procedure TglBitmap2D.GrabScreen(Top, Left, Right, Bottom: Integer; Format: TglBitmapInternalFormat);
var
  Temp: pByte;
  Size: Integer;
  glFormat, glInternalFormat, glType: Cardinal;
begin
  if not FormatIsUncompressed(Format) then
    raise EglBitmapUnsupportedInternalFormat.Create('TglBitmap2D.GrabScreen - ' + UNSUPPORTED_INTERNAL_FORMAT);

  // Only to select Formats
  SelectFormat(Format, glFormat, glInternalFormat, glType, false);

  Size := FormatGetImageSize(glBitmapPosition(Right - Left, Bottom - Top), Format);
  GetMem(Temp, Size);
  try
    glPixelStorei(GL_PACK_ALIGNMENT, 1);
    glReadPixels(Left, Top, Right - Left, Bottom - Top, glFormat, glType, Temp);

    // Set Data
    SetDataPointer(Temp, Format, Right - Left, Bottom - Top);

    // Flip
    FlipVert;
  except
    FreeMem(Temp);
    raise;
  end;
end;

procedure TglBitmap2D.GetDataFromTexture;
var
  Temp: pByte;
  TempWidth, TempHeight, RedSize, GreenSize, BlueSize, AlphaSize, LumSize: Integer;
  TempType, TempIntFormat: Cardinal;
  IntFormat: TglBitmapInternalFormat;
begin
  Bind;

  // Request Data
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_WIDTH, @TempWidth);
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_HEIGHT, @TempHeight);
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_INTERNAL_FORMAT, @TempIntFormat);

  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_RED_SIZE, @RedSize);
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_GREEN_SIZE, @GreenSize);
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_BLUE_SIZE, @BlueSize);
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_ALPHA_SIZE, @AlphaSize);
  glGetTexLevelParameteriv(target, 0, GL_TEXTURE_LUMINANCE_SIZE, @LumSize);

  // Get glBitmapInternalFormat from TempIntFormat
  TempType := GL_UNSIGNED_BYTE;
  case TempIntFormat of
    GL_ALPHA:
      IntFormat := ifAlpha;
    GL_LUMINANCE:
      IntFormat := ifLuminance;
    GL_LUMINANCE_ALPHA:
      IntFormat := ifLuminanceAlpha;
    GL_RGB4:
      begin
        IntFormat := ifR5G6B5;
        TempIntFormat := GL_RGB;
        TempType := GL_UNSIGNED_SHORT_5_6_5;
      end;
    GL_RGB, GL_RGB8:
      IntFormat := ifRGB8;
    GL_RGBA, GL_RGBA4, GL_RGBA8:
      begin
        if (RedSize = 4) and (BlueSize = 4) and (GreenSize = 4) and (AlphaSize = 4) then
        begin
          IntFormat := ifRGBA4;
          TempIntFormat := GL_BGRA;
          TempType := GL_UNSIGNED_SHORT_4_4_4_4_REV;
        end
        else if (RedSize = 5) and (BlueSize = 5) and (GreenSize = 5) and (AlphaSize = 1) then
        begin
          IntFormat := ifRGB5A1;
          TempIntFormat := GL_BGRA;
          TempType := GL_UNSIGNED_SHORT_1_5_5_5_REV;
        end
        else
        begin
          IntFormat := ifRGBA8;
        end;
      end;
    GL_BGR:
      IntFormat := ifBGR8;
    GL_BGRA:
      IntFormat := ifBGRA8;
    GL_COMPRESSED_RGB_S3TC_DXT1_EXT:
      IntFormat := ifDXT1;
    GL_COMPRESSED_RGBA_S3TC_DXT1_EXT:
      IntFormat := ifDXT1;
    GL_COMPRESSED_RGBA_S3TC_DXT3_EXT:
      IntFormat := ifDXT3;
    GL_COMPRESSED_RGBA_S3TC_DXT5_EXT:
      IntFormat := ifDXT5;
  else
    IntFormat := ifEmpty;
  end;

  // Getting data from OpenGL
  GetMem(Temp, FormatGetImageSize(glBitmapPosition(TempWidth, TempHeight), IntFormat));
  try
    if FormatIsCompressed(IntFormat) and (GL_VERSION_1_3 or GL_ARB_texture_compression) then
      glGetCompressedTexImage(target, 0, Temp)
    else
      glGetTexImage(target, 0, TempIntFormat, TempType, Temp);

    SetDataPointer(Temp, IntFormat, TempWidth, TempHeight);
  except
    FreeMem(Temp);
    raise;
  end;
end;

function TglBitmap2D.GetScanline(Index: Integer): Pointer;
begin
  if (Index >= Low(fLines)) and (Index <= High(fLines)) then
    Result := fLines[Index]
  else
    Result := nil;
end;

{ TglBitmap1D }

procedure TglBitmap1D.SetDataPointer(Data: pByte; Format: TglBitmapInternalFormat; width, height: Integer);
var
  pTemp: pByte;
  Size: Integer;
begin
  if height > 1 then
  begin
    // extract first line of the data
    Size := FormatGetImageSize(glBitmapPosition(width), Format);
    GetMem(pTemp, Size);

    Move(Data^, pTemp^, Size);

    FreeMem(Data);
  end
  else
    pTemp := Data;

  // set data pointer
  inherited SetDataPointer(pTemp, Format, width);

  if FormatIsUncompressed(Format) then
  begin
    fUnmapFunc := FormatGetUnMapFunc(Format);
    fGetPixelFunc := GetPixel1DUnmap;
  end;
end;

procedure TglBitmap1D.GetPixel1DUnmap(const Pos: TglBitmapPixelPosition; var Pixel: TglBitmapPixelData);
var
  pTemp: pByte;
begin
  pTemp := Data;
  Inc(pTemp, Pos.X * fPixelSize);

  fUnmapFunc(pTemp, Pixel);
end;

function TglBitmap1D.FlipHorz: Boolean;
var
  Col: Integer;
  pTempDest, pDest, pSource: pByte;
begin
  Result := Inherited FlipHorz;

  if Assigned(Data) and FormatIsUncompressed(internalformat) then
  begin
    pSource := Data;

    GetMem(pDest, fRowSize);
    try
      pTempDest := pDest;

      Inc(pTempDest, fRowSize);
      for Col := 0 to width - 1 do
      begin
        Move(pSource^, pTempDest^, fPixelSize);

        Inc(pSource, fPixelSize);
        Dec(pTempDest, fPixelSize);
      end;

      SetDataPointer(pDest, internalformat);

      Result := True;
    finally
      FreeMem(pDest);
    end;
  end;
end;

procedure TglBitmap1D.UploadData(target, Format, internalformat, Typ: Cardinal; BuildWithGlu: Boolean);
begin
  // Upload data
  if Self.internalformat in [ifDXT1, ifDXT3, ifDXT5] then
    glCompressedTexImage1D(target, 0, internalformat, width, 0, Trunc(width * FormatGetSize(Self.internalformat)), Data)
  else

    // Upload data
    if BuildWithGlu then
      gluBuild1DMipmaps(target, internalformat, width, Format, Typ, Data)
    else
      glTexImage1D(target, 0, internalformat, width, 0, Format, Typ, Data);

  // Freigeben
  if (FreeDataAfterGenTexture) then
    FreeData;
end;

procedure TglBitmap1D.GenTexture(TestTextureSize: Boolean);
var
  BuildWithGlu, TexRec: Boolean;
  glFormat, glInternalFormat, glType: Cardinal;
  TexSize: Integer;
begin
  if Assigned(Data) then
  begin
    // Check Texture Size
    if (TestTextureSize) then
    begin
      glGetIntegerv(GL_MAX_TEXTURE_SIZE, @TexSize);

      if (width > TexSize) then
        raise EglBitmapSizeToLargeException.Create('TglBitmap1D.GenTexture - The size for the texture is to large. It''s may be not conform with the Hardware.');

      TexRec := (GL_ARB_texture_rectangle or GL_EXT_texture_rectangle or GL_NV_texture_rectangle) and (target = GL_TEXTURE_RECTANGLE_ARB);

      if not(IsPowerOfTwo(width) or GL_ARB_texture_non_power_of_two or GL_VERSION_2_0 or TexRec) then
        raise EglBitmapNonPowerOfTwoException.Create('TglBitmap1D.GenTexture - Rendercontex dosn''t support non power of two texture.');
    end;

    CreateID;

    SetupParameters(BuildWithGlu);
    SelectFormat(internalformat, glFormat, glInternalFormat, glType);

    UploadData(target, glFormat, glInternalFormat, glType, BuildWithGlu);

    // Infos sammeln
    glAreTexturesResident(1, @ID, @fIsResident);
  end;
end;

procedure TglBitmap1D.AfterConstruction;
begin
  inherited;

  target := GL_TEXTURE_1D;
end;

{ TglBitmapCubeMap }

procedure TglBitmapCubeMap.AfterConstruction;
begin
  inherited;

  if not(GL_VERSION_1_3 or GL_ARB_texture_cube_map or GL_EXT_texture_cube_map) then
    raise EglBitmapException.Create('TglBitmapCubeMap.AfterConstruction - CubeMaps are unsupported.');

  SetWrap; // set all to GL_CLAMP_TO_EDGE
  target := GL_TEXTURE_CUBE_MAP;
  fGenMode := GL_REFLECTION_MAP;
end;

procedure TglBitmapCubeMap.Bind(EnableTexCoordsGen, EnableTextureUnit: Boolean);
begin
  inherited Bind(EnableTextureUnit);

  if EnableTexCoordsGen then
  begin
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, fGenMode);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, fGenMode);
    glTexGeni(GL_R, GL_TEXTURE_GEN_MODE, fGenMode);
    glEnable(GL_TEXTURE_GEN_S);
    glEnable(GL_TEXTURE_GEN_T);
    glEnable(GL_TEXTURE_GEN_R);
  end;
end;

procedure TglBitmapCubeMap.GenerateCubeMap(CubeTarget: Cardinal; TestTextureSize: Boolean);
var
  glFormat, glInternalFormat, glType: Cardinal;
  BuildWithGlu: Boolean;
  TexSize: Integer;
begin
  // Check Texture Size
  if (TestTextureSize) then
  begin
    glGetIntegerv(GL_MAX_CUBE_MAP_TEXTURE_SIZE, @TexSize);

    if ((height > TexSize) or (width > TexSize)) then
      raise EglBitmapSizeToLargeException.Create('TglBitmapCubeMap.GenTexture - The size for the Cubemap is to large. It''s may be not conform with the Hardware.');

    if not((IsPowerOfTwo(height) and IsPowerOfTwo(width)) or GL_VERSION_2_0 or GL_ARB_texture_non_power_of_two) then
      raise EglBitmapNonPowerOfTwoException.Create('TglBitmapCubeMap.GenTexture - Cubemaps dosn''t support non power of two texture.');
  end;

  // create Texture
  if ID = 0 then
  begin
    CreateID;
    SetupParameters(BuildWithGlu);
  end;

  SelectFormat(internalformat, glFormat, glInternalFormat, glType);

  UploadData(CubeTarget, glFormat, glInternalFormat, glType, BuildWithGlu);
end;

procedure TglBitmapCubeMap.GenTexture(TestTextureSize: Boolean);
begin
  Assert(false, 'TglBitmapCubeMap.GenTexture - Don''t call GenTextures directly.');
end;

procedure TglBitmapCubeMap.Unbind(DisableTexCoordsGen, DisableTextureUnit: Boolean);
begin
  inherited Unbind(DisableTextureUnit);

  if DisableTexCoordsGen then
  begin
    glDisable(GL_TEXTURE_GEN_S);
    glDisable(GL_TEXTURE_GEN_T);
    glDisable(GL_TEXTURE_GEN_R);
  end;
end;

{ TglBitmapNormalMap }

type
  TVec = Array [0 .. 2] of single;
  TglBitmapNormalMapGetVectorFunc = procedure(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);

  PglBitmapNormalMapRec = ^TglBitmapNormalMapRec;

  TglBitmapNormalMapRec = record
    HalfSize: Integer;
    Func: TglBitmapNormalMapGetVectorFunc;
  end;

procedure glBitmapNormalMapPosX(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);
begin
  Vec[0] := HalfSize;
  Vec[1] := -(Position.Y + 0.5 - HalfSize);
  Vec[2] := -(Position.X + 0.5 - HalfSize);
end;

procedure glBitmapNormalMapNegX(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);
begin
  Vec[0] := -HalfSize;
  Vec[1] := -(Position.Y + 0.5 - HalfSize);
  Vec[2] := Position.X + 0.5 - HalfSize;
end;

procedure glBitmapNormalMapPosY(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);
begin
  Vec[0] := Position.X + 0.5 - HalfSize;
  Vec[1] := HalfSize;
  Vec[2] := Position.Y + 0.5 - HalfSize;
end;

procedure glBitmapNormalMapNegY(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);
begin
  Vec[0] := Position.X + 0.5 - HalfSize;
  Vec[1] := -HalfSize;
  Vec[2] := -(Position.Y + 0.5 - HalfSize);
end;

procedure glBitmapNormalMapPosZ(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);
begin
  Vec[0] := Position.X + 0.5 - HalfSize;
  Vec[1] := -(Position.Y + 0.5 - HalfSize);
  Vec[2] := HalfSize;
end;

procedure glBitmapNormalMapNegZ(var Vec: TVec; const Position: TglBitmapPixelPosition; const HalfSize: Integer);
begin
  Vec[0] := -(Position.X + 0.5 - HalfSize);
  Vec[1] := -(Position.Y + 0.5 - HalfSize);
  Vec[2] := -HalfSize;
end;

procedure glBitmapNormalMapFunc(var FuncRec: TglBitmapFunctionRec);
var
  Vec: TVec;
  Len: single;
begin
  with FuncRec do
  begin
    with PglBitmapNormalMapRec(CustomData)^ do
    begin
      Func(Vec, Position, HalfSize);

      // Normalize
      Len := 1 / Sqrt(Sqr(Vec[0]) + Sqr(Vec[1]) + Sqr(Vec[2]));
      if Len <> 0 then
      begin
        Vec[0] := Vec[0] * Len;
        Vec[1] := Vec[1] * Len;
        Vec[2] := Vec[2] * Len;
      end;

      // Scale Vector and AddVectro
      Vec[0] := Vec[0] * 0.5 + 0.5;
      Vec[1] := Vec[1] * 0.5 + 0.5;
      Vec[2] := Vec[2] * 0.5 + 0.5;
    end;

    // Set Color
    Dest.Red := Round(Vec[0] * 255);
    Dest.Green := Round(Vec[1] * 255);
    Dest.Blue := Round(Vec[2] * 255);
  end;
end;

procedure TglBitmapNormalMap.AfterConstruction;
begin
  inherited;

  fGenMode := GL_NORMAL_MAP;
end;

procedure TglBitmapNormalMap.GenerateNormalMap(Size: Integer; TestTextureSize: Boolean);
var
  Rec: TglBitmapNormalMapRec;
  SizeRec: TglBitmapPixelPosition;
begin
  Rec.HalfSize := Size div 2;

  FreeDataAfterGenTexture := false;

  SizeRec.Fields := [ffX, ffY];
  SizeRec.X := Size;
  SizeRec.Y := Size;

  // Positive X
  Rec.Func := glBitmapNormalMapPosX;
  LoadFromFunc(SizeRec, glBitmapNormalMapFunc, ifBGR8, @Rec);
  GenerateCubeMap(GL_TEXTURE_CUBE_MAP_POSITIVE_X, TestTextureSize);

  // Negative X
  Rec.Func := glBitmapNormalMapNegX;
  LoadFromFunc(SizeRec, glBitmapNormalMapFunc, ifBGR8, @Rec);
  GenerateCubeMap(GL_TEXTURE_CUBE_MAP_NEGATIVE_X, TestTextureSize);

  // Positive Y
  Rec.Func := glBitmapNormalMapPosY;
  LoadFromFunc(SizeRec, glBitmapNormalMapFunc, ifBGR8, @Rec);
  GenerateCubeMap(GL_TEXTURE_CUBE_MAP_POSITIVE_Y, TestTextureSize);

  // Negative Y
  Rec.Func := glBitmapNormalMapNegY;
  LoadFromFunc(SizeRec, glBitmapNormalMapFunc, ifBGR8, @Rec);
  GenerateCubeMap(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y, TestTextureSize);

  // Positive Z
  Rec.Func := glBitmapNormalMapPosZ;
  LoadFromFunc(SizeRec, glBitmapNormalMapFunc, ifBGR8, @Rec);
  GenerateCubeMap(GL_TEXTURE_CUBE_MAP_POSITIVE_Z, TestTextureSize);

  // Negative Z
  Rec.Func := glBitmapNormalMapNegZ;
  LoadFromFunc(SizeRec, glBitmapNormalMapFunc, ifBGR8, @Rec);
  GenerateCubeMap(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z, TestTextureSize);
end;

initialization

glBitmapSetDefaultFormat(tfDefault);
glBitmapSetDefaultFilter(GL_LINEAR_MIPMAP_LINEAR, GL_LINEAR);
glBitmapSetDefaultWrap(GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE);

glBitmapSetDefaultFreeDataAfterGenTexture(True);
glBitmapSetDefaultDeleteTextureOnFree(True);

finalization

end.
