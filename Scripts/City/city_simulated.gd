extends Node


func _on_time_simulation_timeout() -> void:
	if GlobalVars.current_time[2] == 59:
		if GlobalVars.current_time[1] == 23:
			GlobalVars.current_time[0] += 1
			GlobalVars.current_time[1] = 0
			GlobalVars.current_time[2] = 0
		else:
			GlobalVars.current_time[1] += 1
			GlobalVars.current_time[2] = 0
	else:
		GlobalVars.current_time[2] += 1
	
	if GlobalVars.current_time[1] == 23:
		GlobalVars.time_of_day = "Night"
	elif GlobalVars.current_time[1] == 5:
		GlobalVars.time_of_day = "Day"
	time_update_hud()

func time_update_hud() -> void:
	$Hud/Time/HBoxContainer/DayNumber.text = str(GlobalVars.current_time[0])
	$Hud/Time/HBoxContainer/HourNumber.text = str(GlobalVars.current_time[1])
	$Hud/Time/HBoxContainer/MinuteNumber.text = str(GlobalVars.current_time[2])
	$Hud/Time/TimeOfDay.text = GlobalVars.time_of_day
