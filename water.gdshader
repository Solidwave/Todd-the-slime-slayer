shader_type canvas_item;

uniform float amplitude = 0.1;
uniform float frequency = 5.0;
uniform float speed = 1.0;
uniform vec2 direction = vec2(1.0, 0.0);
uniform vec4 color = vec4(0.3, 0.6, 0.9, 1.0);

void fragment() {
    vec2 uv = SCREEN_UV * direction;
    float noise = sin((uv.y + TIME * speed) * frequency) * amplitude;
    vec4 water_color = color * (1.0 - noise);
    COLOR = water_color;
}