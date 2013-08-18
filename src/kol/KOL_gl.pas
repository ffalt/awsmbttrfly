unit KOL_gl;

interface

uses
  WinApi.Windows,
  WinApi.OpenGL;

const
  GL_TRUE = 1;
  GL_FALSE = 0;

  GL_TEXTURE_RECTANGLE_ARB = $84F5;
  GL_MIRRORED_REPEAT = $8370;

  // Wrapmodes
  GL_TEXTURE_WRAP_S = $2802;
  GL_TEXTURE_WRAP_T = $2803;
  GL_CLAMP = $2900;
  GL_REPEAT = $2901;
  GL_CLAMP_TO_EDGE = $812F;
  GL_CLAMP_TO_BORDER = $812D;
  GL_TEXTURE_WRAP_R = $8072;

  // Cubemaps
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = $851C;
  GL_TEXTURE_CUBE_MAP = $8513;
  GL_TEXTURE_BINDING_CUBE_MAP = $8514;
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = $8515;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $8516;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $8517;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518;
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $8519;
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A;

  // Dataformats
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  GL_UNSIGNED_SHORT_5_6_5_REV = $8364;
  GL_UNSIGNED_SHORT_4_4_4_4_REV = $8365;
  GL_UNSIGNED_SHORT_1_5_5_5_REV = $8366;
  GL_UNSIGNED_INT_2_10_10_10_REV = $8368;

  // GL_SGIS_generate_mipmap
  GL_GENERATE_MIPMAP = $8191;

  // GL_EXT_texture_compression_s3tc
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT = $83F0;
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = $83F1;
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = $83F2;
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = $83F3;

  // GL_EXT_texture_filter_anisotropic
  GL_TEXTURE_MAX_ANISOTROPY_EXT = $84FE;
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF;

  // Textureformats
  GL_RGB = $1907;
  GL_RGB4 = $804F;
  GL_RGB8 = $8051;
  GL_RGBA = $1908;
  GL_RGBA4 = $8056;
  GL_RGBA8 = $8058;
  GL_BGR = $80E0;
  GL_BGRA = $80E1;
  GL_ALPHA4 = $803B;
  GL_ALPHA8 = $803C;
  GL_LUMINANCE4 = $803F;
  GL_LUMINANCE8 = $8040;
  GL_LUMINANCE4_ALPHA4 = $8043;
  GL_LUMINANCE8_ALPHA8 = $8045;
  GL_DEPTH_COMPONENT = $1902;

  // GL_ARB_texture_compression
  GL_COMPRESSED_RGB = $84ED;
  GL_COMPRESSED_RGBA = $84EE;
  GL_COMPRESSED_ALPHA = $84E9;
  GL_COMPRESSED_LUMINANCE = $84EA;
  GL_COMPRESSED_LUMINANCE_ALPHA = $84EB;

  // Texgen
  GL_NORMAL_MAP = $8511;
  GL_REFLECTION_MAP = $8512;
  GL_S = $2000;
  GL_T = $2001;
  GL_R = $2002;
  GL_TEXTURE_GEN_MODE = $2500;
  GL_TEXTURE_GEN_S = $0C60;
  GL_TEXTURE_GEN_T = $0C61;
  GL_TEXTURE_GEN_R = $0C62;

  GL_TEXTURE_1D = $0DE0;
  GL_TEXTURE_2D = $0DE1;

  GL_TEXTURE_WIDTH = $1000;
  GL_TEXTURE_HEIGHT = $1001;
  GL_TEXTURE_INTERNAL_FORMAT = $1003;
  GL_TEXTURE_RED_SIZE = $805C;
  GL_TEXTURE_GREEN_SIZE = $805D;
  GL_TEXTURE_BLUE_SIZE = $805E;
  GL_TEXTURE_ALPHA_SIZE = $805F;
  GL_TEXTURE_LUMINANCE_SIZE = $8060;

type
  TV4f = array [0 .. 3] of single;

type
  PByteBool = ^ByteBool;

procedure glDeleteTextures(n: Integer; textures: PGLuint); stdcall; external WinApi.Windows.OpenGL32;
procedure glBindTexture(Target: GLenum; texture: GLuint); stdcall; external OpenGL32;
procedure glGenTextures(n: Integer; textures: PCardinal); stdcall; external OpenGL32;
function glAreTexturesResident(n: Integer; const textures: PCardinal; residences: PByteBool): ByteBool; stdcall; external OpenGL32;
function v4f(x, y, Z, W: single): TV4f;
procedure glDebugBorder(const AWidth, AHeight: single);

implementation

function v4f(x, y, Z, W: single): TV4f;
begin
  Result[0] := x;
  Result[1] := y;
  Result[2] := Z;
  Result[3] := W;
end;


procedure glDebugBorder(const AWidth, AHeight: single);
var
  Color: TV4f;
  Lz,Size:single;
begin
  Lz:=1;
  Size:=AWidth;
  Color := V4f(0, 1, 0, 1);
  glColor4fv(@Color);

  glDisable(GL_TEXTURE_2D);
  glBegin(GL_LINE_STRIP);
  glVertex3f(-Size, Size, -Lz); // Top
  glVertex3f(Size, Size, -Lz);
  glVertex3f(Size, Size, Lz);
  glVertex3f(-Size, Size, Lz);
  glVertex3f(-Size, Size, -Lz);

  glVertex3f(-Size, -Size, -Lz); // toBottom

  glVertex3f(Size, -Size, -Lz); // Bottom
  glVertex3f(Size, -Size, Lz);
  glVertex3f(-Size, -Size, Lz);
  glVertex3f(-Size, -Size, -Lz);
  glEnd();

  glBegin(GL_LINES);
  glVertex3f(-Size, Size, Lz);
  glVertex3f(-Size, -Size, Lz);
  glEnd();

  glBegin(GL_LINES);
  glVertex3f(Size, Size, Lz);
  glVertex3f(Size, -Size, Lz);
  glEnd();

  glBegin(GL_LINES);
  glVertex3f(Size, Size, -Lz);
  glVertex3f(Size, -Size, -Lz);
  glEnd();

  glEnable(GL_TEXTURE_2D);
end;

end.
