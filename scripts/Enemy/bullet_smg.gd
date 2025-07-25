extends Area2D

var speed = 400.0
var direction : Vector2
@onready var game_manager: Node = get_node("/root/Level" + str(LevelManager.current_level) + "/GameManager")
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if is_instance_valid(game_manager) and !game_manager.is_player_invicible():	
			game_manager.game_over()
			queue_free()
	elif body is TileMapLayer:
		queue_free()
