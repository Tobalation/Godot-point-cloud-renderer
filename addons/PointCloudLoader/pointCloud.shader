shader_type spatial;
render_mode vertex_lighting;
uniform vec4 albedo : hint_color = vec4(1.0);
uniform float point_scale = 100.0;

void vertex() {
	// sRGB
	if (!OUTPUT_IS_SRGB) {
		COLOR.rgb = mix(pow((COLOR.rgb + vec3(0.055)) * (1.0 / (1.0 + 0.055)), vec3(2.4)), COLOR.rgb* (1.0 / 12.92), lessThan(COLOR.rgb,vec3(0.04045)));
	}
	// Point size adjustment using camera position
	vec3 camVec = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float dist = length(camVec); //Getting distance between camera and the vertices
	POINT_SIZE = point_scale / dist; //Adjust point size
	NORMAL = VERTEX - WORLD_MATRIX[3].xyz; //Create normals for lighting
}

void fragment() {
	// use vertex color as albedo
	ALBEDO = COLOR.rgb * albedo.rgb;
}