class_name Monster_Stats
extends Node

signal m_health_change
signal m_atk_change
signal m_def_change
signal m_speed_change


@export var init_health: float = 10
@export var init_atk: float = 8
@export var init_def: float = 6
@export var init_speed: float = 0

@export var critical: float = 0
@export var criticalDamage: float = 1



@onready var health: float = init_health:
	set(v):
		if health == v:
			return
		health = v
		m_health_change.emit()
@onready var atk: float = init_atk:
	set(v):
		if atk == v:
			return
		atk = v
		m_atk_change.emit()
@onready var def: float = init_def:
	set(v):
		if def == v:
			return
		def = v
		m_def_change.emit()
