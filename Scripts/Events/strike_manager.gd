extends Node

var choosen_target: Node
var time_until_impact: int = 0
var choosen_target_name: String = "None"

var rng = RandomNumberGenerator.new()
var random_time: int = 0
@export var min_strike_time: int = 10
@export var max_strike_time: int = 100
@export var strike_period_timer: float = 15.0

func _enter_tree() -> void:
	$StrikeTimer.wait_time = 60

func _ready() -> void:
	$TimeSimulation.wait_time = GlobalVars.time_simulation
	#$Control/VBoxContainer/WarningMessage.visible = false
	$HUDMessages/WarningMessage.visible = false
	$HUDMessages/WarningMessageTop.visible = false
	$HUDMessages/AllClear.visible = true

func _process(_delta: float) -> void:
	if GlobalVars.everything_is_broken:
		$Control/VBoxContainer/DebugStrike.disabled = true
		$Control/VBoxContainer/DebugStrike.text = str("you are already fucked lol")
	elif !GlobalVars.everything_is_broken:
		$Control/VBoxContainer/DebugStrike.disabled = false
		$Control/VBoxContainer/DebugStrike.text = str("[Debug] Random Strike")
	if GlobalVars.protection == 100:
		$StrikeTimer.stop()

func _on_time_simulation_timeout() -> void:
	time_until_impact -= 1
	#$Control/VBoxContainer/WarningMessage/MinuteCount.text = str(time_until_impact)
	$HUDMessages/WarningMessage.text = str(choosen_target_name) + " will be hit in " + str(time_until_impact) + " minutes!"
	if time_until_impact == 0:
		strike()
		$HUDMessages/WarningMessage.visible = false
		$HUDMessages/WarningMessageTop.visible = false
		$HUDMessages/AllClear.visible = true
		#$Control/VBoxContainer/WarningMessage.visible = false
	elif time_until_impact > 0:
		$TimeSimulation.start()

func strike_init() -> void:
	choose_target()
	random_time = rng.randi_range(min_strike_time, max_strike_time)
	time_until_impact = random_time
	$TimeSimulation.start()
	warning_sys()

func warning_sys() -> void:
	#$Control/VBoxContainer/WarningMessage/MinuteCount.text = str(time_until_impact)
	#$Control/VBoxContainer/WarningMessage.visible = true
	$HUDMessages/WarningMessage.text = str(choosen_target_name) + " will be hit in " + str(time_until_impact) + " minutes!"
	$HUDMessages/AllClear.visible = false
	$HUDMessages/WarningMessage.visible = true
	$HUDMessages/WarningMessageTop.visible = true
	$Sounds/Siren.play()

func choose_target() -> void:
	var random_target_id = rng.randi_range(0, get_parent().find_child("Districts").get_child_count() - 1)
	choosen_target = get_parent().find_child("Districts").get_child(random_target_id)
	if choosen_target.is_broken:
		choose_target()
	elif !choosen_target.is_broken:
		choosen_target_name = str(choosen_target.district_name)

func strike() -> void:
	choosen_target.is_broken = true
	GlobalVars.resource_people_health[1] -= (choosen_target.people_working_here - choosen_target.people_working_here*choosen_target.shelter_protection)
	check_if_everything_is_broken()
	$Sounds/Explosion.volume_db = randf_range(-10, 0)
	$Sounds/Explosion.pitch_scale = randf_range(0.7, 1.1)
	$Sounds/Explosion.play()

func check_if_everything_is_broken() -> void:
	GlobalVars.everything_is_broken = true
	for i in range(0, get_parent().find_child("Districts").get_child_count()):
		if !get_parent().find_child("Districts").get_child(i).is_broken:
			GlobalVars.everything_is_broken = false

func _on_debug_strike_pressed() -> void:
	strike_init()


func _on_strike_timer_timeout() -> void:
	$StrikeTimer.wait_time = strike_period_timer + (float(GlobalVars.protection)/100 * strike_period_timer)
	if GlobalVars.everything_is_broken or !$TimeSimulation.is_stopped():
		pass
	elif !GlobalVars.everything_is_broken:
		strike_init()
