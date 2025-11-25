shader_type spatial;
render_mode cull_back;

uniform sampler2D window_tex;
uniform sampler2D masks_tex;
uniform float windows_tiling_u = 128.0;
uniform float windows_tiling_v = 256.0;
uniform float emission_strength = 1.0;
uniform vec3 window_colour = vec3(1.0, 0.337, 0.164);
uniform bool Power_enabled = true;
uniform bool Entertainment_enabled = true;
uniform bool Lab_enabled = true;
uniform bool Heat_enabled = true;
uniform bool Government_enabled = true;
uniform bool Park_enabled = true;
uniform bool Hospital_enabled = true;
uniform bool Civ_enabled = true;

float get_region_mask(float g) {
    const float err = 0.02; // tolerance for filtering / compression

    float mask = 0.0;

    if (Power_enabled && abs(g - 1.0) < err) mask = 1.0;
    if (Entertainment_enabled && abs(g - 0.704) < err) mask = 1.0;
    if (Lab_enabled && abs(g - 0.523) < err) mask = 1.0;
    if (Heat_enabled && abs(g - 0.373) < err) mask = 1.0;
    if (Government_enabled && abs(g - 0.252) < err) mask = 1.0;
    if (Park_enabled && abs(g - 0.157) < err) mask = 1.0;
    if (Hospital_enabled && abs(g - 0.087) < err) mask = 1.0;
    if (Civ_enabled && abs(g - 0.04) < err) mask = 1.0;

    return mask;
}

void fragment() {
	float region_mask = get_region_mask(COLOR.g);
	
    vec2 tiled_uv = UV * vec2(windows_tiling_u, windows_tiling_v);
    vec3 window_emissive = texture(window_tex, tiled_uv).rgb * window_colour;

    float height_mask = 1.0 - COLOR.b;

    vec3 normal_world = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);

    float up_dot = clamp(dot(normal_world, vec3(0.0, 1.0, 0.0)), 0.0, 1.0);

    float wall_mask = 1.0 - up_dot;

    float mask = height_mask * wall_mask;

    ALBEDO = vec3(0.016, 0.016, 0.016);
    EMISSION = window_emissive * mask * emission_strength * region_mask;
}