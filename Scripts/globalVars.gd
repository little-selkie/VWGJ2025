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
	100, 
	load("res://icon.svg"), 
	"PLACEHOLDER"]
var resource_people_health: Array = [
	"Physical Health", 
	100, 
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
# 0 - test, 1 - power, 2 - people's mental health, 3 - people's physical health,
# 4 - money, 5 - heat
var resources: Array = [
	resource_test, 
	resource_power, 
	resource_people_mood, 
	resource_people_health,
	resource_money,
	resource_heat,
	resource_upgrade]

# Time simulated
# 0 - day, 1 - hour, 2 - minute
var current_time: Array = [1, 0, 0]
