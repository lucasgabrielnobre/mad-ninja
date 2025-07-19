extends Area2D

var direction : Vector2
const SPEED = 1
var player : Node2D
var game_manager : Node

func _ready():
	game_manager = get_tree().get_first_node_in_group("GameManager")
	player = get_tree().get_first_node_in_group("Player")
func _physics_process(_delta: float) -> void:
	global_position += direction * SPEED 
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		game_manager.enemy_died()
		body.queue_free()
	
