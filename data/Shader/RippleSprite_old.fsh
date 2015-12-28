#ifdef GL_ES
precision mediump float;
#endif

// max ripple count
const int MAX_RIPPLE_SIMUL_COUNT = 8;

uniform sampler2D CC_Texture0;
uniform vec2 u_ripple[MAX_RIPPLE_SIMUL_COUNT];
uniform float u_time[MAX_RIPPLE_SIMUL_COUNT];
uniform float u_strength[MAX_RIPPLE_SIMUL_COUNT];

varying vec4 v_fragmentColor; 
varying vec2 v_texCoord;

// TODO: make uniform
const float frequency = 48.0;
const float phase = 1.0;
const float timeFactor = 0.3;
const float falloffFactor = 1.5;
const float lightFactor = 4.0;

// calc new ripple uv
vec3 waveUV(vec2 waveCenter, vec2 pos, float time, float strength)
{
    vec2 uv = pos;	
    vec2 toPixel = uv - waveCenter; // vector from center to pixel
    float distance = length(toPixel);
    vec2 direction = toPixel / distance;
    //float angle = atan(direction.y, direction.x);
    
    //float value = frequency * distance + time * phase;
	float value = (frequency * distance + phase) * time * timeFactor;
    vec2 wave = vec2(sin(value), cos(value));
    
    float falloff = clamp(1.0 - distance, 0.0, 1.0);
    //falloff *= falloff;
	falloff = pow(falloff, 1.0 / pow(time, falloffFactor));
	
	// calc new uv
    wave *= falloff;
    distance += strength * wave.x;
    vec2 uv2 = waveCenter + distance * direction;
	
	// fake lighting
	// TODO: make better
	//float lighting = clamp(wave.y * 0.2 + 0.8, 0.0, 1.0);
	float lighting = mix(1.0, 1.0 + wave.x * lightFactor, clamp(strength, 0.0, 1.0));
   
    return vec3(uv2.x, uv2.y, lighting);
}

void main()
{
   vec3 uv = vec3(v_texCoord.x, v_texCoord.y, 1.0);
   for (int i = 0; i < MAX_RIPPLE_SIMUL_COUNT; ++i)
   {
       if (u_strength[i] <= 0.0) break;
       vec3 tempUV = waveUV(u_ripple[i], v_texCoord, u_time[i], u_strength[i]);
       uv = (uv + tempUV) * 0.5;
   }
   
   gl_FragColor = texture2D(CC_Texture0, uv.xy) * v_fragmentColor * uv.z;
   gl_FragColor.a = 1.0; // NOTE: reason see below
   // a little tricky to do debug ...
   /*
   if (texture2D(CC_Texture0, uv.xy).a <= 0.75 ||
       texture2D(CC_Texture0, uv.xy).a > 0.8) // texture.a should be around 0.765
   {
       // should not happen
       gl_FragColor = vec4(0.0);
   }
   */
   /*
       when render to RenderTexture, the RenderTexture's alpha is also calculated using blend func, e.g.
	   src_alpha = 0.5
       dst_alpha = 1.0
       result_alpha = src_alpha * src_alpha + dst_alpha * (1 - dst_alpha) = 0.5 * 0.5 + 1.0 * 0.5 = 0.75
	   as above shows that the result is not 1.0, so there will has blend effect when using this texture, like draw it to another texture
   */
}