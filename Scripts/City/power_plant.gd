extends Control

@export var district_name: String = "Test"
@export_range(0, 100, 1) var gives_energy: int = 10

@export var is_on: bool = true

@export_group("Strikes")
@export var is_broken: bool = false
@export var fix_cost: int = 100
@export var fix_speed: float = 0.1

func _process(_delta: float) -> void:
	if is_broken:
		broken()

func _ready():
	$Panel.visible = false
	$Panel/Fixing/FixTickTimer.wait_time = fix_speed
	$VBoxContainer/DistrictName.text = str(district_name)
	$VBoxContainer/HBoxContainer/EnergyCount.text = str(gives_energy)

func _on_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		is_on = true
		GlobalVars.resource_power[1] += gives_energy
	if !toggled_on:
		is_on = false
		GlobalVars.resource_power[1] -= gives_energy

func broken() -> void:
	$On_Off/Check.button_pressed = false
	is_on = false
	$Panel/HBoxContainer/FixCost.text = str(fix_cost)
	$Panel.visible = true
	if $Panel/Fixing/FixTickTimer.is_stopped():
		$Panel/BrokenLabel.visible = true
		$Panel/HBoxContainer.visible = true
		$Panel/Fixing.visible = false

func _on_debug_brake_pressed() -> void:
	is_broken = true
	#if is_on:
		#GlobalVars.resource_power[1] -= gives_energy

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
	$Panel/Fixing/ProgressBar.value = 0

func _on_fix_tick_timer_timeout() -> void:
	$Panel/Fixing/ProgressBar.value += $Panel/Fixing/ProgressBar.step
	if $Panel/Fixing/ProgressBar.value >= 100:
		fix()
	elif $Panel/Fixing/ProgressBar.value <= 100:
		$Panel/Fixing/FixTickTimer.start()
