//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;

void main()
{
    vec2 uv = v_vTexcoord;
    //gl_FragColor = v_vColour * ;
    float radius = 0.0;
    float angle = 0.0;
    vec2 toCenter = vec2(.5) - uv;
    radius = distance(vec2(.5), uv);
    angle = atan(toCenter.y, toCenter.x);
    vec4 tex = texture2D( gm_BaseTexture, vec2(radius, angle) );
    gl_FragColor = tex;
}

