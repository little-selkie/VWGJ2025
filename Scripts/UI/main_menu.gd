extends Control

var bus = AudioServer.get_bus_index("Master")

func _on_start_button_pressed() -> void:
	GlobalVars.reload()
	get_tree().change_scene_to_file("res://Scenes/City/CityPlayable.tscn")


func _on_mute_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(bus, true)
	if !toggled_on:
		AudioServer.set_bus_mute(bus, false)
