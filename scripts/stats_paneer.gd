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

@onready var action_container: Control = $ActionContainer
@onready var act_1_name: Label = $ActionContainer/Action1/Act1name
@onready var act_1_timer: AnimatedSprite2D = $ActionContainer/Action1/Act1Timer
@onready var act_2_name: Label = $ActionContainer/Action2/Act2name
@onready var act_2_timer: AnimatedSprite2D = $ActionContainer/Action2/Act2Timer
@onready var act_3_name: Label = $ActionContainer/Action3/Act3name
@onready var act_3_timer: AnimatedSprite2D = $ActionContainer/Action3/Act3Timer
@onready var action_1: TextureButton = $ActionContainer/Action1
@onready var action_2: TextureButton = $ActionContainer/Action2
@onready var action_3: TextureButton = $ActionContainer/Action3


@export var stats: Player_Stats

var action_point: int
var bar_percentage: float

func _ready() -> void:
	stats = Game.player_stats
	action_point = stats.action_points
	print("[行动点]: %s" % [action_point])
	stats.age_change.connect(update_age)
	stats.ap_change.connect(update_ap)
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

func update_ap() -> void:
	act_point_num.text = str(action_point)

func disable_button() -> void:
	for button: TextureButton in action_container.get_children():
		button.disabled = true
func sable_button() -> void:
	for button: TextureButton in action_container.get_children():
		button.disabled = false
func _on_action_1_pressed() -> void:
	disable_button()
	action_point -= 1
	act_1_timer.play()
	await act_1_timer.animation_finished
	sable_button()
	print("[行动点]: %s" % [action_point])
	if action_point > 0:
		stats.action_points = action_point
	else:
		stats.action_points = stats.init_action_points
		Game.go_to_battle()


func _on_action_2_pressed() -> void:
	disable_button()
	action_point -= 1
	act_2_timer.play()
	await act_2_timer.animation_finished
	sable_button()
	print("[行动点]: %s" % [action_point])
	if action_point > 0:
		stats.action_points = action_point
	else:
		stats.action_points = stats.init_action_points
		Game.go_to_battle()


func _on_action_3_pressed() -> void:
	disable_button()
	action_point -= 1
	act_3_timer.play()
	await act_3_timer.animation_finished
	sable_button()
	print("[行动点]: %s" % [action_point])
	if action_point > 0:
		stats.action_points = action_point
	else:
		stats.action_points = stats.init_action_points
		Game.go_to_battle()
