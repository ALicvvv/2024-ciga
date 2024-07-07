extends Node

var is_dialog_played :bool
var stats:Player_Stats

@onready var dialogPath = preload("res://dialog/failed.dialogue")
@onready var dialogPath2 = preload("res://dialog/normal.dialogue")

func _ready():
	stats = Game.player_stats
	is_dialog_played = false
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)
	
func _process(delta):
	if not is_dialog_played:
		is_dialog_played = true
		if Game.is_first_failed:
			DialogueManager.show_dialogue_balloon(dialogPath,"first_time")
		else:
			DialogueManager.show_dialogue_balloon(dialogPath2,"normal")
	#print("[is first failed]: %s"%[Game.is_first_failed])



func _on_dialogue_manager_dialogue_ended(resource: DialogueResource) -> void:
	Game.is_first_failed = false
	#print("end!!!!!!!!!!!!!!!!!!!!!!!!!!")
	Game.change_scene("res://choose_Genshin.tscn")
	
	
