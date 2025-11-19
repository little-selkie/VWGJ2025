extends Node

@export var event_timer: float = 1.0

var rng = RandomNumberGenerator.new()
var random_number: int = 0

# Events
# 0 - header, 1 - description, 2 - confim message, 3 - event function
var random_events: Array[Array] = [
	["Ay caramba...", "-100 грошей", "ok :(", caramba_event],
	["We are not sure what happened...", "...but nothing seem to change", "uh ok?", nothing_happens]
]

func _enter_tree() -> void:
	$EventTimer.wait_time = event_timer
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
	$EventTimer.start()
