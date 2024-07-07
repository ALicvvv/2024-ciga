extends Control

enum Gender{#for player
	CHILD, #0 <= age < 12
	YOUTH, #12 <= age < 24
	ADULT, #24 <= age < 50
	ELDER, #50 <= age < 60
}
signal button_ready

@onready var act_point_num: Label = $act_point/act_point_num
@onready var health_num: Label = $dataPannel/health/health_num
@onready var def_num: Label = $dataPannel/def/def_num
@onready var atk_num: Label = $dataPannel/atk/atk_num
@onready var critical_num: Label = $dataPannel/critical/critical_num
@onready var critical_damage_num: Label = $dataPannel/criticalDamage/criticalDamage_num
@onready var speed_num: Label = $dataPannel/speed/speed_num
@onready var luck_num: Label = $dataPannel/luck/luck_num

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
@onready var gender: Label = $gender
@export var stats: Player_Stats

var act1_func
var act2_func
var act3_func

var action_point: int
var bar_percentage: float

var promoted_properties_dict = {
	"hp" : ["吃奶","吃牛","提升意志"],
	"atk": ["打木桩","打石头"],
	"def": ["吞剑","搓盐"],
	"critical" : ["练太极"],
	"criticalDamage" : ["开爆"],
	"luck" : ["冥想","瀑布修行"],
	"speed" : ["手艺活","短跑"],
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
	stats.health_change.connect(update_hp)
	stats.atk_change.connect(update_atk)
	stats.def_change.connect(update_def)
	stats.critical_change.connect(update_critical)
	stats.criticalDamage_change.connect(update_critical_damage)
	stats.speed_change.connect(update_speed)
	stats.luck_change.connect(update_luck)
	stats.ap_change.connect(update_ap)
	gender.text = str(stats.gender)
	act_point_num.text = str(action_point)
	health_num.text = str(stats.health)
	atk_num.text = str(stats.atk)
	def_num.text = str(stats.def)
	critical_num.text = str(stats.critical * 100) + "%"
	critical_damage_num.text = str(stats.criticalDamage * 100) + "%"
	speed_num.text = str(stats.speed * 100)
	luck_num.text = str(stats.luck * 10)
	refresh_button()

#func update_age() -> void: #弃用
	#age_num.text = str(stats.age)
	#if 0 <= stats.age && stats.age < 12:
		#gender.text = "幼年"
	#elif 12 <= stats.age && stats.age < 24:
		#gender.text = "青年"
	#elif 24 <= stats.age && stats.age < 50:
		#gender.text = "成年"
	#else:
		#gender.text = "老年"

func update_ap() -> void:
	act_point_num.text = str(action_point)
func update_hp() -> void:
	health_num.text = str(stats.health)
func update_atk() -> void:
	atk_num.text = str(stats.atk)
func update_def() -> void:
	def_num.text = str(stats.def)
func update_critical() -> void:
	critical_num.text = str(stats.critical * 100) + "%"
func update_critical_damage() -> void:
	critical_damage_num.text = str(stats.criticalDamage * 100) + "%"
func update_speed() -> void:
	speed_num.text = str(stats.speed * 100)
func update_luck() -> void:
	luck_num.text = str(stats.luck * 10)

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
	print("-------------------------------------------------------")
	print(act1_func)
	print(act2_func)
	print(act3_func)
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
	print("[%s] - %s|%s|%s"%[act_label.name,act_label.text,act_func,act_value])
	return [act_func, act_value]

func show_fx(act_fx: AnimatedSprite2D, param) -> void:
	if param in base_properties_key:
		act_fx.play("idle")
	if param in other_properties_key:
		act_fx.play("other")
	if param in sp_properties_key:
		act_fx.play("sp")

func handle_genshin_0(count:int) -> void:
	stats.health = stats.health * (1 + 0.02 * count)
	stats.atk = stats.atk * (1 + 0.02 * count)
	stats.def = stats.def * (1 + 0.02 * count)
	stats.critical = stats.critical * (1 + 0.01 * count)
	stats.criticalDamage = stats.criticalDamage * (1 + 0.02 * count)
	stats.luck = stats.luck * (1 + 0.01 * count)
	stats.speed = stats.speed * (1 + 0.01 * count)

func handle_button(param: Array) -> void:
	var genshin_0_count = stats.genshin_func.count(0)
	var genshin_2_count = stats.genshin_func.count(2)
	var button_func = param[0]
	var button_value = param[1]
	match button_func:
		"hp" :
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.health += (button_value * (1 + 0.03 * genshin_2_count))
		"atk":
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.atk += (button_value * (1 + 0.03 * genshin_2_count))
		"def": 
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.def += (button_value * (1 + 0.03 * genshin_2_count))
		"critical": 
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.critical += (button_value * (1 + 0.02 * genshin_2_count))
		"criticalDamage":
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.criticalDamage += (button_value * (1 + 0.02 * genshin_2_count))
		"luck":
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.luck += (button_value * (1 + 0.01 * genshin_2_count))
		"speed":
			action_point -= 1
			handle_genshin_0(genshin_0_count)
			stats.speed += (button_value * (1 + 0.01 * genshin_2_count))
		"action_point":
			action_point += button_value

func _on_action_1_pressed() -> void:
	disable_button()
	handle_button(act1_func)
	act_1_timer.play()

func _on_action_2_pressed() -> void:
	disable_button()
	handle_button(act2_func)
	act_2_timer.play()

func _on_action_3_pressed() -> void:
	disable_button()
	handle_button(act3_func)
	act_3_timer.play()

func _on_act_timer_animation_finished() -> void:
	refresh_button()
	print("[行动点]: %s" % [action_point])
	if action_point > 0:
		stats.action_points = action_point
	else:
		stats.action_points = stats.init_action_points
		Game.go_to_battle()
