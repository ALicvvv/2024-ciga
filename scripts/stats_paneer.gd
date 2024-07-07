extends Control

enum Gender{#for player
	CHILD, #0 <= age < 12
	YOUTH, #12 <= age < 24
	ADULT, #24 <= age < 50
	ELDER, #50 <= age < 60
}
signal button_ready

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
@onready var act_1_fx: AnimatedSprite2D = $ActionContainer/Action1/Act1Fx
@onready var act_2_fx: AnimatedSprite2D = $ActionContainer/Action2/Act2Fx
@onready var act_3_fx: AnimatedSprite2D = $ActionContainer/Action3/Act3Fx

@export var stats: Player_Stats
var act1_func
var act2_func
var act3_func
var action_point: int
var bar_percentage: float
var promoted_properties_dict = {
	"hp" : ["吃奶","吃牛","提升意志"],
	"atk": ["打木桩","打石头"],
	"def": ["吞剑"],
	"critical" : ["练太极"],
	"criticalDamage" : ["开爆"],
	"luck" : ["冥想","瀑布修行"],
	"speed" : ["吃奶"],
	"action_point": ["再冲一次！！"]
}
var promoted_properties_value_dict = {
	"hp" : 10,
	"atk": 10,
	"def": 10,
	"critical" : 0.1,
	"criticalDamage" : 0.1,
	"luck" : 0.1,
	"speed" : 0.1,
	"action_point": 1
}

var base_properties_key = ["hp", "atk", "def"] #0.60
var other_properties_key = ["critical", "criticalDamage", "luck", "speed"] #0.3
var sp_properties_key = ["action_point"] #0.1

func _ready() -> void:
	#print(promoted_properties_key)

	stats = Game.player_stats
	action_point = stats.action_points
	print("[行动点]: %s" % [action_point])
	stats.age_change.connect(update_age)
	stats.ap_change.connect(update_ap)
	act_point_num.text = str(action_point)
	health_num.text = str(stats.health)
	atk_num.text = str(stats.atk)
	def_num.text = str(stats.def)
	refresh_button()

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

func able_button() -> void:
	for button: TextureButton in action_container.get_children():
		button.disabled = false
	button_ready.emit()

func refresh_button() -> void:
	act1_func = make_button(act_1_name,act_1_fx)
	act2_func = make_button(act_2_name,act_2_fx)
	act3_func = make_button(act_3_name,act_3_fx)
	able_button()

func make_button(act_label:Label, act_fx: AnimatedSprite2D) -> Array:
	var act_func
	var act_value
	var act_name_lst: Array
	var lucky = randf()
	if lucky < 0.65:
		act_func = base_properties_key.pick_random()
		print(act_func)
		act_value = promoted_properties_value_dict[act_func]
		act_name_lst = promoted_properties_dict[act_func]
	elif 0.65 <= lucky && lucky < 0.9:
		act_func = other_properties_key.pick_random()
		print(act_func)
		act_value = promoted_properties_value_dict[act_func]
		act_name_lst = promoted_properties_dict[act_func]
	else:
		act_func = sp_properties_key.pick_random()
		print(act_func)
		act_value = promoted_properties_value_dict[act_func]
		act_name_lst = promoted_properties_dict[act_func]
	act_label.text = act_name_lst.pick_random()
	show_fx(act_fx, act_func)
	print("[%s] - %s|%s|%s",[act_label.name,act_label.text,act_func,act_value])
	return [act_func, act_value]

func show_fx(act_fx: AnimatedSprite2D, param) -> void:
	if param in base_properties_key:
		act_fx.play("idle")
	if param in other_properties_key:
		act_fx.play("other")
	if param in sp_properties_key:
		act_fx.play("sp")

func handle_button(param) -> void:
	match param:
		"hp" :
			pass
		"atk":
			pass
		"def": 
			pass
		"critical": 
			pass
		"criticalDamage":
			pass
		"luck":
			pass
		"speed":
			pass
		"action_point":
			pass

func _on_action_1_pressed() -> void:
	disable_button()
	handle_button(act1_func)
	action_point -= 1
	act_1_timer.play()

func _on_action_2_pressed() -> void:
	disable_button()
	handle_button(act2_func)
	action_point -= 1
	act_2_timer.play()

func _on_action_3_pressed() -> void:
	disable_button()
	handle_button(act3_func)
	action_point -= 1
	act_3_timer.play()

func _on_act_timer_animation_finished() -> void:
	refresh_button()
	print("[行动点]: %s" % [action_point])
	if action_point > 0:
		stats.action_points = action_point
	else:
		stats.action_points = stats.init_action_points
		Game.go_to_battle()
