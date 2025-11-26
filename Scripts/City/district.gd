extends Control

@export var district_name: String = "Test"
@export_range(0, 10, 1) var needs_energy: int = 1

@export var is_on: bool = true
@export var can_work_at_night: bool = false
@export_range(0, 100, 5) var efficiency: int = 100

@export_group("Production")
@export var production_timer: float = GlobalVars.time_simulation
enum producesEnum {None, MentalHealth, Health, Money, Heat, UpgradeParts}
@export var produces_1: producesEnum
@export_range(0, 100, 1) var produces_1_count: int = 0
@export var produces_2: producesEnum
@export_range(0, 100, 1) var produces_2_count: int = 0
@export var produces_3: producesEnum
@export_range(0, 100, 1) var produces_3_count: int = 0
@export var produces_4: producesEnum
@export_range(0, 100, 1) var produces_4_count: int = 0

@export_group("Strikes")
@export var is_broken: bool = false
@export var fix_cost: int = 100
@export var fix_speed: float = 0.5

@export var people_working_here: int = 10
var shelter_protection: float = 0

var random_event_manager: Node

func _process(_delta: float) -> void:
	work()
	check_for_energy()
	if is_broken:
		broken()
	update_info()
	
	efficiency = int(GlobalVars.resource_people_health[1] + 50)

func _ready():
	shader_change(is_on)
	if is_on:
		$On_Off/Check.button_pressed = true
	elif !is_on:
		$On_Off/Check.button_pressed = false
	$ProductionProgress.value = 0.0
	update_info()
	$ProductionTick.wait_time = production_timer
	$Panel.visible = false
	$Panel/Fixing/FixTickTimer.wait_time = fix_speed
	random_event_manager = get_parent().get_parent().find_child("RandomEventManager")

func update_info():
	set_icons()
	if produces_1 == 0 and produces_2 == 0 and produces_3 == 0 and produces_4 == 0:
		$ProductionProgress.visible = false
	if is_on and (GlobalVars.resource_power[1] - needs_energy) >= 0:
		$On_Off/Check.button_pressed = true
	elif !is_on:
		$On_Off/Check.button_pressed = false
	$VBoxContainer/Details/EnergyCost.text = str(needs_energy)
	$VBoxContainer/DistrictName.text = str(district_name)
	if produces_1 != 0:
		$VBoxContainer/Details/Production/Product_1/ProductCount.text = str(produces_1_count)
		$VBoxContainer/Details/Production/Product_1/ProductImage.tooltip_text = str(producesEnum.keys()[produces_1])
		$VBoxContainer/Details/Production/Product_1.visible = true
	else:
		$VBoxContainer/Details/Production/Product_1.visible = false
	if produces_2 != 0:
		$VBoxContainer/Details/Production/Product_2/ProductCount.text = str(produces_2_count)
		$VBoxContainer/Details/Production/Product_2/ProductImage.tooltip_text = str(producesEnum.keys()[produces_2])
		$VBoxContainer/Details/Production/Product_2.visible = true
	else:
		$VBoxContainer/Details/Production/Product_2.visible = false
	if produces_3 != 0:
		$VBoxContainer/Details/Production/Product_3/ProductCount.text = str(produces_3_count)
		$VBoxContainer/Details/Production/Product_3/ProductImage.tooltip_text = str(producesEnum.keys()[produces_3])
		$VBoxContainer/Details/Production/Product_3.visible = true
	else:
		$VBoxContainer/Details/Production/Product_3.visible = false
	if produces_4 != 0:
		$VBoxContainer/Details/Production/Product_4/ProductCount.text = str(produces_4_count)
		$VBoxContainer/Details/Production/Product_4/ProductImage.tooltip_text = str(producesEnum.keys()[produces_4])
		$VBoxContainer/Details/Production/Product_4.visible = true
	else:
		$VBoxContainer/Details/Production/Product_4.visible = false

func check_for_energy():
	if needs_energy > GlobalVars.resource_power[1] and !$On_Off/Check.button_pressed:
		$On_Off/Check.disabled = true
	elif needs_energy <= GlobalVars.resource_power[1] and !$On_Off/Check.button_pressed:
		$On_Off/Check.disabled = false
	
	if GlobalVars.resource_power[1] < 0:
		$On_Off/Check.button_pressed = false
		$On_Off/Check.disabled = true

func work():
	if !is_on:
		$ProductionTick.stop()
	elif !can_work_at_night and GlobalVars.time_of_day == "Night":
		$ProductionTick.stop()
	elif $ProductionTick.is_stopped():
		$ProductionTick.start()

