extends Control

@onready var genshin_impact = $Genshin_impact

func _ready():
	genshin_impact.hide()



func _on_dialog_scene_dialog_end():
	genshin_impact.show()
