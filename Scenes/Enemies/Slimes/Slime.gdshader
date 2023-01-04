shader_type canvas_item;

uniform vec4 flashColor : source_color;
uniform float flashState : hint_range(0,1) = 0;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	pixelColor.rgb = mix(pixelColor.rgb, flashColor.rgb, flashState);
	COLOR = pixelColor;
}
