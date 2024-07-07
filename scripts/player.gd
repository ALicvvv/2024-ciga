extends CharacterBody2D

signal pHit(pDamge, target_hp)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer = $Timer


#@export var damage_node:PackedScene

var player_stats: Player_Stats
var devil_Stats: Monster_Stats
var p_damge
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

#func _input(event) -> void:
	#if event.is_action_pressed("test"):
		#pop_up()
#
#func pop_up():
	#var damage_scene = damage_node.instantiate()
	#damage_scene.position = position
	#var tween = create_tween()
	#tween.tween_property(damage_scene,"position",position + Vector2(randf_range(-1,1),-randf()) * 16,0.75)
	#add_child(damage_scene)

func Battle_Player() -> void:
	var isCritical = randf()
	p_damge = (player_stats.atk * player_stats.atk) /(player_stats.atk + devil_Stats.def)
	if isCritical < player_stats.critical:
		p_damge = p_damge * (1 + player_stats.criticalDamage)
	devil_Stats.health = devil_Stats.health - p_damge
	pHit.emit(p_damge, devil_Stats.health)
	print("[player Damege]: %s | [devil health]: %s" % [p_damge, devil_Stats.health])


func _on_timer_timeout() -> void:
	var time = randf_range(1, 5)
	timer.wait_time = time
	animation_player.play("attack")
	await animation_player.animation_finished
	animation_player.play("idle")
	timer.start()
