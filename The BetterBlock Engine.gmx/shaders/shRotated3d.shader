//
// Simple passthrough vertex shader
//
const float PI = 3.1415;

attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float xrotate;
uniform float yrotate;
uniform float zrotate;
uniform float u_time;

mat3 rotate3d(vec3 _angle) {
    return mat3(cos(_angle.x)*cos(_angle.z) + sin(_angle.x)*sin(_angle.y)*sin(_angle.z), -cos(_angle.x)*sin(_angle.z) + sin(_angle.x)*sin(_angle.y)*cos(_angle.z), sin(_angle.x)*cos(_angle.y),
                sin(_angle.z)*cos(_angle.y), cos(_angle.z)*cos(_angle.y), -sin(_angle.y),
                -sin(_angle.x)*cos(_angle.z) + cos(_angle.x)*sin(_angle.y)*sin(_angle.z), sin(_angle.z)*sin(_angle.x) + cos(_angle.x)*sin(_angle.y)*cos(_angle.z), cos(_angle.x)*cos(_angle.y));
}

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);

    object_space_pos = vec4(rotate3d(vec3(u_time/100., u_time/100., 0.)) * object_space_pos.xyz, 1.);

    //object_space_pos.xy += vec2(400., 304.);

    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

    v_vTexcoord = in_TextureCoord;
    v_vColour = in_Colour;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}

