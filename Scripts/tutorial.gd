extends Control

var current_step: int = 0

# 0 - text, 1 - image
var tutorial_steps: Array[Array] = [
	["This is a game about managing resources during blackouts. You have to distribute limited resources in the most optimal way to keep your city working and civilians happy and healthy.", load("res://Icons/Tutorial/tutorial1.png"), "Overview"],
	["These are your resources: [br][b]Power[/b] [img=64x64]res://Icons/Upgrades/Electricity.png[/img] - the main resource that keeps the city going. [br][b]Finances[/b] [img=64x64]res://Icons/Upgrades/Money.png[/img] - resource to buy Upgrades and fix districts affected by bombings. [br][b]Technology[/b] [img=64x64]res://Icons/Upgrades/tech.png[/img] - resource that can be spent on Upgrades. [br][b]Heat[/b] [img=64x64]res://Icons/Upgrades/Heating.png[/img] - affects Mental and Physical Health of the population. [br]You can always revisit this info by hovering over the resource icons.", load("res://Icons/Tutorial/tutorial2.png"), "Resources"],
	["You will also have to keep an eye on these indicators: [br][b]Mental Health[/b] [img=64x64]res://Icons/Upgrades/Mental_Health.png[/img] - general state of the population, affects the Finances [img=64x64]res://Icons/Upgrades/Money.png[/img] generation. [br][b]Physical Health[/b] [img=64x64]res://Icons/Upgrades/Physical_Health_.png[/img] - affects the rate of Power [img=64x64]res://Icons/Upgrades/Electricity.png[/img] generation. [br][b]Protection[/b] [img=64x64]res://Icons/Upgrades/Air_Defense_.png[/img] - affects the rate of shellings happening. This is the main indicator you need to fill to win the game.", load("res://Icons/Tutorial/tutorial3.png"), "Indicators"],
	["You have 8 districts, each with it's own purpose and production. Use [b]Power[/b] [img=64x64]res://Icons/Upgrades/Electricity.png[/img] to keep districts working, but this resource is [b]not[/b] generated over time - you have limited amount to share between districts, so choose your priorities wisely. To increase the amount of [b]Power[/b] [img=64x64]res://Icons/Upgrades/Electricity.png[/img] use can always go for Upgrades [img=64x64]res://Icons/Upgrades/Solar_Panels.png[/img].", load("res://Icons/Tutorial/tutorial1.png"), "Districts"],
	["There are two types of Upgrades available: [br][b]District Upgardes[/b] - to increase productivity in your district. [br][b]General Upgrades[/b] - to improve your city as a whole. [br]You can hover over the Upgrade icons to learn more about what they can do for you.", load("res://Icons/Tutorial/tutorial5.png"), "Upgrades"],
	["You just managed to find a balance in the infrastructure, but [b]BAM![/b] - one of your districts has been shelled :( [br]Be sure to spend Finances [img=64x64]res://Icons/Upgrades/Money.png[/img] to fix the affected district, but also don't forget to invest in Protection [img=64x64]res://Icons/Upgrades/Air_Defense_.png[/img] to reduce shelling frequency.", load("res://Icons/Tutorial/tutorial1.png"), "Shellings"],
	["Things are happening in your city all the time, some of them are more important for you than others. These are called [b]Events[/b], they can be a blessing or a curse - they affect your Resources in a positive or a negative way. [br]Don't forget to have your [b]Government[/b] running and upgraded, so you can receive blessings from your partners that will help you manage this difficult times.", load("res://Icons/Tutorial/tutorial7.png"), "Events"],
	["So, your city is running smoothly, everything is in order? To [b]Win[/b] you have to have your city protected at MAX. [br]But if you reach bankruptcy - the game will end.", load("res://Icons/Tutorial/tutorial1.png"), "Win or lose"]
]

func _ready() -> void:
	$".".visible = true
	$Panel/TutorialPopUp.visible = true
	$Panel/TutorialSteps.visible = false
	check_steps()

func _process(_delta: float) -> void:
	check_steps()

func check_steps() -> void:
	if current_step == 0:
		$"Panel/TutorialSteps/Buttons/Back".disabled = true
	else:
		$"Panel/TutorialSteps/Buttons/Back".disabled = false
	if current_step == (tutorial_steps.size() - 1):
		$"Panel/TutorialSteps/Buttons/Forward".disabled = true
	else:
		$"Panel/TutorialSteps/Buttons/Forward".disabled = false

func _on_no_pressed() -> void:
	$".".visible = false


func _on_draw() -> void:
	get_tree().paused = true


func _on_hidden() -> void:
	get_tree().paused = false


func _on_yes_pressed() -> void:
	$Panel/TutorialPopUp.visible = false
	$Panel/TutorialSteps.visible = true
	init_current_step()


func _on_close_pressed() -> void:
	$".".visible = false

func init_current_step() -> void:
	$Panel/TutorialSteps/HeaderText.text = str(tutorial_steps[current_step][2])
	$Panel/TutorialSteps/HBoxContainer/StepText.text = str(tutorial_steps[current_step][0])
	$Panel/TutorialSteps/HBoxContainer/TextureRect.texture = tutorial_steps[current_step][1]


func _on_forward_pressed() -> void:
	current_step += 1
	init_current_step()


func _on_back_pressed() -> void:
	current_step -= 1
	init_current_step()
