extends Camera2D
# evitar erros de player não encontratado
var player : Node2D
func _ready():
	if has_node("/root/Game/Player"):
		player = get_node("/root/Game/Player")
#codigo para o camera offset (tipo enter the gungeon)
var desired_offset: Vector2
@export var min_offset = -100
@export var max_offset = 100
func _process(_delta: float) -> void:
	desired_offset = (get_global_mouse_position() - position) * 0.5
	desired_offset.x = clamp(desired_offset.x, min_offset, max_offset)
	desired_offset.y = clamp(desired_offset.y, min_offset/1.2, max_offset/1.2)
	if  is_instance_valid(player):
		global_position = player.global_position + desired_offset	
