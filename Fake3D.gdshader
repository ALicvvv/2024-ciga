shader_type canvas_item;

uniform float FOV: hint_range(1,179) = 90;
uniform float y_rot: hint_range(-360,360) = 0.0;
uniform float x_rot: hint_range(-360,360) = 0.0;
uniform bool call_back = true;

varying vec3 camera_position;
varying vec2 offset;

void vertex() {
	float sin_b = sin(y_rot / 180.0 * PI);
	float cos_b = cos(y_rot / 180.0 * PI);
	float sin_c = sin(x_rot / 180.0 * PI);
	float cos_c = cos(x_rot / 180.0 * PI);
	mat3 inv_rot_mat_y = mat3(
		vec3(cos_b, 0.0, -sin_b),
		vec3(0.0, 1.0, 0.0),
		vec3(sin_b, 0.0, cos_b)
	);
	mat3 inv_rot_mat_x = mat3(
		vec3(1.0, 0.0, 0.0),
		vec3(0.0, cos_c, sin_c),
		vec3(0.0, -sin_c, cos_c)
	);
	mat3 inv_rot_mat = inv_rot_mat_x * inv_rot_mat_y;
	float t = tan(FOV/ 360.0 * PI);
	camera_position = inv_rot_mat * vec3(UV - 0.5, 0.5 / t);
	float v = (0.5/t) + 0.5;
	camera_position.xy *= inv_rot_mat[2].z;
	offset = inv_rot_mat[2].xy;
	
	VERTEX += (UV - 0.5) / TEXTURE_PIXEL_SIZE * t;
}

void fragment() {
	if (call_back && camera_position.z <= 0.0) discard;
	vec2 uv = (camera_position.xy / camera_position.z).xy - offset;
	COLOR = texture(TEXTURE, uv + 0.5);
	COLOR.a *= step(max(abs(uv.x),abs(uv.y)),0.5);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
