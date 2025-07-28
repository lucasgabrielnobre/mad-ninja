extends Area2D

var direction : Vector2
const SPEED = 30
var player : Node2D
var explosion_scene = preload("res://scenes/explosion.tscn")
var game_manager : Node
func _ready(): 
	game_manager = get_tree().get_first_node_in_group("GameManager")
	player = get_tree().get_first_node_in_group("Player")
func _physics_process(_delta: float) -> void:
	global_position += direction * SPEED 

func _on_area_entered(area: Area2D) -> void:
	if is_instance_valid(player):
		if area.is_in_group("enemies_area"):
			create_explosion(explosion_scene, area.global_position, direction)
			player.position = global_position
			player.get_node("AnimationPlayer").play("appear")
			game_manager.enemy_died("shuriken")
			area.get_parent().queue_free()
			queue_free()
	
func create_explosion(explosion_scene, origin : Vector2, direction):
	var explosion = explosion_scene.instantiate()
	explosion.global_position = origin
	explosion.emitting = true
	explosion.direction = direction
	get_tree().get_root().call_deferred("add_child", explosion)
