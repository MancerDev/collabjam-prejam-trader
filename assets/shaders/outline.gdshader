shader_type canvas_item;

uniform vec4 outline_color : source_color;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec2 size = TEXTURE_PIXEL_SIZE;
	
	float alpha = 0.0;
	alpha += texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(0, size.y)).a;
	alpha += texture(TEXTURE, UV + vec2(0, -size.y)).a;
	alpha = min(alpha, 1.0);

	COLOR = mix(color, outline_color, alpha - color.a);
}