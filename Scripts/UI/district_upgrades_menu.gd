extends Control

# 0 - title, 1 - icon, 2 - description, 3 - function, 4 - type, 5 - cost in money, 6 - cost in technology
var all_district_upgrades: Array[Array]

var hospital_upgrades: Array[Array] = [
	["Night Shifts", load("res://Icons/Upgrades/Overtime.png"), "Unlocks working during night hours", night_shift, "Type", 10, 10],
	["More Health production", load("res://Icons/Upgrades/Physical_Health_+.png"), "Will generate 25% more health", more_production, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var entertainment_upgrades: Array[Array] = [
	["More Entertainment", load("res://Icons/Upgrades/Entertainment_.png"), "Will generate 25% more entertainment", more_production, "Type", 10, 10],
	["More Mental Health", load("res://Icons/Upgrades/Mental_Health_+.png"), "Will generate 50% more mental health", more_mental_health_production, "Type", 10, 10],
	["More Money", load("res://Icons/Upgrades/Money_+.png"), "Will generate 100% more money", more_money_production, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var park_upgrades: Array[Array] = [
	["More Mental Health production", load("res://Icons/Upgrades/Mental_Health_+.png"), "Will generate +25% more mental health", more_production, "Type", 10, 10],
	["More Mental Health production", load("res://Icons/Upgrades/Mental_Health_++.png"), "Will generate +25% more mental health", more_production, "Type", 10, 10],
	["Even More Mental Health production", load("res://Icons/Upgrades/Mental_Health_++.png"), "Will generate +25% more mental health", more_production, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var civilian_upgrades: Array[Array] = [
	["More energy per day", load("res://Icons/Upgrades/Electricity.png"), "Less mental health depletion when off, but needs more energy to function", less_mental_health_depletion, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var heating_upgrades: Array[Array] = [
	["Night Shifts", load("res://Icons/Upgrades/Overtime.png"), "Unlocks working during night hours", night_shift, "Type", 10, 10],
	["More Heating production", load("res://Icons/Upgrades/Heating_+.png"), "Will generate 25% more heating", more_production, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var government_upgrades: Array[Array] = [
	["Diplomacy I", load("res://Icons/Upgrades/Diplomacy_1.png"), "Adds more Diplomacy events", diplomacy_level_one, "Type", 10, 10],
	["Diplomacy II", load("res://Icons/Upgrades/Diplomacy_2.png"), "Adds even more Diplomacy events", diplomacy_level_two, "Type", 10, 10],
	["Night Shifts", load("res://Icons/Upgrades/Overtime.png"), "Unlocks working during night hours", night_shift, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var laboratory_upgrades: Array[Array] = [
	["Night Shifts", load("res://Icons/Upgrades/Overtime.png"), "Unlocks working during night hours", night_shift, "Type", 10, 10],
	["More Technology production", load("res://Icons/Upgrades/Tech_+.png"), "Will generate +25% more technology", more_production, "Type", 10, 10],
	["Even more Technology production", load("res://Icons/Upgrades/Tech_+.png"), "Will generate +25% more technology", more_production, "Type", 10, 10],
	["Autonomy", load("res://Icons/Upgrades/Autonomy.png"), "Needs less energy to function", autonomy, "Type", 10, 10],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]
var power_upgrades: Array[Array] = [
	["Solar Panels", load("res://Icons/Upgrades/Solar_Panels.png"), "Gives Extra 3 Energy during the Day", solar_panels, "Type", 10, 4],
	["Solar Panels+", load("res://Icons/Upgrades/Solar_Panels.png"), "Gives additional Extra 3 Energy during the Day", solar_panels, "Type", 10, 4],
	["Top Specialists", load("res://Icons/Upgrades/Specialist_.png"), "25% Cheaper to repair", cheaper_repairs, "Type", 10, 10],
	["Top Specialists+", load("res://Icons/Upgrades/Specialist_+.png"), "25% Faster to repair", faster_repairs, "Type", 10, 10],
	["Basic Shelter", load("res://Icons/Upgrades/Shelter.png"), "Will protect 25% of People Health upon Strike", shelters, "Type", 10, 10],
	["Advanced Shelter", load("res://Icons/Upgrades/Shelter_2.png"), "Will protect 75% of People Health upon Strike", shelters, "Type", 10, 10]
]

var current_upgrades: Array[Array]

var current_district: String
var current_money_cost: int = 999999
var current_technology_cost: int = 99999
var upgrade_selected: int

var random_event_manager

func init_all_arrays() -> void:
	for i in range(0, hospital_upgrades.size()):
		hospital_upgrades[i][4] = "Hospital"
	for i in range(0, entertainment_upgrades.size()):
		entertainment_upgrades[i][4] = "Entertainment"
	for i in range(0, park_upgrades.size()):
		park_upgrades[i][4] = "Park"
	for i in range(0, civilian_upgrades.size()):
		civilian_upgrades[i][4] = "Civilian Building"
	for i in range(0, heating_upgrades.size()):
		heating_upgrades[i][4] = "Heating"
	for i in range(0, government_upgrades.size()):
		government_upgrades[i][4] = "Government"
	for i in range(0, laboratory_upgrades.size()):
		laboratory_upgrades[i][4] = "Laboratory"
	for i in range(0, power_upgrades.size()):
		power_upgrades[i][4] = "Power Plant"
	all_district_upgrades.append_array(hospital_upgrades)
	all_district_upgrades.append_array(entertainment_upgrades)
	all_district_upgrades.append_array(park_upgrades)
	all_district_upgrades.append_array(civilian_upgrades)
	all_district_upgrades.append_array(heating_upgrades)
	all_district_upgrades.append_array(government_upgrades)
	all_district_upgrades.append_array(laboratory_upgrades)
	all_district_upgrades.append_array(power_upgrades)
	for i in range (0, all_district_upgrades.size()):
		if current_district == all_district_upgrades[i][4]:
			current_upgrades.push_back(all_district_upgrades[i])

func get_current_district() -> void:
	current_district = get_parent().district_name

func init_upgrade_ui() -> void:
	for i in range (0,current_upgrades.size()):
		$UpgradesMenu/VBoxContainer/UpgradesList.add_item(current_upgrades[i][0], current_upgrades[i][1], true)
		$UpgradesMenu/VBoxContainer/UpgradesList.set_item_tooltip($UpgradesMenu/VBoxContainer/UpgradesList.item_count - 1, current_upgrades[i][2])

func _ready() -> void:
	random_event_manager = get_parent().get_parent().get_parent().find_child("RandomEventManager")
	$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	$UpgradesMenu/VBoxContainer/Cost.visible = false
	get_current_district()
	$UpgradesMenu/VBoxContainer/UpgradesList.clear()
	init_all_arrays()
	init_upgrade_ui()

func _process(_delta: float) -> void:
	check_for_money()

func _on_upgrades_list_item_selected(index: int) -> void:
	$Sounds/SelectSound.play()
	upgrade_selected = index
	$UpgradesMenu/VBoxContainer/Cost/MoneyCost.text = str(current_upgrades[index][5])
	current_money_cost = int(current_upgrades[index][5])
	$UpgradesMenu/VBoxContainer/Cost/TechnologyCost.text = str(current_upgrades[index][6])
	current_technology_cost = int(current_upgrades[index][6])
	$UpgradesMenu/VBoxContainer/Cost.visible = true
	if (GlobalVars.resource_money[1] - current_money_cost) >= 0 and (GlobalVars.resource_upgrade[1] - current_technology_cost) >= 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = false
	
func _on_buy_button_pressed() -> void:
	$Sounds/BuySound.play()
	$UpgradesMenu/VBoxContainer/Cost.visible = false
	$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	$UpgradesMenu/VBoxContainer/UpgradesList.set_item_disabled(upgrade_selected, true)
	GlobalVars.resource_money[1] -= current_money_cost
	GlobalVars.resource_upgrade[1] -= current_technology_cost
	current_upgrades[upgrade_selected][3].call()

func check_for_money() -> void:
	if (GlobalVars.resource_money[1] - current_money_cost) < 0 or (GlobalVars.resource_upgrade[1] - current_technology_cost) < 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = true


# District Upgrade Functions

func night_shift() -> void:
	get_parent().can_work_at_night = true

func more_production() -> void:
	get_parent().produces_1_count += int(get_parent().produces_1_count * 0.25)
	get_parent().produces_2_count += int(get_parent().produces_2_count * 0.25)
	get_parent().produces_3_count += int(get_parent().produces_3_count * 0.25)
	get_parent().produces_4_count += int(get_parent().produces_4_count * 0.25)

func solar_panels() -> void:
	if get_parent().extra_energy == 0:
		get_parent().extra_energy = 3
	elif get_parent().extra_energy != 0:
		get_parent().extra_energy = 6

func autonomy() -> void:
	var was_energy = get_parent().needs_energy
	get_parent().needs_energy -= int(get_parent().needs_energy * 0.5)
	GlobalVars.resource_power[1] += (was_energy - get_parent().needs_energy)

func cheaper_repairs() -> void:
	get_parent().fix_cost = get_parent().fix_cost * 0.75

func faster_repairs() -> void:
	get_parent().fix_speed = get_parent().fix_speed * 0.75
	get_parent().find_child("FixTickTimer").wait_time = get_parent().fix_speed

func shelters() -> void:
	if get_parent().shelter_protection == 0:
		get_parent().shelter_protection = 0.25
	elif get_parent().shelter_protection != 0:
		get_parent().shelter_protection = 0.75

func more_mental_health_production() -> void:
	get_parent().produces_1_count += int(get_parent().produces_1_count * 0.5)
	
func more_money_production() -> void:
	get_parent().produces_2_count += int(get_parent().produces_2_count * 1)

func less_mental_health_depletion() -> void:
	var was_energy = get_parent().needs_energy
	GlobalVars.mental_mood_depletion = GlobalVars.mental_mood_depletion * 0.5
	get_parent().needs_energy = int(get_parent().needs_energy * 1.5)
	GlobalVars.resource_power[1] += (was_energy - get_parent().needs_energy)

func diplomacy_level_one() -> void:
	random_event_manager.government_events.append_array(random_event_manager.government_events_upgrade_1)
	print(random_event_manager.government_events)

func diplomacy_level_two() -> void:
	random_event_manager.government_events.append_array(random_event_manager.government_events_upgrade_2)
	print(random_event_manager.government_events)


func _on_upgrades_menu_folding_changed(_is_folded: bool) -> void:
	$Sounds/FoldSound.play()
