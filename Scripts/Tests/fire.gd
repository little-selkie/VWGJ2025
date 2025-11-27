extends MeshInstance3D

func _ready():
	_flicker()

func _flicker():
	# random yaw (0–360)
	rotation_degrees.y = randf() * 360.0

	# uniform random scale (0.8–1.2)
	var s = randf_range(0.8, 1.2)
	scale = Vector3(s, s, s)

	# wait 0.5–1.5 seconds then repeat
	var wait_time = randf_range(0.2, 0.8)
	await get_tree().create_timer(wait_time).timeout
	_flicker()
