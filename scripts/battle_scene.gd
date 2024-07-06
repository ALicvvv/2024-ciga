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

var knight_lst = ["yellow"]
var player_stats = Game.player_stats
var cur_devil = Game.current_devil


func _ready() -> void:
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
	var p1_color = Game.player_color_cur
	var player1_scene: PackedScene = knight_dict[p1_color]
	var player1 = player1_scene.instantiate()
	player1.position = player_1.position
	add_child(player1)
	
