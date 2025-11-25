shader_type spatial;
render_mode cull_back;

uniform sampler2D road_tex;
uniform sampler2D masks_tex;
uniform sampler2D light_tex;
uniform float light_tiling = 800.0;
uniform vec3 light_colour = vec3(1.0, 0.337, 0.164);
uniform float emissive_power = 4.0;
uniform bool Power_enabled = true;
uniform bool Entertainment_enabled = true;
uniform bool Lab_enabled = true;
uniform bool Heat_enabled = true;
uniform bool Government_enabled = true;
uniform bool Park_enabled = true;
uniform bool Hospital_enabled = true;
uniform bool Civ_enabled = true;

float get_region_mask(vec2 uv) {
    // Sample grayscale value from the mask texture
    float tex = texture(masks_tex, uv).r;

    const float err = 0.02; // tolerance for filtering / compression

    float mask = 0.0;

    if (Power_enabled && abs(tex - 1.0) < err) mask = 1.0;
    if (Entertainment_enabled && abs(tex - 0.8902) < err) mask = 1.0;
    if (Lab_enabled && abs(tex - 0.7804) < err) mask = 1.0;
    if (Heat_enabled && abs(tex - 0.6706) < err) mask = 1.0;
    if (Government_enabled && abs(tex - 0.5608) < err) mask = 1.0;
    if (Park_enabled && abs(tex - 0.4510) < err) mask = 1.0;
    if (Hospital_enabled && abs(tex - 0.3412) < err) mask = 1.0;
    if (Civ_enabled && abs(tex - 0.2314) < err) mask = 1.0;

    return mask;
}

void fragment() {
	float region_mask = get_region_mask(UV);

	ALBEDO = texture(road_tex, UV).rgb * 0.072;
	EMISSION = texture(road_tex, UV).rgb * light_colour * texture(light_tex, UV * vec2(light_tiling, light_tiling)).rgb * emissive_power * region_mask;
}
