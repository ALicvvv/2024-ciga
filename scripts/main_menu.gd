extends Node

func _on_exit_pressed():
	get_tree().quit()


func _on_pressed():
	
	Game.new_game()
	
