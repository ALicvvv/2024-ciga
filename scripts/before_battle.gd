extends Node

@onready var player_location: Marker2D = $PlayerLocation

const pawn_dict ={
	"yellow": preload("res://scene/player/pawn/player_pawn_yellow.tscn"),
}
var pawn_lst = ["yellow"]
var stats: Player_Stats = Game.player_stats

func _ready() -> void:
	var color = pawn_lst.pick_random()
	Game.player_color_cur = color
	var player_scene: PackedScene = pawn_dict[color]
	var player = player_scene.instantiate()
	player.position = player_location.position
	add_child(player)
