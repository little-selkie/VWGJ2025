extends Control


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_draw() -> void:
	if !GlobalVars.lose:
		$Sounds/Win.play()
		$BGPanel/Panel/VBoxContainer/Header.text = "You Win!"
		$BGPanel/Panel/VBoxContainer/Context.text = "You managed to fully protect your city. No more destruction and pain, your people may finally rest and get back to their normal lives. \r\n You may continue in Endless Mode with no air strike threats."
		$BGPanel/Panel/VBoxContainer/Buttons/FirstButton.text = "Endless Mode"
	elif GlobalVars.lose:
		$Sounds/Lose.play()
		$BGPanel/Panel/VBoxContainer/Header.text = "You Lose."
		$BGPanel/Panel/VBoxContainer/Context.text = "You have no money and no means to protect your city. \r\n Do you wish to try again?"
		$BGPanel/Panel/VBoxContainer/Buttons/FirstButton.text = "Try Again"
	get_tree().paused = true


func _on_first_button_pressed() -> void:
	get_tree().paused = false
	if !GlobalVars.lose:
		$".".visible = false
		GlobalVars.endless_mode = true
	elif GlobalVars.lose:
		GlobalVars.reload()
		get_tree().reload_current_scene()
