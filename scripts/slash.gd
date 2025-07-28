extends Area2D

var direction : Vector2
const SPEED = 4
var player : Node2D
var game_manager : Node
var camera : Camera2D
var explosion_scene = preload("res://scenes/explosion.tscn")
func _ready():
	#camera = get_tree().get_first_node_in_group("Camera")
	game_manager = get_tree().get_first_node_in_group("GameManager")
	player = get_tree().get_first_node_in_group("Player")
func _physics_process(_delta: float) -> void:
	global_position += direction * SPEED 
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
func _on_body_entered(body: Node2D) -> void:
	if game_manager:
		if body.is_in_group("enemies"):
			game_manager.enemy_died("slash")
			create_explosion(explosion_scene, body.global_position, direction)
			body.queue_free()
	
func create_explosion(explosion_scene, origin : Vector2, direction):
	var explosion = explosion_scene.instantiate()
	explosion.global_position = origin
	explosion.emitting = true
	explosion.direction = direction
	get_tree().get_root().call_deferred("add_child", explosion)
