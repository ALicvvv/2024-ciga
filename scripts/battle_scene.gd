extends Node

const devil_dict = {
	"devil1" = preload("res://scene/devil1.tscn"),
	"devil2" = preload("res://scene/devil2.tscn"),
	"devil3" = preload("res://scene/devil3.tscn"),
}

const knight_dict = {
	"yellow": preload("res://scene/player/knight/player_knight_yellow.tscn"),
}

@onready var player_1: Marker2D = $player1
@onready var player_2: Marker2D = $player2
@onready var enemy: Marker2D = $enemy
@onready var p_1_hp_panner: Control = $player1/p1_hp_panner
@onready var p_2_hp_panner: Control = $player2/p2_hp_panner
@onready var enemy_hp_panner: Control = $enemy/enemy_hp_panner

var knight_lst = ["yellow"]
var player_stats = Game.player_stats
var cur_devil = Game.current_devil

var player_1_animation: AnimationPlayer
var player_2_animation: AnimationPlayer
var devil_animation: AnimationPlayer

func _ready() -> void:
	p_1_hp_panner.hide()
	p_2_hp_panner.hide()
	enemy_hp_panner.hide()
	var devil: PackedScene
	print(cur_devil)
	if cur_devil == 0:
		devil = devil_dict["devil1"]
	elif cur_devil == 1:
		devil = devil_dict["devil2"]
	else:
		devil = devil_dict["devil3"]
	var devil_instance = devil.instantiate()
	devil_instance.position = enemy.position
	add_child(devil_instance)
	enemy_hp_panner.show()
	devil_animation = devil_instance.get_node("AnimationPlayer")

	
	var p1_color = Game.player_color_cur
	var player1_scene: PackedScene = knight_dict[p1_color]
	var player1 = player1_scene.instantiate()
	player1.position = player_1.position
	add_child(player1)
	p_1_hp_panner.show()
	player_1_animation = player1.get_node("AnimationPlayer")
	

