extends Control

@onready var hp_bar: TextureProgressBar = $TextureProgressBar

var devil_Stats:Monster_Stats
func _ready() -> void:
	var cur_devil = Game.current_devil
	if cur_devil == 0:
		devil_Stats = Game.devil_1_stats
	elif cur_devil == 1:
		devil_Stats = Game.devil_2_stats
	else:
		devil_Stats = Game.devil_3_stats
	hp_bar.value = 1
	devil_Stats.m_health_change.connect(update_health)

func update_health():
	hp_bar.value = devil_Stats.health / devil_Stats.init_health
