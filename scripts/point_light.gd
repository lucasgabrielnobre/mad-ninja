extends PointLight2D
var player : Node
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
func _process(delta: float) -> void:
	if player:
		global_position = player.global_position 
