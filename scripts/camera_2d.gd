extends Camera2D
var player : Node2D
var game_manager : Node
func _ready():
	game_manager = get_tree().get_first_node_in_group("GameManager")
	player = get_tree().get_first_node_in_group("Player")
var desired_offset: Vector2
@export var min_offset = -100
@export var max_offset = 100
func _process(_delta: float) -> void:
	desired_offset = (get_global_mouse_position() - position) * 0.5
	if Input.is_action_pressed("shift"):
		min_offset = -800
		max_offset = 800
		desired_offset = (get_global_mouse_position() - position) * 0.8
	if Input.is_action_just_released("shift"):
		min_offset = -100
		max_offset = 100
	desired_offset.x = clamp(desired_offset.x, min_offset, max_offset)
	desired_offset.y = clamp(desired_offset.y, min_offset/1.2, max_offset/1.2)
	if  is_instance_valid(player):
		global_position = player.global_position + desired_offset	
