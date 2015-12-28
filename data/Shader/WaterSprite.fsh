#ifdef GL_ES
//precision mediump float;
precision highp float;
#endif
 
varying vec4 v_fragmentColor; 
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
uniform float u_time;
uniform float u_waveFactor;
uniform vec2 u_waveCenter;

void main()
{
    //vec2 p = -1.0 + 2.0 * v_texCoord;
    vec2 p = (v_texCoord - u_waveCenter) * 2.0;
    float len = length(p);
    vec2 normal = normalize(p);
    float waterValue = cos(u_time * 4.0 - len * 12.0) * u_waveFactor;
    vec2 uv = v_texCoord + normal * waterValue;
    gl_FragColor = texture2D(CC_Texture0, uv) * v_fragmentColor;
}