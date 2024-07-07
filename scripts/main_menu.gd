extends Node

func _on_exit_pressed():
	get_tree().quit()


func _on_pressed():
	Game.is_first_failed = true
	Game.new_game()

func _on_exit_2_pressed():
	Game.change_scene("res://scene/lst.tscn")
