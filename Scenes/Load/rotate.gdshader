shader_type canvas_item;
render_mode unshaded, blend_disabled;

uniform float speed = 1.0;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + vec2(20);
}

void vertex() {
    VERTEX = rotateUV(VERTEX, vec2(TEXTURE_PIXEL_SIZE*0.5), TIME * speed);
}