extends Node

var is_dialog_played
var is_first_faild
# Called when the node enters the scene tree for the first time.
func _ready():
	is_dialog_played = false
	is_first_faild = true

func _process(_delta):
	if not is_dialog_played:
		is_dialog_played = true
		if is_first_faild:
			is_first_faild = false
			goto("first_time")
		else:
			goto("nomal")

func goto(title):
	DialogueManager.show_dialogue_balloon(load("res://dialog/failed.dialogue"),title)
