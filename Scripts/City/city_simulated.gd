extends Node

func _enter_tree() -> void:
	$TimeIncome.wait_time = GlobalVars.income_time
	$TimeSimulation.wait_time = GlobalVars.time_simulation

func _ready():
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
	elif GlobalVars.current_time[1] == 6:
		GlobalVars.time_of_day = "Day"
	time_update_hud()
	heating()
	mood_swing()
	health_boost_at_home()
	win_lose_listener()

func time_update_hud() -> void:
	$Hud/Time/HBoxContainer/DayNumber.text = str(GlobalVars.current_time[0])
	$Hud/Time/HBoxContainer/HourNumber.text = str(GlobalVars.current_time[1])
	$Hud/Time/HBoxContainer/MinuteNumber.text = str(GlobalVars.current_time[2])
	$Hud/Time/TimeOfDay.text = GlobalVars.time_of_day
	$Hud/People/VBoxContainer/MentalHealthProgress.value = float(GlobalVars.resource_people_mood[1])
	$Hud/People/VBoxContainer/HealthProgress.value = float(GlobalVars.resource_people_health[1])
	
	$Hud/Resources/ResourceTable/Energy/EnergyCount.text = str(GlobalVars.resource_power[1])
	$Hud/Resources/ResourceTable/Money/MoneyCount.text = str(GlobalVars.resource_money[1])
	$Hud/Resources/ResourceTable/Heating/HeatingCount.text = str(int(GlobalVars.resource_heat[1]))
	$Hud/Resources/ResourceTable/UpgradeParts/UpgradePartsCount.text = str(GlobalVars.resource_upgrade[1])
	
	$Hud/Resources/ResourceTable/Energy/EnergyIcon.texture = GlobalVars.resource_power[2]
	$Hud/Resources/ResourceTable/Money/MoneyIcon.texture = GlobalVars.resource_money[2]
	$Hud/Resources/ResourceTable/Heating/HeatingIcon.texture = GlobalVars.resource_heat[2]
	$Hud/Resources/ResourceTable/UpgradeParts/UpgradePartsIcon.texture = GlobalVars.resource_upgrade[2]
	
	$Hud/PassiveIncome/IncomeCount.text = str(int((GlobalVars.resource_people_mood[1] + -20) * GlobalVars.passive_money_income))
	$Hud/PassiveIncome/IcomeTime.text = str(int(GlobalVars.income_time/GlobalVars.time_simulation))
	if int($Hud/PassiveIncome/IncomeCount.text) < 0:
		$Hud/PassiveIncome/IncomeCount.self_modulate = Color(1.0, 0.357, 0.29, 1.0)
	else:
		$Hud/PassiveIncome/IncomeCount.self_modulate = Color(0.216, 0.773, 0.478, 1.0)
	
	$Hud/People/VBoxContainer/TextureProgressBar.value = GlobalVars.protection
	$Hud/People/VBoxContainer/TextureProgressBar.tooltip_text = str(GlobalVars.protection) + "%"
	
	$Hud/GlobalEfficiency/EfficiencyCount.text = str(int(GlobalVars.resource_people_health[1] + 50)) + "%"
	if int($Hud/GlobalEfficiency/EfficiencyCount.text) < 100:
		$Hud/GlobalEfficiency/EfficiencyCount.self_modulate = Color(1.0, 0.357, 0.29, 1.0)
	else:
		$Hud/GlobalEfficiency/EfficiencyCount.self_modulate = Color(0.216, 0.773, 0.478, 1.0)

func heating() -> void:
	GlobalVars.resource_heat[1] -= GlobalVars.heat_consumption
	if GlobalVars.resource_heat[1] <= 0:
		GlobalVars.resource_heat[1] = 0
		GlobalVars.resource_people_health[1] -= GlobalVars.health_depletion
		if GlobalVars.resource_people_health[1] <= 0:
			GlobalVars.resource_people_health[1] = 0

func mood_swing() -> void:
	if GlobalVars.civilians_unhappy:
		GlobalVars.resource_people_mood[1] -= GlobalVars.mental_mood_depletion
	if GlobalVars.resource_people_mood[1] <= 0:
		GlobalVars.resource_people_mood[1] = 0
	elif GlobalVars.resource_people_mood[1] >= 100:
		GlobalVars.resource_people_mood[1] = 100

func generate_money() -> void:
	GlobalVars.resource_money[1] += int((GlobalVars.resource_people_mood[1] + -20) * GlobalVars.passive_money_income)

func health_boost_at_home() -> void:
	GlobalVars.resource_people_health[1] += GlobalVars.constant_health_boost
	if GlobalVars.resource_people_health[1] >= 100:
		GlobalVars.resource_people_health[1] = 100
	elif GlobalVars.resource_people_health[1] <= 0:
		GlobalVars.resource_people_health[1] = 0

func _on_time_income_timeout() -> void:
	generate_money()

func win_lose_listener() -> void:
	if GlobalVars.protection >= 100 and !GlobalVars.endless_mode:
		GlobalVars.lose = false
		$Hud/WinPopUp.visible = true
	elif GlobalVars.resource_money[1] < 0 and !GlobalVars.second_chance and !GlobalVars.endless_mode:
		GlobalVars.lose = true
		$Hud/WinPopUp.visible = true
	elif GlobalVars.resource_money[1] < 0 and GlobalVars.second_chance and !GlobalVars.endless_mode:
		var RandomEventManager = get_parent().find_child("RandomEventManager")
		RandomEventManager.find_child("EventTimer").stop()
		RandomEventManager.special_events[0][3].call()
		get_tree().paused = true
