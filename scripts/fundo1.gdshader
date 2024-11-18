shader_type canvas_item;

uniform float speed = 0.0;
uniform float offset = 0.0; // Controla o deslocamento manual

void fragment() {
	vec2 newuv = UV;
	newuv.x += offset; // Usa o deslocamento acumulado
	vec4 c = texture(TEXTURE, newuv);
	COLOR = c;
}
