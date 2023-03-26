shader_type canvas_item;
 
uniform sampler2D tint_map;
uniform float tint_level = 0.2f;
varying vec2 world_pos;
 
void vertex() {
    world_pos = VERTEX.xy;
}
 
void fragment() {
    COLOR = mix(texture(TEXTURE, UV), texture(TEXTURE, UV) * texture(tint_map, world_pos / vec2(textureSize(tint_map, 0))), tint_level);
}