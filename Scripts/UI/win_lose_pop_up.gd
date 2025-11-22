extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_draw() -> void:
	if !GlobalVars.lose:
		$BGPanel/Panel/VBoxContainer/Header.text = "You Win"
		$BGPanel/Panel/VBoxContainer/Context.text = "You managed to fully protect your city. You may continue in endless mode if you wish."
		$BGPanel/Panel/VBoxContainer/Buttons/FirstButton.text = "Endless Mode"
	elif GlobalVars.lose:
		$BGPanel/Panel/VBoxContainer/Header.text = "You Lose"
		$BGPanel/Panel/VBoxContainer/Context.text = "You have to money and no means to protect your city. Do you wish to try again?"
		$BGPanel/Panel/VBoxContainer/Buttons/FirstButton.text = "Try Again"


func _on_first_button_pressed() -> void:
	if !GlobalVars.lose:
		$".".visible = false
		GlobalVars.endless_mode = true
	elif GlobalVars.lose:
		GlobalVars.reload()
		get_tree().reload_current_scene()
