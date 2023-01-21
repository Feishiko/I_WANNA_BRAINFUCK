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

uniform float iTime;

float random(vec2 _st){
    return fract(sin(dot(_st.xy, vec2(8.1223, 12.876)))*56178.212);
}

float noise(vec2 _st){
    vec2 f = fract(_st*5.);
    vec2 id = floor(_st*5.);
    
    f = f*f*(3.0 - 2.0*f);//smoothstep
    
    float lb = random(id);
    float rb = random(id + vec2(1., 0.));
    float b = mix(lb, rb, f.x);
    
    float lt = random(id + vec2(0., 1.));
    float rt = random(id + vec2(1., 1.));
    float t = mix(lt, rt, f.x);
    
    return mix(b, t, f.y);
}

void main()
{
    vec2 uv = v_vTexcoord;
    
    uv += vec2(iTime/10.0, iTime/5.0);
    uv /= 4.0;
    
    float c = noise(uv*4.0);
    
    c += noise(uv * 8.0)*.5;
    c += noise(uv * 16.0)*.25;
    c += noise(uv * 32.0)*.125;
    c += noise(uv * 65.0)*.0625;
    
    c /= 2.;
    
    // Time varying pixel color
    vec3 col = vec3(c);
    
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord + col.r/50.);

    tex.rgb *= vec3(1., .55, .35);

    vec3 noisepoint = vec3(random(v_vTexcoord*100. + iTime/100.));
    
    noisepoint = smoothstep(0., .2, noisepoint);
    
    tex.rgb *= noisepoint;    

    gl_FragColor = tex;
}

