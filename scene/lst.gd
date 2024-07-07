extends Control

@onready var timer = $Timer

func _ready():
	timer.start()


func _on_time_out() -> void:
	Game.change_scene("res://scene/main_menu.tscn")
