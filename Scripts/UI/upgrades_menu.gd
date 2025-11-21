extends Control

# 0 - title, 1 - icon, 2 - description, 3 - function, 4 - type, 5 - cost in money, 6 - cost in technology
var all_general_upgrades: Array[Array] = [
	["Title", load("res://icon.svg"), "Description", "What Happens", "Type", 10, 10]
]

var current_money_cost: int = 999999
var current_technology_cost: int = 99999
var upgrade_selected: int

func init_all_arrays() -> void:
	for i in range(0, all_general_upgrades.size()):
		all_general_upgrades[i][4] = "Hospital"

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

func check_for_money() -> void:
	if (GlobalVars.resource_money[1] - current_money_cost) < 0 or (GlobalVars.resource_upgrade[1] - current_technology_cost) < 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
