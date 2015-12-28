#ifdef GL_ES
precision lowp float;
#endif

uniform sampler2D CC_Texture0;
uniform float u_grayFactor;
uniform int u_colorGradation;

varying vec4 v_fragmentColor; 
varying vec2 v_texCoord;

void main()
{
    // now we get op color
    vec4 texColor = texture2D(CC_Texture0, v_texCoord);
    texColor *= v_fragmentColor;
   
   if (u_grayFactor > 0.0)
   {
		// do gray op
		float targetColor = 0.3 * texColor.r + 0.59 * texColor.g + 0.11 * texColor.b;
		// here we do color gradation mapping
		float colorInterval = 255.0 / float(u_colorGradation);
		int targetColorInt = int(float(int(targetColor * 255.0 / colorInterval)) * colorInterval);
		targetColor = float(targetColorInt) / 255.0;
		
		float grayFactor = u_grayFactor;
		grayFactor = clamp(grayFactor, 0.0, 1.0);
	   
		// calc lerp color value
		// TODO: optimize ?
		vec3 lerpColor = mix(texColor.rgb, vec3(targetColor), grayFactor);
		texColor.rgb = lerpColor;
		/*
		float lerpR = mix(texColor.r, targetColor, grayFactor);
		float lerpG = mix(texColor.g, targetColor, grayFactor);
		float lerpB = mix(texColor.b, targetColor, grayFactor);
		float lerpA = texColor.a;
		*/
	}
   
    // set frag color
    gl_FragColor = texColor;
}