extends Node

const devil_dict = {
	"devil1" = preload("res://scene/devil1.tscn"),
	"devil2" = preload("res://scene/devil2.tscn"),
	"devil3" = preload("res://scene/devil3.tscn"),
}

const knight_dict = {
	"yellow": preload("res://scene/player/knight/player_knight_yellow.tscn"),
}

@export var pdamage_node:PackedScene
@export var ddamage_node:PackedScene

@onready var player_1: Marker2D = $player1
@onready var player_2: Marker2D = $player2
@onready var enemy: Marker2D = $enemy
@onready var p_1_hp_panner: Control = $player1/p1_hp_panner
@onready var p_2_hp_panner: Control = $player2/p2_hp_panner
@onready var enemy_hp_panner: Control = $enemy/enemy_hp_panner
@onready var p_1_damge_pop: Marker2D = $p1_damge_pop
@onready var p_2_damage_pop: Marker2D = $p2_damage_pop
@onready var enemy_damage_pop: Marker2D = $enemy_damage_pop
@onready var player_stats = Game.player_stats

var knight_lst = ["yellow"]
var cur_devil = Game.current_devil
var devil_Stats: Monster_Stats
var player_1_animation: AnimationPlayer
var p1_damge
var player_2_animation: AnimationPlayer
var devil_animation: AnimationPlayer
var devil_damge

func _ready() -> void:
	p_1_hp_panner.hide()
	p_2_hp_panner.hide()
	enemy_hp_panner.hide()
	var devil: PackedScene
	print(cur_devil)
	if cur_devil == 0:
		devil = devil_dict["devil1"]
		devil_Stats = Game.devil_1_stats
	elif cur_devil == 1:
		devil = devil_dict["devil2"]
		devil_Stats = Game.devil_2_stats
	else:
		devil = devil_dict["devil3"]
		devil_Stats = Game.devil_3_stats
	var devil_instance = devil.instantiate()
	devil_instance.position = enemy.position
	add_child(devil_instance)
	enemy_hp_panner.show()
	devil_animation = devil_instance.get_node("AnimationPlayer")
	devil_instance.dHit.connect(handle_ddamage)
	devil_animation.play("attack")
	
	var p1_color = Game.player_color_cur
	var player1_scene: PackedScene = knight_dict[p1_color]
	var player1 = player1_scene.instantiate()
	player1.position = player_1.position
	add_child(player1)
	p_1_hp_panner.show()
	player_1_animation = player1.get_node("AnimationPlayer")
	player1.pHit.connect(handle_pdamage)
	player_1_animation.play("attack", -1, player_stats.speed)

func handle_pdamage(p_damge, dhealth) -> void:
	var position = enemy_damage_pop.position
	print("--------------------handle_pdamage--------------------")
	ppop_up(position, p_damge)
	if dhealth < 0:
		Game.current_devil += 1
		player_1_animation.play("idle")
		devil_animation.play("dead")
		await devil_animation.animation_finished
		Game.new_game()

func handle_ddamage(d_damge, phealth) -> void:
	var position = p_1_damge_pop.position
	print("--------------------handle_ddamage--------------------")
	dpop_up(position, d_damge)
	if phealth < 0:
		Game.reSpawn()
		devil_animation.play("idle")
		player_1_animation.play("dead")
		await player_1_animation.animation_finished
		Game.new_game()

func dpop_up(position:Vector2, damage:float):
	var damage_scene = pdamage_node.instantiate()
	var label: Label = damage_scene.get_node("Label")
	damage_scene.position = position
	label.text = str(int(damage))
	var tween = create_tween()
	tween.tween_property(damage_scene,"position",position + Vector2(randf_range(-1,1),-randf()) * 16,0.75)
	add_child(damage_scene)

func ppop_up(position:Vector2, damage:float):
	var damage_scene = ddamage_node.instantiate()
	var label: Label = damage_scene.get_node("Label")
	damage_scene.position = position
	if damage < 1:
		damage = 1
	label.text = str(int(damage))
	var tween = create_tween()
	tween.tween_property(damage_scene,
	"position",
	position + Vector2(randf_range(-1,1),-randf()) * 16,
	0.75)
	add_child(damage_scene)
