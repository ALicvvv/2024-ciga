extends CanvasLayer


@onready var player_stats: Player_Stats = $Player_Stats
@onready var color_rect: ColorRect = $ColorRect

@export var current_devil: int = 1
@export var player_color_cur: String = "yellow"
@export var player_color_before: String = "yellow"


func _ready() -> void:
	color_rect.color.a = 0
	
func change_scene(path) -> void:
	var duration = 0.2
	var tree = get_tree()
	tree.paused = true
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, "color:a", 1, duration)
	await tween.finished
	tree.change_scene_to_file(path)
	await tree.tree_changed
	tree.paused = false
	tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(color_rect, "color:a", 0, duration)

func new_game() -> void:
	change_scene("res://scene/before_battle.tscn")

func go_to_battle() -> void:
	change_scene("res://scene/battle_scene.tscn")
