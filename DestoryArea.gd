extends MarginContainer
@onready var area_2d: Area2D = $Area2D
@onready var card_1: Control = $"../Card1"
@onready var card_2: Control = $"../Card2"
@onready var card_3: Control = $"../Card3"


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().destory()
	card_1.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_2.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_3.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_card_mouse_press() -> void:
	area_2d.monitoring = false


func _on_card_mouse_release() -> void:
	area_2d.monitoring = true
