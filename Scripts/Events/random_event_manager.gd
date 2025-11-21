extends Node

@export var min_event_timer: float = 1.0
@export var max_event_timer: float = 2.0

var rng = RandomNumberGenerator.new()
var random_number: int = 0
var random_time: float = 1.0

# Events
# 0 - header, 1 - description, 2 - confim message, 3 - event function, 4 - event type
var random_events: Array[Array] = [
	["Ay caramba...", "-100 грошей", "ok :(", caramba_event, "type"],
	["We are not sure what happened...", "...but nothing seem to change", "uh ok?", nothing_happens, "type"]
]

var government_events: Array[Array] = [
	["Test government event", "government", "government", nothing_happens, "type"],
	["Test government event 2", "government", "government", nothing_happens, "type"],
	["Test government event 3", "government", "government", nothing_happens, "type"]
]

var government_events_upgrade_1: Array[Array] = [
	["Test government event", "government", "government", nothing_happens, "type"],
	["Test government event 2", "government", "government", nothing_happens, "type"],
	["Test government event 3", "government", "government", nothing_happens, "type"]
]

var government_events_upgrade_2: Array[Array] = [
	["Test government event", "government", "government", nothing_happens, "type"],
	["Test government event 2", "government", "government", nothing_happens, "type"],
	["Test government event 3", "government", "government", nothing_happens, "type"]
]

func _ready() -> void:
	for i in range(0, random_events.size()):
		random_events[i][4] = "Common"
	for i in range(0, government_events.size()):
		government_events[i][4] = "Government"

func _enter_tree() -> void:
	set_random_time()
	$Control.visible = false

func _on_event_timer_timeout() -> void:
	random_number = rng.randi_range(0, random_events.size() - 1)
	random_events[random_number][3].call()
	$Control/Panel/VBoxContainer/HeaderText.text = str(random_events[random_number][0])
	$Control/Panel/VBoxContainer/DescriptionText.text = str(random_events[random_number][1])
	$Control/Panel/VBoxContainer/ConfirmButton.text = str(random_events[random_number][2])
	$Control.visible = true

# Event functions
func caramba_event() -> void:
	GlobalVars.resource_money[1] -= 100

func nothing_happens() -> void:
	print(" ")


func _on_confirm_button_button_up() -> void:
	$Control.visible = false
	set_random_time()
	$EventTimer.start()

func set_random_time() -> void:
	random_time = rng.randf_range(min_event_timer, max_event_timer)
	$EventTimer.wait_time = random_time
