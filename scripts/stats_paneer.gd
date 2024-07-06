extends Control

enum Gender{#for player
	CHILD, #0 <= age < 12
	YOUTH, #12 <= age < 24
	ADULT, #24 <= age < 50
	ELDER, #50 <= age < 60
}

@onready var age_num: Label = $age/age_num
@onready var health_num: Label = $health/health_num
@onready var def_num: Label = $def/def_num
@onready var atk_num: Label = $atk/atk_num
@onready var gender: Label = $gender
@onready var act_point_num: Label = $act_point/act_point_num

@export var stats: Stats
@export var action_point: int = 4

var bar_percentage: float

func _ready() -> void:
	stats = Game.player_stats
	stats.age_change.connect(update_age)
	act_point_num.text = str(action_point)
	health_num.text = str(stats.health)
	atk_num.text = str(stats.atk)
	def_num.text = str(stats.def)

func update_age() -> void:
	age_num.text = str(stats.age)
	if 0 <= stats.age && stats.age < 12:
		gender.text = "幼年"
	elif 12 <= stats.age && stats.age < 24:
		gender.text = "青年"
	elif 24 <= stats.age && stats.age < 50:
		gender.text = "成年"
	else:
		gender.text = "老年"

func _on_age_timer_timeout() -> void:
	stats.age += 1
	print(stats.age)


func _on_action_1_button_down() -> void:
	print("豪赤")
