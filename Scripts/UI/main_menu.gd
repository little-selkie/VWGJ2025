extends Control

var bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")

func _on_start_button_pressed() -> void:
	GlobalVars.reload()
	get_tree().change_scene_to_file("res://Scenes/City/CityPlayable.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_mute_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(bus, true)
	if !toggled_on:
		AudioServer.set_bus_mute(bus, false)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, value)


func _on_sfx_slider_drag_started() -> void:
	$SampleAudio.play()


func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	$SampleAudio.stop()
