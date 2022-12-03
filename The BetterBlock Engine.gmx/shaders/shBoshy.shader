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

float noise(vec2 _st){
    return fract(sin(dot(vec2(12.4124, 8.321), _st))*31233.323);
}

void main()
{
    vec3 col = vec3(noise(v_vTexcoord.xx + u_time))/2.;

    vec4 tex = texture2D( gm_BaseTexture, v_vTexcoord + col.r/50.);    


    gl_FragColor = v_vColour * tex * .6;//* vec4(col, 1.)
}

