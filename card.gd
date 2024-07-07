extends Control

@onready var shadow: TextureRect = $Shadow
@onready var card_texture: TextureRect = $CardTexture
@export var angle_x_max: float = 15.0
@export var angle_y_max: float = 15.0
@export var max_offset_shadow: float = 50.0

const genshin_func_dict = {
	"越战越勇":preload("res://adds/cards/yuezhanyueyong.png"),
	"种马祝福":preload("res://adds/cards/zhongmazhufu.png"),
	"操作高手":preload("res://adds/cards/caozuogaoshou.png"),
	"大吃大补":preload("res://adds/cards/dachidabu.png"),
}
var tween_rot: Tween
var tween_hover: Tween
var tween_destory: Tween
var is_following_mouse: bool = false
var card_func
var card_func_lst: Array

signal mouse_press
signal mouse_release

func _ready() -> void:
	card_func_lst = genshin_func_dict.keys()
	card_func = card_func_lst.pick_random()
	print(card_func)
	card_texture.texture = genshin_func_dict[card_func]
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)

func _process(delta: float) -> void:
	handle_shadow(delta)
	follow_mouse(delta)

func follow_mouse(_delta: float) -> void:
	if not is_following_mouse:
		return
	var mouse_pos: Vector2 = get_global_mouse_position()
	global_position = mouse_pos - size / 2
	
func handle_shadow(_delta: float) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var distance: float = global_position.x - center.x
	shadow.position.x = lerp(0.0, max_offset_shadow * sign(distance), abs(distance / center.x))

func handle_mouse_click(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	if event.is_pressed():
		mouse_press.emit()
		is_following_mouse = true
	else:
		mouse_release.emit()
		is_following_mouse = false

func _on_gui_input(event: InputEvent) -> void:
	handle_mouse_click(event)
	if is_following_mouse:
		return
	if not event is InputEventMouse: 
		return
	var mouse_pos: Vector2 = get_local_mouse_position()
	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	
	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max,angle_x_max,lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(-angle_y_max,angle_y_max,lerp_val_y))
	
	card_texture.material.set_shader_parameter("x_rot", rot_x)
	card_texture.material.set_shader_parameter("y_rot", rot_y)

func _on_mouse_exited() -> void:
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(card_texture.material, "shader_parameter/x_rot", 0.0, 0.5)
	tween_rot.tween_property(card_texture.material, "shader_parameter/y_rot", 0.0, 0.5)
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale",Vector2(0.6,0.6), 0.5)

func _on_mouse_entered() -> void:
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale",Vector2(0.8,0.8), 0.5)

func destory() -> void:
	var genshin_index = card_func_lst.find(card_func)
	Game.player_stats.genshin_func.append(genshin_index)
	print("choose [%s | %s]"%[card_func, genshin_index])
	print("Now have %s"%[Game.player_stats.genshin_func])
	card_texture.use_parent_material = true
	if tween_destory and tween_destory.is_running():
		tween_destory.kill()
	tween_destory = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_destory.tween_property(material,"shader_parameter/dissolve_value", 0.0, 2.0).from(1.0)
	tween_destory.parallel().tween_property(shadow,"self_modulate:a",0.0,1.0)
