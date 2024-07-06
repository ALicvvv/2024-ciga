extends CharacterBody2D

signal dHit(dDamge, target_hp)
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_stats: Player_Stats
var devil_Stats: Monster_Stats
var d_damge
func _ready() -> void:
	player_stats = Game.player_stats
	var cur_devil = Game.current_devil
	if cur_devil == 0:
		devil_Stats = Game.devil_1_stats
	elif cur_devil == 1:
		devil_Stats = Game.devil_2_stats
	else:
		devil_Stats = Game.devil_3_stats
	animation_player.play("idle")

func Battle_Devil() -> void:
	var isCritical = randf()
	d_damge = (devil_Stats.atk * devil_Stats.atk) /(devil_Stats.atk + player_stats.def)
	if isCritical < devil_Stats.critical:
		d_damge = d_damge * (1 + devil_Stats.criticalDamage)
	player_stats.health = player_stats.health - d_damge
	dHit.emit(d_damge, player_stats.health)
	print("[devil Damege]: %s | [player health]: %s" % [d_damge, player_stats.health])
