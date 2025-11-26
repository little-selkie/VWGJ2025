extends Node

@onready var cam := $Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hideAllDistricts()
	_hideAllDistrictBorders()

func _traceMousePos(pos: Vector2) -> Dictionary:
	var from = cam.project_ray_origin(pos)
	var to = from + cam.project_ray_normal(pos) * 200000
	var space = $Camera3D.get_world_3d().direct_space_state
	return space.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))


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
		var hit = _traceMousePos(event.position)
		
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


func _hideAllDistrictBorders():
	$DistrictBorderUX/Border_Power.visible = false
	$DistrictBorderUX/Border_Heat.visible = false
	$DistrictBorderUX/Border_Lab.visible = false
	$DistrictBorderUX/Border_Enter.visible = false
	$DistrictBorderUX/Border_Park.visible = false
	$DistrictBorderUX/Border_Civ.visible = false
	$DistrictBorderUX/Border_Hospital.visible = false
	$DistrictBorderUX/Border_Gov.visible = false

func _process(_delta: float) -> void:
	var hit = _traceMousePos(get_viewport().get_mouse_position())
	if hit:
		_hideAllDistrictBorders()
		match hit.collider.name:
				"Area_PowerPlant":
					$DistrictBorderUX/Border_Power.visible = true
				"Area_Heating":
					$DistrictBorderUX/Border_Heat.visible = true
				"Area_Lab":
					$DistrictBorderUX/Border_Lab.visible = true
				"Area_Entertainment":
					$DistrictBorderUX/Border_Enter.visible = true
				"Area_Park":
					$DistrictBorderUX/Border_Park.visible = true
				"Area_Civ":
					$DistrictBorderUX/Border_Civ.visible = true
				"Area_Hospital":
					$DistrictBorderUX/Border_Hospital.visible = true
				"Area_Government":
					$DistrictBorderUX/Border_Gov.visible = true
