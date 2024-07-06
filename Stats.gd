class_name Stats
extends Node

signal health_change
signal atk_change
signal def_change
signal age_change
enum Gender{#for player
	CHILD, #0 <= age < 12
	YOUTH, #12 <= age < 24
	ADULT, #24 <= age < 50
	ELDER, #50 <= age < 60
}
@export var init_health: int = 10
@export var init_atk: int = 8
@export var init_def: int = 6
@export var init_age: int = 0
 
@onready var health: int = init_health:
	set(v):
		if health == v:
			return
		health = v
		health_change.emit()
@onready var atk: int = init_atk:
	set(v):
		if atk == v:
			return
		atk = v
		atk_change.emit()
@onready var def: int = init_def:
	set(v):
		if def == v:
			return
		def = v
		def_change.emit()
@onready var age: int = init_age:
	set(v):
		if age == v:
			return
		age = v
		age_change.emit()
@onready var colorChoose: String