func check_for_production():
	if is_on:
		#MentalHealth
		if produces_1 == 1:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_mood[1] += int(produces_1_count*(float(efficiency)/100))
		elif produces_2 == 1:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_mood[1] += int(produces_2_count*(float(efficiency)/100))
		elif produces_3 == 1:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_mood[1] += int(produces_3_count*(float(efficiency)/100))
		elif produces_4 == 1:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_mood[1] += int(produces_4_count*(float(efficiency)/100))
		#Health
		if produces_1 == 2:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_health[1] += int(produces_1_count*(float(efficiency)/100))
		elif produces_2 == 2:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_health[1] += int(produces_2_count*(float(efficiency)/100))
		elif produces_3 == 2:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_health[1] += int(produces_3_count*(float(efficiency)/100))
		elif produces_4 == 2:
			@warning_ignore("integer_division")
			GlobalVars.resource_people_health[1] += int(produces_4_count*(float(efficiency)/100))
		#Money
		if produces_1 == 3:
			@warning_ignore("integer_division")
			GlobalVars.resource_money[1] += int(produces_1_count*(float(efficiency)/100))
		elif produces_2 == 3:
			@warning_ignore("integer_division")
			GlobalVars.resource_money[1] += int(produces_2_count*(float(efficiency)/100))
		elif produces_3 == 3:
			@warning_ignore("integer_division")
			GlobalVars.resource_money[1] += int(produces_3_count*(float(efficiency)/100))
		elif produces_4 == 3:
			@warning_ignore("integer_division")
			GlobalVars.resource_money[1] += int(produces_4_count*(float(efficiency)/100))
		#Heat
		if produces_1 == 4:
			@warning_ignore("integer_division")
			GlobalVars.resource_heat[1] += int(produces_1_count*(float(efficiency)/100))
		elif produces_2 == 4:
			@warning_ignore("integer_division")
			GlobalVars.resource_heat[1] += int(produces_2_count*(float(efficiency)/100))
		elif produces_3 == 4:
			@warning_ignore("integer_division")
			GlobalVars.resource_heat[1] += int(produces_3_count*(float(efficiency)/100))
		elif produces_4 == 4:
			@warning_ignore("integer_division")
			GlobalVars.resource_heat[1] += int(produces_4_count*(float(efficiency)/100))
		#UpgradeParts
		if produces_1 == 5:
			@warning_ignore("integer_division")
			GlobalVars.resource_upgrade[1] += int(produces_1_count*(float(efficiency)/100))
		elif produces_2 == 5:
			@warning_ignore("integer_division")
			GlobalVars.resource_upgrade[1] += int(produces_2_count*(float(efficiency)/100))
		elif produces_3 == 5:
			@warning_ignore("integer_division")
			GlobalVars.resource_upgrade[1] += int(produces_3_count*(float(efficiency)/100))
		elif produces_4 == 5:
			@warning_ignore("integer_division")
			GlobalVars.resource_upgrade[1] += int(produces_4_count*(float(efficiency)/100))
			
	#MentalHealth
	if GlobalVars.resource_people_mood[1] > 100:
		GlobalVars.resource_people_mood[1] = 100
	#Health
	if GlobalVars.resource_people_health[1] > 100:
		GlobalVars.resource_people_health[1] = 100

func set_icons():
	#MentalHealth
	if produces_1 == 1:
		$VBoxContainer/Details/Production/Product_1/ProductImage.texture = GlobalVars.resource_people_mood[2]
	elif produces_2 == 1:
		$VBoxContainer/Details/Production/Product_2/ProductImage.texture = GlobalVars.resource_people_mood[2]
	#Health
	if produces_1 == 2:
		$VBoxContainer/Details/Production/Product_1/ProductImage.texture = GlobalVars.resource_people_health[2]
	elif produces_2 == 2:
		$VBoxContainer/Details/Production/Product_2/ProductImage.texture = GlobalVars.resource_people_health[2]
	#Money
	if produces_1 == 3:
		$VBoxContainer/Details/Production/Product_1/ProductImage.texture = GlobalVars.resource_money[2]
	elif produces_2 == 3:
		$VBoxContainer/Details/Production/Product_2/ProductImage.texture = GlobalVars.resource_money[2]
	#Heat
	if produces_1 == 4:
		$VBoxContainer/Details/Production/Product_1/ProductImage.texture = GlobalVars.resource_heat[2]
	elif produces_2 == 4:
		$VBoxContainer/Details/Production/Product_2/ProductImage.texture = GlobalVars.resource_heat[2]
	#UpgradeParts
	if produces_1 == 5:
		$VBoxContainer/Details/Production/Product_1/ProductImage.texture = GlobalVars.resource_upgrade[2]
	elif produces_2 == 5:
		$VBoxContainer/Details/Production/Product_1/ProductImage.texture = GlobalVars.resource_upgrade[2]

