shader_type spatial;
render_mode vertex_lighting, world_vertex_coords;
uniform vec4 albedo : hint_color = vec4(1.0);
uniform float point_scale = 0.1;

void vertex() {
	// sRGB
	if (!OUTPUT_IS_SRGB) {
		COLOR.rgb = mix(pow((COLOR.rgb + vec3(0.055)) * (1.0 / (1.0 + 0.055)), vec3(2.4)), COLOR.rgb* (1.0 / 12.92), lessThan(COLOR.rgb,vec3(0.04045)));
	}
	// Point size adjustment using camera position
	float dist = distance((CAMERA_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xyz, VERTEX); //Getting distance between camera and the vertices
	POINT_SIZE = (point_scale / dist) * min(VIEWPORT_SIZE.x, VIEWPORT_SIZE.y) / 2.0; //Adjust point size
	NORMAL = VERTEX - WORLD_MATRIX[3].xyz; //Create normals for lighting
}

void fragment() {
	// use vertex color as albedo
	ALBEDO = COLOR.rgb * albedo.rgb;
}