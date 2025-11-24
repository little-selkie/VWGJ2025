extends CanvasLayer

var bus = AudioServer.get_bus_index("Master")

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
	if !toggled_on:
		AudioServer.set_bus_mute(bus, false)
