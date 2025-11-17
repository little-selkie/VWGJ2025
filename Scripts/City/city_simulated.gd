extends Node

func _ready():
	$TimeSimulation.wait_time = GlobalVars.time_simulation
	time_update_hud()

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
	$Hud/People/VBoxContainer/MentalHealthProgress.value = float(GlobalVars.resource_people_mood[1])
	$Hud/People/VBoxContainer/HealthProgress.value = float(GlobalVars.resource_people_health[1])
	
	$Hud/Resources/ResourceTable/Energy/EnergyCount.text = str(GlobalVars.resource_power[1])
	$Hud/Resources/ResourceTable/Money/MoneyCount.text = str(GlobalVars.resource_money[1])
	$Hud/Resources/ResourceTable/Heating/HeatingCount.text = str(GlobalVars.resource_heat[1])
	$Hud/Resources/ResourceTable/UpgradeParts/UpgradePartsCount.text = str(GlobalVars.resource_upgrade[1])
