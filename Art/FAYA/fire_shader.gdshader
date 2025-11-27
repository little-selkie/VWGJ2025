shader_type spatial;
render_mode cull_back;

uniform vec3 color_a = vec3(1.0, 0.181, 0.041);
uniform vec3 color_b = vec3(1.0, 0.554, 0.040);
uniform vec3 center_offset = vec3(20.0, 0.0, 60.0);
uniform float radius = 120.0;
uniform float hardness = 30.0;
uniform float rough = 0.3;
uniform float emissive_mul = 2.0;

uniform float min_brightness = 0.1;
uniform float max_brightness = 0.5;
uniform float speed = 8.0; // lower = smoother
uniform float seed = 1.0;

float rand(float x) {
	return fract(sin(x * 12.9898 + seed * 78.233) * 43758.5453);
}

void fragment() {
    vec3 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    vec3 pivot = (MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
    vec3 center = pivot + center_offset;

    float dist = length(world_pos - center);
    float mask = clamp((radius - dist) / hardness, 0.0, 1.0);

    vec3 col = mix(color_b, color_a, mask);

	float t = TIME * speed;

    float a = floor(t);
    float b = a + 1.0;

    float ra = rand(a);
    float rb = rand(b);

    float f = fract(t);
    float s = mix(ra, rb, smoothstep(0.0, 1.0, f));

    float bright = mix(min_brightness, max_brightness, s);


    ALBEDO = col;
    ROUGHNESS = rough;
    EMISSION = col * emissive_mul * bright;
}