extends Control

# 0 - title, 1 - icon, 2 - description, 3 - function, 4 - type, 5 - cost in money, 6 - cost in technology
var all_district_upgrades: Array[Array]

var hospital_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 10, 10]
]
var entertainment_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 10, 10]
]
var park_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 0, 20]
]
var civilian_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 2, 3]
]
var heating_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 10, 10]
]
var government_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 5, 5]
]
var laboratory_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 6, 1]
]
var power_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 10, 4]
]

var current_upgrades: Array[Array]

var current_district: String
var current_money_cost: int = 999999
var current_technology_cost: int = 99999
var upgrade_selected: int

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
	$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	$UpgradesMenu/VBoxContainer/Cost.visible = false
	get_current_district()
	$UpgradesMenu/VBoxContainer/UpgradesList.clear()
	init_all_arrays()
	init_upgrade_ui()

func _process(_delta: float) -> void:
	check_for_money()

func _on_upgrades_list_item_selected(index: int) -> void:
	upgrade_selected = index
	$UpgradesMenu/VBoxContainer/Cost/MoneyCost.text = str(current_upgrades[index][5])
	current_money_cost = int(current_upgrades[index][5])
	$UpgradesMenu/VBoxContainer/Cost/TechnologyCost.text = str(current_upgrades[index][6])
	current_technology_cost = int(current_upgrades[index][6])
	$UpgradesMenu/VBoxContainer/Cost.visible = true
	if (GlobalVars.resource_money[1] - current_money_cost) >= 0 and (GlobalVars.resource_upgrade[1] - current_technology_cost) >= 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = false
	
func _on_buy_button_pressed() -> void:
	$UpgradesMenu/VBoxContainer/Cost.visible = false
	$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	$UpgradesMenu/VBoxContainer/UpgradesList.set_item_disabled(upgrade_selected, true)
	GlobalVars.resource_money[1] -= current_money_cost
	GlobalVars.resource_upgrade[1] -= current_technology_cost

func check_for_money() -> void:
	if (GlobalVars.resource_money[1] - current_money_cost) < 0 or (GlobalVars.resource_upgrade[1] - current_technology_cost) < 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
