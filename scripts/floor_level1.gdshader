shader_type canvas_item;

uniform float speed = 0.5;

void fragment() {
	vec2 newuv = UV;
	newuv.x += TIME * speed;
	vec4 c = texture(TEXTURE, newuv);
	COLOR = c;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
