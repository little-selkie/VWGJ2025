shader_type spatial;
render_mode blend_add, cull_back, depth_draw_always;

uniform float min_h = 0.0;
uniform float max_h = 0.25;

void fragment() {
    vec3 n = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    if (dot(n, vec3(0.0, 1.0, 0.0)) > 0.4) discard; // kill top faces

    float y = ((INV_VIEW_MATRIX * vec4(VERTEX,1.0)).y - min_h) / (max_h - min_h);
    float t = clamp(y, 0.0, 1.0);

    ALBEDO = vec3(t);
    EMISSION = vec3(t);
    ALPHA = 1.0 - t;
}