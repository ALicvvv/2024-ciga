extends Control

@onready var hp_bar: TextureProgressBar = $TextureProgressBar

var stats:Player_Stats
func _ready() -> void:
	stats = Game.player_stats
	hp_bar.value = 1
	stats.health_change.connect(update_health)

func update_health():
	hp_bar.value = stats.health / stats.init_health
