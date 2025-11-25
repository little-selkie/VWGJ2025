extends Node

@export var min_event_timer: float = 1.0
@export var max_event_timer: float = 2.0

var rng = RandomNumberGenerator.new()
var random_number: int = 0
var random_time: float = 1.0

var protection_count: int = 0

# Events
# 0 - header, 1 - description, 2 - confim message, 3 - event function, 4 - event type
var random_events: Array[Array] = [
	["Memes", "People are sharing new funny memes on social media. Even in these difficult times, humor never dies. \r\n Your city gets a slight boost to People's Mental Health.", "Great!", mental_health_add, "type"],
	["Memes", "People are sharing new funny memes on social media. Even in these difficult times, humor never dies. \r\n Your city gets a slight boost to People's Mental Health.", "Great!", mental_health_add, "type"],
	["Food Fair", "Small local business organized Food Fair on the main square. People got a chance to spend time with their loved ones, eat tasty meals and spend some money. \r\n Your city gets a slight boost to People's Mental Health, People's Physical Health and Money.", "Great!", mental_health_physical_health_money_add, "type"],
	["Temprature Drops", "Forecasters predict a cold night. People need more hot water to heat up their houses. \r\n Your city spends some hot water for Heating.", "Hope everyone are keeping warm.", heating_decreace, "type"],
	["Donations", "Kind people orginized charity auction and collected some money for the good cause. \r\n Your city gets a moderate amount of money.", "Thank you!", money_donation, "type"],
	["Mental Struggles", "Last few days were especially hard on your people. They are mentally exhausted and are barely holding up. \r\n Your city gets a moderate decrease of People's Mental Health.", "We must keep going.", mental_health_decrease, "type"],
	["Seasonal Illnesses", "Weather is getting colder and people are catching a cold. Many called in sick and need some time to recover. \r\n Your city gets a moderate decrease of People's Physical Health.", "They need to keep warm and drink lots of hot tea.", physical_health_decrease, "type"],
	["Cute Kittens", "New photos of cute kittens in funny little hats are making rounds on social media. Aren't they adorable? \r\n Your city gets a slight boost to People's Mental Health.", "So cute!", mental_health_add, "type"],
	["Home Reconstruction", "Recent attack damage prive housings. Families, who live there, need money to start the reconstruction. \r\n Your city spends a moderate amount of money and gets a slight boost to People's Mental Health.", "We'll help them.", money_decrease, "type"],
	["Home Reconstruction", "Recent attack damage prive housings. Families, who live there, need money to start the reconstruction. \r\n Your city spends a moderate amount of money and gets a slight boost to People's Mental Health.", "We'll help them.", money_decrease, "type"],
	["Animal Shelter", "Local animal shelter was damaged during recent attach. Animals need medical help and new place to stay. \r\n Your city spends a moderate amount of money and gets a slight boost to People's Mental Health.", "They'll be taken care of.", money_decrease, "type"],
	["Mental Breakdown", "People are tired and struggle to stay awake. \r\n Your city gets a moderate decrease of People's Mental Health.", "We must prevail.", mental_health_decrease, "type"],
]

var government_events: Array[Array] = [
	["Politicians' Speech", "Politicians' from other countries publicly condemned recent attack on your city. \r\n People are grateful for their reaction, but nothing seems to change.", "Okay.", nothing_happens, "type"],
	["Politicians' Speech", "Politicians' from other countries publicly condemned recent attack on your city. \r\n People are grateful for their reaction, but nothing seems to change.", "Okay.", nothing_happens, "type"],
	["Humanitarian Help", "Non-Profit Organization collected donations and bought medicine, food and heating blankets for your people. \r\n Your city gets a moderate boost to People's Mental Health, People's Physical Health and Heating.", "Thank you!", humanitarian_help, "type"],
	["Huge Donation", "Foreign celebrity hosted charity consert and collected a huge amount of donations for your people. \r\n Your city gets a considerate amount of money and a slight boost to People's Mental Health.", "Thank you!", nothing_happens, "type"]
]

var government_events_upgrade_1: Array[Array] = [
	["Humanitarian Help", "Non-Profit Organization collected donations and bought medicine, food and heating blankets for your people. \r\n Your city gets a moderate boost to People's Mental Health, People's Physical Health and Heating.", "Thank you!", humanitarian_help, "type"],
	["Huge Donation", "Foreign celebrity hosted charity consert and collected a huge amount of donations for your people. \r\n Your city gets a considerate amount of money and a slight boost to People's Mental Health.", "Thank you!", nothing_happens, "type"],
	["Protection", "Your partners donated a huge amount of protection tools to counteract enemy attacks. Your people now feel a bit safer. \r\n Your city gets 20% more protection.", "Thank you!", protection_donation_1, "type"]
]

