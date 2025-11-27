extends OmniLight3D

var target := 1.0

func _process(delta):
	# smooth blend toward target
	light_energy = lerp(light_energy, target, delta * 25.0)

	# when close, choose a new target
	if abs(light_energy - target) < 0.02:
		target = randf_range(0.2, 1.0)
