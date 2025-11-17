extends Control

@export var district_name: String = "Test"
@export_range(0, 10, 1) var needs_energy: int = 1

@export var is_on: bool = true
@export var can_work_at_night: bool = false
@export_range(0, 100, 5) var efficiency: int = 100

@export_group("Production")
enum producesEnum {None, MentalHealth, Health, Money, Heat, UpgradeParts}
@export var produces_1: producesEnum
@export_range(0, 100, 1) var produces_1_count: int = 0
@export var produces_2: producesEnum
@export_range(0, 100, 1) var produces_2_count: int = 0
@export var produces_3: producesEnum
@export_range(0, 100, 1) var produces_3_count: int = 0
@export var produces_4: producesEnum
@export_range(0, 100, 1) var produces_4_count: int = 0

var all_produce: int = 0

func _ready():
	update_info()

func update_info():
	$VBoxContainer/DistrictName.text = str(district_name)
	if produces_1 != 0:
		all_produce += 1
