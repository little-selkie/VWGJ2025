extends Node

# Resources
# 0 - name, 1 - count, 2 - icon, 3 - description
var resource_test: Array = [
	"TestName", 
	0, 
	load("res://icon.svg"), 
	"TestDescription"]
var resource_power: Array = [
	"Power", 
	0, 
	load("res://icon.svg"), 
	"PLACEHOLDER"]
var resource_people_mood: Array = [
	"Mental Health", 
	50, 
	load("res://icon.svg"), 
	"PLACEHOLDER"]
var resource_people_health: Array = [
	"Physical Health", 
	50, 
	load("res://icon.svg"), 
	"PLACEHOLDER"]
var resource_money: Array = [
	"Money", 
	10000, 
	load("res://icon.svg"), 
	"PLACEHOLDER"]
var resource_heat: Array = [
	"Heating", 
	10, 
	load("res://icon.svg"), 
	"PLACEHOLDER"]
var resource_upgrade: Array = [
	"Technology", 
	10,
	load("res://icon.svg"), 
	"PLACEHOLDER"]

var heat_consumption: float = 0.1
var health_depletion: float = 0.1
var mental_mood_depletion: float = 0.1
# Moneys
var passive_money_income: int = 10
var income_time: float = 3.0

var civilians_unhappy: bool = false

# Time simulated
# 0 - day, 1 - hour, 2 - minute
var current_time: Array = [1, 0, 0]
var time_of_day: String = "Night"
var time_simulation: float = 0.05

var everything_is_broken: bool = false

var protection: int = 0

# Upgrades
# 0 - name, 1 - cost in money, 2 - cost in technology, 3 - icon, 4 - description
var upgrades: Array[Array] = [
	["Self-Sufficiency", 10000, 10, load("res://icon.svg"), "PLACEHOLDER"],
	["Solar Panels", 100, 0, load("res://icon.svg"), "PLACEHOLDER"],
	["PLACEHOLDER", 99, 9, load("res://icon.svg"), "PLACEHOLDER"],
	["PLACEHOLDER", 99, 9, load("res://icon.svg"), "PLACEHOLDER"],
	["PLACEHOLDER", 99, 9, load("res://icon.svg"), "PLACEHOLDER"],
	["PLACEHOLDER", 99, 9, load("res://icon.svg"), "PLACEHOLDER"]
]
