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
	5, 
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
	"Battery", 
	0,
	load("res://icon.svg"), 
	"PLACEHOLDER"]

# Time simulated
# 0 - day, 1 - hour, 2 - minute
var current_time: Array = [1, 0, 0]
var time_of_day: String = "Night"
var time_simulation: float = 0.05

# Upgrades
# 0 - name, 1 - cost, 2 - icon, 3 - description
var upgrades: Array[Array] = [
	["Self-Sufficiency", 10000, load("res://icon.svg"), "PLACEHOLDER"],
	["Night Shifts", 100, load("res://icon.svg"), "PLACEHOLDER"]
]
