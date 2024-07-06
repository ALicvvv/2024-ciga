extends Control

enum Gender{#for player
	CHILD, #0 <= age < 12
	YOUTH, #12 <= age < 24
	ADULT, #24 <= age < 50
	ELDER, #50 <= age < 60
}
@onready var age_pannel: TextureProgressBar = $age_pannel
@onready var age_timer: Timer = $age_timer
@onready var age_num: Label = $age/age_num
@onready var gender: Label = $gender

@export var stats: Stats

var bar_percentage: float

func _ready() -> void:
	stats = Game.player_stats
	stats.age_change.connect(update_age)
	age_pannel.set_value_no_signal(0.0)

func _process(delta: float) -> void:
	bar_percentage = 1 - age_timer.time_left/age_timer.wait_time
	#print(age_timer.time_left)
	age_pannel.set_value_no_signal(bar_percentage)

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
