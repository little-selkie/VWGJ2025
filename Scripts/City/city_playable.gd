extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hideAllDistricts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _hideAllDistricts():
	$Districts/PowerPlant.visible = false
	$Districts/HeatingDistrict.visible = false
	$Districts/TechnologyDistrict.visible = false
	$Districts/EntertainmentDistrict.visible = false
	$Districts/ParkDistrict.visible = false
	$Districts/CivilianDistrict.visible = false
	$Districts/HospitalDistrict.visible = false
	$Districts/GovernmentDistrict.visible = false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var cam = $Camera3D
		var from = cam.project_ray_origin(event.position)
		var to = from + cam.project_ray_normal(event.position) * 200000

		var space = $Camera3D.get_world_3d().direct_space_state
		var hit = space.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
		
		
		if hit:
			_hideAllDistricts()
			match hit.collider.name:
				"Area_PowerPlant":
					$Districts/PowerPlant.visible = true
				"Area_Heating":
					$Districts/HeatingDistrict.visible = true
				"Area_Lab":
					$Districts/TechnologyDistrict.visible = true
				"Area_Entertainment":
					$Districts/EntertainmentDistrict.visible = true
				"Area_Park":
					$Districts/ParkDistrict.visible = true
				"Area_Civ":
					$Districts/CivilianDistrict.visible = true
				"Area_Hospital":
					$Districts/HospitalDistrict.visible = true
				"Area_Government":
					$Districts/GovernmentDistrict.visible = true
