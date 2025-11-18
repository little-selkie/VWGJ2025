extends Control

var temp_node_name: String = "Upgrade"
var temp_node_path

var current_cost_money: int = 0
var current_cost_technology: int = 0
var current_upgrade_id: int = 0

func _ready() -> void:
	init_upgrades()
	$FoldableContainer/VBoxContainer/BuyButton.disabled = true

func _process(_delta: float) -> void:
	if current_upgrade_id != 0:
		check_if_can_buy()

func init_upgrades() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).icon = GlobalVars.upgrades[i-1][3]
		temp_node_path.find_child("TextureRect" + str(i)).tooltip_text = str(GlobalVars.upgrades[i-1][4])
		temp_node_path.find_child("Label").text = GlobalVars.upgrades[i-1][0]
		temp_node_path.find_child("HBoxContainer").find_child("TextureRect").texture = GlobalVars.resource_money[2]
		temp_node_path.find_child("HBoxContainer").find_child("Label").text = str(GlobalVars.upgrades[i-1][1])
		temp_node_path.find_child("HBoxContainer").find_child("TextureRect2").texture = GlobalVars.resource_upgrade[2]
		temp_node_path.find_child("HBoxContainer").find_child("Label2").text = str(GlobalVars.upgrades[i-1][2])


func _on_texture_rect_pressed() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).button_pressed = false
	$FoldableContainer/VBoxContainer/GridContainer/Upgrade1/TextureRect1.button_pressed = true
	current_upgrade_id = 1
	current_cost_money = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade1/HBoxContainer/Label.text)
	current_cost_technology = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade1/HBoxContainer/Label2.text)

func check_if_can_buy() -> void:
	if (GlobalVars.resource_money[1] - current_cost_money) >= 0 and (GlobalVars.resource_upgrade[1] - current_cost_technology) >= 0:
		$FoldableContainer/VBoxContainer/BuyButton.disabled = false
	else:
		$FoldableContainer/VBoxContainer/BuyButton.disabled = true

func buy_upgrade() -> void:
	GlobalVars.resource_money[1] -= current_cost_money
	GlobalVars.resource_upgrade[1] -= current_cost_technology
	current_cost_money = 0
	current_cost_technology = 0
	current_upgrade_id = 0
	$FoldableContainer/VBoxContainer/BuyButton.disabled = true


func _on_buy_button_pressed() -> void:
	temp_node_name = "Upgrade" + str(current_upgrade_id)
	temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
	temp_node_path.find_child("TextureRect" + str(current_upgrade_id)).disabled = true
	buy_upgrade()

#All other upgrades
func _on_texture_rect_2_pressed() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).button_pressed = false
	$FoldableContainer/VBoxContainer/GridContainer/Upgrade2/TextureRect2.button_pressed = true
	current_upgrade_id = 2
	current_cost_money = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade2/HBoxContainer/Label.text)
	current_cost_technology = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade2/HBoxContainer/Label2.text)
func _on_texture_rect_3_pressed() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).button_pressed = false
	$FoldableContainer/VBoxContainer/GridContainer/Upgrade3/TextureRect3.button_pressed = true
	current_upgrade_id = 3
	current_cost_money = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade3/HBoxContainer/Label.text)
	current_cost_technology = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade3/HBoxContainer/Label2.text)
func _on_texture_rect_4_pressed() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).button_pressed = false
	$FoldableContainer/VBoxContainer/GridContainer/Upgrade4/TextureRect4.button_pressed = true
	current_upgrade_id = 4
	current_cost_money = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade4/HBoxContainer/Label.text)
	current_cost_technology = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade4/HBoxContainer/Label2.text)
func _on_texture_rect_5_pressed() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).button_pressed = false
	$FoldableContainer/VBoxContainer/GridContainer/Upgrade5/TextureRect5.button_pressed = true
	current_upgrade_id = 5
	current_cost_money = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade5/HBoxContainer/Label.text)
	current_cost_technology = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade5/HBoxContainer/Label2.text)
func _on_texture_rect_6_pressed() -> void:
	for i in range(1, GlobalVars.upgrades.size() + 1):
		temp_node_name = "Upgrade" + str(i)
		temp_node_path = $FoldableContainer/VBoxContainer/GridContainer.find_child(temp_node_name)
		temp_node_path.find_child("TextureRect" + str(i)).button_pressed = false
	$FoldableContainer/VBoxContainer/GridContainer/Upgrade6/TextureRect6.button_pressed = true
	current_upgrade_id = 5
	current_cost_money = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade6/HBoxContainer/Label.text)
	current_cost_technology = int($FoldableContainer/VBoxContainer/GridContainer/Upgrade6/HBoxContainer/Label2.text)
