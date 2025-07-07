extends Camera2D

#codigo para o camera offset (tipo enter the gungeon)
var desired_offset: Vector2
@export var min_offset = -100
@export var max_offset = 100
func _process(_delta: float) -> void:
	desired_offset = (get_global_mouse_position() - position) * 0.5
	desired_offset.x = clamp(desired_offset.x, min_offset, max_offset)
	desired_offset.y = clamp(desired_offset.y, min_offset/1.2, max_offset/1.2)
	global_position = get_parent().get_node("Player").global_position + desired_offset	
