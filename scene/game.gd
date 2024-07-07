extends CanvasLayer


@onready var player_stats: Player_Stats = $Player_Stats
@onready var devil_1_stats: Monster_Stats = $Devil1_Stats
@onready var devil_2_stats: Monster_Stats = $Devil2_Stats
@onready var devil_3_stats: Monster_Stats = $Devil3_Stats

@onready var color_rect: ColorRect = $ColorRect

@export var current_devil: int = 0
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
	player_stats.health = player_stats.init_health
	player_stats.atk = player_stats.init_atk
	player_stats.def = player_stats.init_def
	player_stats.luck = player_stats.init_luck
	player_stats.critical = player_stats.init_critical
	player_stats.criticalDamage = player_stats.init_criticalDamage
	player_stats.speed = player_stats.init_speed
	player_stats.action_points = player_stats.action_points

func reSpawn() -> void:
	player_stats.gender += 1
	var genshin_3_count = player_stats.genshin_func.count(3)
	player_stats.init_health = player_stats.init_health * (1.2 + genshin_3_count * 0.06)
	player_stats.init_atk = player_stats.init_atk * (1.2 + genshin_3_count * 0.06)
	player_stats.init_def = player_stats.init_def * (1.2 + genshin_3_count * 0.06)
	player_stats.init_luck = player_stats.init_luck
	var lucky = randf()
	if lucky <= player_stats.init_luck:
		player_stats.init_critical = player_stats.init_critical * 1.2
		player_stats.init_criticalDamage = player_stats.init_criticalDamage * 1.2
		player_stats.init_speed = player_stats.init_speed * 1.1

func go_to_battle() -> void:
	player_stats.init_health = player_stats.health
	player_stats.init_atk = player_stats.atk
	player_stats.init_def = player_stats.def
	player_stats.init_luck = player_stats.luck
	player_stats.init_critical = player_stats.critical
	player_stats.init_criticalDamage = player_stats.criticalDamage
	player_stats.init_speed = player_stats.speed
	heal_devil()
	change_scene("res://scene/battle_scene.tscn")

func end_game() -> void:
	change_scene("res://end_game.tscn")

func heal_devil() -> void:
	devil_1_stats.health += (devil_1_stats.init_health - devil_1_stats.health) * 0.95
	devil_2_stats.health += (devil_2_stats.init_health - devil_2_stats.health) * 0.95
	devil_3_stats.health += (devil_3_stats.init_health - devil_3_stats.health) * 0.95
