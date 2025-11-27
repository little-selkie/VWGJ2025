extends Control

var current_step: int = 0

# 0 - text, 1 - image
var tutorial_steps: Array[Array] = [
	["Test Step", load("res://Icons/Funny/meme.png")],
	["This is a game about blackouts", load("res://Icons/Funny/meme.png")]
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
	$Panel/TutorialSteps/HeaderText.text = "Tutorial: Step " + str(current_step)
	$Panel/TutorialSteps/HBoxContainer/StepText.text = str(tutorial_steps[current_step][0])
	$Panel/TutorialSteps/HBoxContainer/TextureRect.texture = tutorial_steps[current_step][1]


func _on_forward_pressed() -> void:
	current_step += 1
	init_current_step()


func _on_back_pressed() -> void:
	current_step -= 1
	init_current_step()