var government_events_upgrade_2: Array[Array] = [
	["Humanitarian Help", "Non-Profit Organization collected donations and bought medicine, food and heating blankets for your people. \r\n Your city gets a moderate boost to People's Mental Health, People's Physical Health and Heating.", "Thank you!", humanitarian_help, "type"],
	["Huge Donation", "Foreign celebrity hosted charity consert and collected a huge amount of donations for your people. \r\n Your city gets a considerate amount of money and a slight boost to People's Mental Health.", "Thank you!", nothing_happens, "type"],
	["Protection", "Your partners donated a huge amount of protection tools to counteract enemy attacks. Your people now feel a bit safer. \r\n Your city gets 20% more protection.", "Thank you!", protection_donation_2, "type"]
]

var special_events: Array[Array] = [
	["Last Chance", "You ran out of money. Partners collected some funds for you, but they are not really happy. \r\n This is your last chanse to save the the city.", "Thank you.", last_chance, "Special"],
]

func _ready() -> void:
	for i in range(0, random_events.size()):
		random_events[i][4] = "Common"
	for i in range(0, government_events.size()):
		government_events[i][4] = "Government"
	for i in range(0, government_events_upgrade_1.size()):
		government_events_upgrade_1[i][4] = "Government"
	for i in range(0, government_events_upgrade_2.size()):
		government_events_upgrade_2[i][4] = "Government"

func _enter_tree() -> void:
	set_random_time()
	$Control.visible = false

func _on_event_timer_timeout() -> void:
	random_number = rng.randi_range(0, random_events.size() - 1)
	random_events[random_number][3].call()
	$Control/Panel/VBoxContainer/HeaderText.text = str(random_events[random_number][0])
	$Control/Panel/VBoxContainer/DescriptionText.text = str(random_events[random_number][1])
	$Control/Panel/VBoxContainer/ConfirmButton.text = str(random_events[random_number][2])
	$Control.visible = true
	get_tree().paused = true

# Event functions
func mental_health_add() -> void:
	GlobalVars.resource_people_mood[1] += 10

func nothing_happens() -> void:
	print(" ")

func last_chance() -> void:
	GlobalVars.resource_money[1] += 10000
	GlobalVars.second_chance = false
	$Control/Panel/VBoxContainer/HeaderText.text = str(special_events[0][0])
	$Control/Panel/VBoxContainer/DescriptionText.text = str(special_events[0][1])
	$Control/Panel/VBoxContainer/ConfirmButton.text = str(special_events[0][2])
	$Control.visible = true

func mental_health_physical_health_money_add() -> void:
	GlobalVars.resource_people_mood[1] += 10
	GlobalVars.resource_people_health[1] += 10
	GlobalVars.resource_money[1] += 500

func heating_decreace() -> void:
	GlobalVars.resource_heat[1] -= 50
	if GlobalVars.resource_heat[1] < 0:
		GlobalVars.resource_heat[1] = 0

func money_donation() -> void:
	GlobalVars.resource_money[1] += 3000

func mental_health_decrease() -> void:
	GlobalVars.resource_people_mood[1] -= 40

func physical_health_decrease() -> void:
	GlobalVars.resource_people_mood[1] -= 30

func money_decrease() -> void:
	var decrease_amount = 3000
	if GlobalVars.resource_money[1] - decrease_amount >= 0:
		GlobalVars.resource_money[1] -= decrease_amount
	elif GlobalVars.resource_money[1] - decrease_amount < 0:
		GlobalVars.resource_money[1] = 0
	GlobalVars.resource_people_mood[1] += 10

func humanitarian_help() -> void:
	GlobalVars.resource_people_health[1] += 30
	GlobalVars.resource_people_mood[1] += 30
	GlobalVars.resource_heat[1] += 100

func huge_money_donation() -> void:
	GlobalVars.resource_people_mood[1] += 10
	GlobalVars.resource_money[1] += 8000

func protection_donation_1() -> void:
	if protection_count == 0:
		GlobalVars.protection += 20
		protection_count += 1
	else:
		random_number = rng.randi_range(0, random_events.size() - 1)
		random_events[random_number][3].call()
		$Control/Panel/VBoxContainer/HeaderText.text = str(random_events[random_number][0])
		$Control/Panel/VBoxContainer/DescriptionText.text = str(random_events[random_number][1])
		$Control/Panel/VBoxContainer/ConfirmButton.text = str(random_events[random_number][2])
		$Control.visible = true
		get_tree().paused = true

func protection_donation_2() -> void:
	if protection_count == 0 or protection_count == 1:
		GlobalVars.protection += 20
		protection_count += 1
	else:
		random_number = rng.randi_range(0, random_events.size() - 1)
		random_events[random_number][3].call()
		$Control/Panel/VBoxContainer/HeaderText.text = str(random_events[random_number][0])
		$Control/Panel/VBoxContainer/DescriptionText.text = str(random_events[random_number][1])
		$Control/Panel/VBoxContainer/ConfirmButton.text = str(random_events[random_number][2])
		$Control.visible = true
		get_tree().paused = true

# Else
func _on_confirm_button_button_up() -> void:
	get_tree().paused = false
	$Control.visible = false
	set_random_time()
	$EventTimer.start()

func set_random_time() -> void:
	random_time = rng.randf_range(min_event_timer, max_event_timer)
	$EventTimer.wait_time = random_time
