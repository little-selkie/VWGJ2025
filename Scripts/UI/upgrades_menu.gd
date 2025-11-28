extends Control

# 0 - title, 1 - icon, 2 - description, 3 - function, 4 - type, 5 - cost in money, 6 - cost in technology
var all_general_upgrades: Array[Array] = [
	["Protection I", load("res://Icons/Upgrades/Air_Defense_+.png"), "Add 20% Protection", add_protection, "Type", 1000, 10],
	["Protection II", load("res://Icons/Upgrades/Air_Defense_+.png"), "Add 20% Protection", add_protection, "Type", 2000, 20],
	["Protection III", load("res://Icons/Upgrades/Air_Defense_+.png"), "Add 20% Protection", add_protection, "Type", 3000, 30],
	["Extra Battery I", load("res://Icons/Upgrades/Electricity_+.png"), "Add 3 To Power", add_power, "Type", 1000, 10],
	["Extra Battery II", load("res://Icons/Upgrades/Electricity_+.png"), "Add 3 To Power", add_power, "Type", 2000, 20],
	["Extra Battery III", load("res://Icons/Upgrades/Electricity_+.png"), "Add 3 To Power", add_power, "Type", 3000, 30],
	["Local business support", load("res://Icons/Upgrades/Money_+.png"), "Add 25% to passive income", add_passive_income, "Type", 3000, 5],
	["Heating Program", load("res://Icons/Upgrades/Heating_+.png"), "Reduce Heating consumption by 50%", reduce_heating_consumption, "Type", 3000, 5],
	["Tabletki.ua", load("res://Icons/Upgrades/Physical_Health_+.png"), "Add constant health boost", health_boost, "Type", 3000, 5]
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
	$Sounds/SelectSound.play()
	upgrade_selected = index
	$UpgradesMenu/VBoxContainer/Cost/MoneyCost.text = str(all_general_upgrades[index][5])
	current_money_cost = int(all_general_upgrades[index][5])
	$UpgradesMenu/VBoxContainer/Cost/TechnologyCost.text = str(all_general_upgrades[index][6])
	current_technology_cost = int(all_general_upgrades[index][6])
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
	all_general_upgrades[upgrade_selected][3].call()

func check_for_money() -> void:
	if (GlobalVars.resource_money[1] - current_money_cost) < 0 or (GlobalVars.resource_upgrade[1] - current_technology_cost) < 0:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = true
	else:
		$UpgradesMenu/VBoxContainer/BuyButton.disabled = false


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


func _on_slide_button_toggled(toggled_on: bool) -> void:
	$Sounds/FoldSound.play()
	if toggled_on:
		$AnimationPlayer.play("GeneralUpgradeSlide")
	elif !toggled_on:
		$AnimationPlayer.play("GeneralUpgradeSlideDown")
