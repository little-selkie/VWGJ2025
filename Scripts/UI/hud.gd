extends CanvasLayer

var bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")


func _ready() -> void:
	$PauseMenu.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("PauseMenu"):
		if $PauseMenu.visible:
			$PauseMenu.visible = false
		elif !$PauseMenu.visible:
			$PauseMenu.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	$PauseMenu.visible = false

func _on_pause_menu_draw() -> void:
	get_tree().paused = true

func _on_pause_menu_hidden() -> void:
	get_tree().paused = false


func _on_mute_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(bus, true)
		$PauseMenu/MuteButton.icon = load("res://Icons/Additional/Sound_Off_Icon.png")
	if !toggled_on:
		AudioServer.set_bus_mute(bus, false)
		$PauseMenu/MuteButton.icon = load("res://Icons/Additional/Sound_On_Icon.png")

func _on_start_button_pressed() -> void:
	GlobalVars.reload()
	get_tree().change_scene_to_file("res://Scenes/City/CityPlayable.tscn")


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, value)


func _on_sfx_slider_drag_started() -> void:
	$PauseMenu/SampleAudio.play()


func _on_sfx_slider_drag_ended(_value_changed: bool) -> void:
	$PauseMenu/SampleAudio.stop()


func _on_button_pressed() -> void:
	$PauseMenu.visible = true
