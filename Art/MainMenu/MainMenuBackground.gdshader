shader_type canvas_item;

uniform sampler2D back_tex;
uniform float min_brightness = 0.8;
uniform float max_brightness = 1.0;
uniform float speed = 8.0; // lower = smoother
uniform float seed = 1.0;

float rand(float x) {
	return fract(sin(x * 12.9898 + seed * 78.233) * 43758.5453);
}

void fragment() {
    float t = TIME * speed;

    float a = floor(t);
    float b = a + 1.0;

    float ra = rand(a);
    float rb = rand(b);

    float f = fract(t);
    float s = mix(ra, rb, smoothstep(0.0, 1.0, f));

    float bright = mix(min_brightness, max_brightness, s);

    vec4 col = texture(back_tex, UV);
    COLOR = vec4(col.rgb * bright, col.a);
}