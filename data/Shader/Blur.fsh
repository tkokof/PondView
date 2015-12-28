// Shader taken from: http://webglsamples.googlecode.com/hg/electricflower/electricflower.html

#ifdef GL_ES
precision lowp float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

uniform sampler2D CC_Texture0;

uniform vec2 blurSize;

void main() {
	vec4 sum = vec4(0.0);
	/*
	sum += texture2D(CC_Texture0, v_texCoord - 4.0 * blurSize) * 0.05;
	sum += texture2D(CC_Texture0, v_texCoord - 3.0 * blurSize) * 0.09;
	sum += texture2D(CC_Texture0, v_texCoord - 2.0 * blurSize) * 0.12;
	sum += texture2D(CC_Texture0, v_texCoord - 1.0 * blurSize) * 0.15;
	sum += texture2D(CC_Texture0, v_texCoord                 ) * 0.16;
	sum += texture2D(CC_Texture0, v_texCoord + 1.0 * blurSize) * 0.15;
	sum += texture2D(CC_Texture0, v_texCoord + 2.0 * blurSize) * 0.12;
	sum += texture2D(CC_Texture0, v_texCoord + 3.0 * blurSize) * 0.09;
	sum += texture2D(CC_Texture0, v_texCoord + 4.0 * blurSize) * 0.05;

	gl_FragColor = sum * v_fragmentColor;
	*/
	sum += texture2D(CC_Texture0, vec2(v_texCoord.x - 4.0 * blurSize.x, v_texCoord.y)) * 0.05;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x - 3.0*blurSize.x, v_texCoord.y)) * 0.09;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x - 2.0*blurSize.x, v_texCoord.y)) * 0.12;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x - blurSize.x, v_texCoord.y)) * 0.15;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y)) * 0.16;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x + blurSize.x, v_texCoord.y)) * 0.15;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x + 2.0*blurSize.x, v_texCoord.y)) * 0.12;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x + 3.0*blurSize.x, v_texCoord.y)) * 0.09;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x + 4.0*blurSize.x, v_texCoord.y)) * 0.05;
	
	sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 4.0*blurSize.y)) * 0.05;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 3.0*blurSize.y)) * 0.09;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 2.0*blurSize.y)) * 0.12;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - blurSize.y)) * 0.15;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y)) * 0.16;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + blurSize.y)) * 0.15;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 2.0*blurSize.y)) * 0.12;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 3.0*blurSize.y)) * 0.09;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 4.0*blurSize.y)) * 0.05;
	
	gl_FragColor = sum * 0.5 * v_fragmentColor;
}

