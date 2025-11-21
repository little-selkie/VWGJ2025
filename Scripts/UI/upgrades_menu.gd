extends Control

# 0 - title, 1 - icon, 2 - description, 3 - function, 4 - type, 5 - cost in money, 6 - cost in technology
var all_general_upgrades: Array[Array] = [
	["Protection I", load("res://icon.svg"), "Add 20% Protection", add_protection, "Type", 10, 10],
	["Protection II", load("res://icon.svg"), "Add 20% Protection", add_protection, "Type", 20, 20],
	["Protection III", load("res://icon.svg"), "Add 20% Protection", add_protection, "Type", 30, 30],
	["Extra Battery I", load("res://icon.svg"), "Add 3 To Power", add_power, "Type", 10, 10],
	["Extra Battery II", load("res://icon.svg"), "Add 3 To Power", add_power, "Type", 20, 20],
	["Extra Battery III", load("res://icon.svg"), "Add 3 To Power", add_power, "Type", 30, 30],
	["Local business support", load("res://icon.svg"), "Add 25% to passive income", add_passive_income, "Type", 300, 5],
	["Heating Program", load("res://icon.svg"), "Reduce Heating consumption by 50%", reduce_heating_consumption, "Type", 300, 5],
	["Tabletki.ua", load("res://icon.svg"), "Add constant health boost", health_boost, "Type", 300, 5]
]

var current_money_cost: int = 999999
var current_technology_cost: int = 99999
var upgrade_selected: int

func init_all_arrays() -> void:
	for i in range(0, all_general_upgrades.size()):
		all_general_upgrades[i][4] = "General"

func init_upgrade_ui() -> void:
	for i in range (0,all_general_upgrades.size()):
		$UpgradesMenu/VBoxContainer/UpgradesList.add_item(all_general_upgrades[i][0], all_general_upgrades[i][1], true)
		$UpgradesMenu/VBoxContainer/UpgradesList.set_item_tooltip($UpgradesMenu/VBoxContainer/UpgradesList.item_count - 1, all_general_upgrades[i][2])

func _ready() -> void:
	$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	$UpgradesMenu/VBoxContainer/Cost.visible = false
	$UpgradesMenu/VBoxContainer/UpgradesList.clear()
	init_all_arrays()
	init_upgrade_ui()

func _process(_delta: float) -> void:
	check_for_money()

func _on_upgrades_list_item_selected(index: int) -> void:
	upgrade_selected = index
	$UpgradesMenu/VBoxContainer/Cost/MoneyCost.text = str(all_general_upgrades[index][5])
	current_money_cost = int(all_general_upgrades[index][5])
	$UpgradesMenu/VBoxContainer/Cost/TechnologyCost.text = str(all_general_upgrades[index][6])
	current_technology_cost = int(all_general_upgrades[index][6])
	$UpgradesMenu/VBoxContainer/Cost.visible = true
	if (GlobalVars.resource_money[1] - current_money_cost) >= 0 and (GlobalVars.resource_upgrade[1] - current_technology_cost) >= 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = false
	
func _on_buy_button_pressed() -> void:
	$UpgradesMenu/VBoxContainer/Cost.visible = false
	$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	$UpgradesMenu/VBoxContainer/UpgradesList.set_item_disabled(upgrade_selected, true)
	GlobalVars.resource_money[1] -= current_money_cost
	GlobalVars.resource_upgrade[1] -= current_technology_cost
	all_general_upgrades[upgrade_selected][3].call()

func check_for_money() -> void:
	if (GlobalVars.resource_money[1] - current_money_cost) < 0 or (GlobalVars.resource_upgrade[1] - current_technology_cost) < 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = true


# Upgrade Functions
func add_protection() -> void:
	GlobalVars.protection += 20

func add_power() -> void:
	GlobalVars.resource_power[1] += 3

func add_passive_income() -> void:
	GlobalVars.passive_money_income += int(GlobalVars.passive_money_income * 0.25)

func reduce_heating_consumption() -> void:
	GlobalVars.heat_consumption -= GlobalVars.heat_consumption * 0.5

func health_boost() -> void:
	GlobalVars.constant_health_boost = 0.1
