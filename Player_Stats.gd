class_name Player_Stats
extends Node

signal health_change
signal atk_change
signal def_change
signal age_change
signal speed_change
signal luck_change
signal critical_change
signal criticalDamage_change
signal ap_change
enum Gender{#for player
	CHILD, #0 <= age < 12
	YOUTH, #12 <= age < 24
	ADULT, #24 <= age < 50
	ELDER, #50 <= age < 60
}
@export var init_health: float = 10
@export var init_atk: float = 10
@export var init_def: float = 10
@export var init_age: int = 0
@export var init_critical: float = 0
@export var init_criticalDamage: float = 1
@export var init_luck: float = 0
@export var init_speed: float = 0
@export var init_action_points: int = 10
@export var genshin_func: Array = []
@export var devil_func: Array = []
@export var action_points: int = 5:
	set(v):
		if action_points == v:
			return
		action_points = v
		ap_change.emit()
@export var gender: int = 1

@export var isFirst: bool = true
@onready var health: float = init_health:
	set(v):
		if health == v:
			return
		health = v
		health_change.emit()
@onready var atk: float = init_atk:
	set(v):
		if atk == v:
			return
		atk = v
		atk_change.emit()
@onready var def: float = init_def:
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
@onready var speed: float = init_speed:
	set(v):
		if speed == v:
			return
		speed = v
		speed_change.emit()
@onready var critical: float = 0:
	set(v):
		if critical == v:
			return
		critical = v
		critical_change.emit()
@onready var criticalDamage: float = 0:
	set(v):
		if criticalDamage == v:
			return
		criticalDamage = v
		criticalDamage_change.emit()
@onready var luck: float = 0:
	set(v):
		if luck == v:
			return
		luck = v
		luck_change.emit()
@onready var colorChoose: String
