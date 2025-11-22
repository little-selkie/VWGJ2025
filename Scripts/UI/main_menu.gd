extends Control


func _on_start_button_pressed() -> void:
	GlobalVars.reload()
	get_tree().change_scene_to_file("res://Scenes/City/CityPlayable.tscn")
