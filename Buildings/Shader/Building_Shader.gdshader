shader_type spatial;

uniform sampler2D building_tex;
uniform bool Power_Enabled = true;

void fragment() {
	ALBEDO = texture(building_tex, UV).rgb * (Power_Enabled ? vec3(1.0, 0.8, 0.8) : vec3(0.0, 0.02, 0.05));
}