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
const float PI = 3.1415;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float hp;

void main()
{
    vec2 uv = v_vTexcoord;
    uv *= 5.3;
    uv -= vec2(.32);
    vec2 toCenter = vec2(.5) - uv;
    float angle = atan(toCenter.y, toCenter.x);
    float radius = length(toCenter)*2.0;
    vec3 col = vec3(0.);
    //float hp = 100.;
    
    vec3 gray = vec3(step(radius, .5)) - vec3(step(radius, .475));
    
    //vec3 gray = vec3(step(abs(0.495-radius), .01));
    
    col += gray * vec3(.3);
    
    if(angle <= PI - ((100. - hp)/50.)*PI) {
        col += gray*vec3(.8, .1, .1);
    }
    
    if(col == vec3(0.)) {
        discard;
    }
    
    gl_FragColor = vec4(col,1.0);
}

