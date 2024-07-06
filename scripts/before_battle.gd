extends Node

@export_group("骑士组")
@export var knight_yellow: PackedScene
@export var knight_blue: PackedScene
@export var knight_red: PackedScene
@export var knight_purple: PackedScene

@onready var player_location: Marker2D = $PlayerLocation

const pawn_dict ={
	"yellow": preload("res://scene/player/pawn/player_pawn_yellow.tscn"),
	"red": preload("res://scene/player/pawn/player_pawn_red.tscn"),
	"blue": preload("res://scene/player/pawn/player_pawn_blue.tscn"),
	"purple": preload("res://scene/player/pawn/player_pawn_purple.tscn"),
}
var pawn_lst = ["yellow", "red", "blue","purple"]
var knight_lst = [knight_yellow, knight_blue, knight_red, knight_purple]
var stats: Stats

func _ready() -> void:
	stats = Game.player_stats
	var color = pawn_lst.pick_random()
	var player_scene: PackedScene = pawn_dict[color]
	var player = player_scene.instantiate()
	player.position = player_location.position
	add_child(player)