func _on_production_tick_timeout() -> void:
	$ProductionProgress.value += $ProductionProgress.step


func _on_production_progress_value_changed(value: float) -> void:
	if value >= 100:
		$ProductionProgress.value = 0.0
		check_for_production()


func _on_check_toggled(toggled_on: bool) -> void:
	$Check.play()
	if toggled_on:
		is_on = true
		shader_change(is_on)
		GlobalVars.resource_power[1] -= needs_energy
	if !toggled_on:
		is_on = false
		shader_change(is_on)
		GlobalVars.resource_power[1] += needs_energy
	civillian_building_check()
	government_building_check()

func civillian_building_check() -> void:
	if district_name == "Civilian Building":
		if is_on:
			GlobalVars.civilians_unhappy = false
		elif !is_on:
			GlobalVars.civilians_unhappy = true

func government_building_check() -> void:
	if district_name == "Government":
		if is_on:
			random_event_manager.random_events.append_array(random_event_manager.government_events)
			print(random_event_manager.random_events)
		elif !is_on:
			for i in range(0, random_event_manager.random_events.size()):
				remove_from_2d_array(random_event_manager.random_events, "Government")
			print(random_event_manager.random_events)

func remove_from_2d_array(array, type: String) -> void:
	for i in range(0, array.size()):
		if array[i][4] == type:
			array.remove_at(i)
			break

func broken() -> void:
	$On_Off/Check.button_pressed = false
	is_on = false
	civillian_building_check()
	$Panel/HBoxContainer/FixCost.text = str(fix_cost)
	$Panel.visible = true
	if $Panel/Fixing/FixTickTimer.is_stopped():
		$Panel/BrokenLabel.visible = true
		$Panel/HBoxContainer.visible = true
		$Panel/Fixing.visible = false

func shader_change(are_lights_on: bool) -> void:
	if district_name == "Hospital":
		GlobalVars.buildings_shader.set_shader_parameter("Hospital_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Hospital_enabled", are_lights_on)
	elif district_name == "Entertainment":
		GlobalVars.buildings_shader.set_shader_parameter("Entertainment_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Entertainment_enabled", are_lights_on)
	elif district_name == "Park":
		GlobalVars.buildings_shader.set_shader_parameter("Park_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Park_enabled", are_lights_on)
	elif district_name == "Civilian Building":
		GlobalVars.buildings_shader.set_shader_parameter("Civ_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Civ_enabled", are_lights_on)
	elif district_name == "Heating":
		GlobalVars.buildings_shader.set_shader_parameter("Heat_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Heat_enabled", are_lights_on)
	elif district_name == "Government":
		GlobalVars.buildings_shader.set_shader_parameter("Government_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Government_enabled", are_lights_on)
	elif district_name == "Laboratory":
		GlobalVars.buildings_shader.set_shader_parameter("Lab_enabled", are_lights_on)
		GlobalVars.road_shader.set_shader_parameter("Lab_enabled", are_lights_on)

func _on_debug_brake_pressed() -> void:
	is_broken = true
	#if is_on:
		#GlobalVars.resource_power[1] += needs_energy


func _on_fix_button_pressed() -> void:
	if GlobalVars.resource_money[1] - fix_cost >= 0:
		GlobalVars.resource_money[1] -= fix_cost
		$Panel/Fixing/FixTickTimer.start()
		$Panel/Fixing.visible = true
		$Panel/HBoxContainer.visible = false
		$Panel/BrokenLabel.visible = false

func fix() -> void:
	$Panel.visible = false
	is_broken = false
	GlobalVars.everything_is_broken = false
	$Panel/Fixing/ProgressBar.value = 0

func _on_fix_tick_timer_timeout() -> void:
	$Panel/Fixing/ProgressBar.value += $Panel/Fixing/ProgressBar.step
	if $Panel/Fixing/ProgressBar.value >= 100:
		fix()
	elif $Panel/Fixing/ProgressBar.value <= 100:
		$Panel/Fixing/FixTickTimer.start()
