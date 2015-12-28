#ifdef GL_ES
precision mediump float;
#endif
 
varying vec4 v_fragmentColor; 
varying vec2 v_texCoord;

uniform sampler2D CC_Texture0;
uniform sampler2D u_waterTexture;

uniform float u_time;
uniform float u_waveFactor;
uniform vec2 u_waveCenter;

void main()
{
    //vec2 p = -1.0 + 2.0 * v_texCoord;
    vec2 p = (v_texCoord - u_waveCenter) * 2.0;
    float lenSq = p.x * p.x + p.y * p.y;
	float waterValue = texture2D(u_waterTexture, vec2(u_time, lenSq * 0.5)).x;
	waterValue = -1.0 + 2.0 * waterValue; // convert value to -1 ~ 1
	waterValue *= u_waveFactor;
    
	vec2 normal = normalize(p);
    vec2 uv = v_texCoord + normal * waterValue;
    
	gl_FragColor = texture2D(CC_Texture0, uv) * v_fragmentColor;
}