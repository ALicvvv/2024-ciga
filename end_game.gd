extends Control
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("end")
	await animation_player.animation_finished
	label.text = "整整" + str(Game.player_stats.gender) + "代人的生命！！"
	animation_player.play("end2")
	await animation_player.animation_finished
	animation_player.play("end3")


func quit() -> void:
	get_tree().quit()
