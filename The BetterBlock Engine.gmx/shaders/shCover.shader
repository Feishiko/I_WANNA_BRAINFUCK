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
uniform sampler2D u_texture;

void main()
{
    vec2 uv = v_vTexcoord;
    vec4 texture = texture2D(u_texture, uv/2.0 - vec2(u_time/100.0));
    vec3 col = 0.5 + 0.5*cos(u_time/10.0 + uv.xyx + vec3(0.0, 2.0, 4.0));
    vec4 coll = vec4(col, 1.0);
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, uv );
    vec4 title = texture2D( gm_BaseTexture, uv );
    gl_FragColor = vec4(1.0, 1.0, 1.0, title.a)*coll;
}

