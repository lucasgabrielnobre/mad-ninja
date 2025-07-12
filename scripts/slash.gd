extends Area2D

var direction : Vector2
const SPEED = 1
var player : Node2D
func _ready():
	if has_node("/root/Game/Player"):
		player = get_node("/root/Game/Player")
func _physics_process(delta: float) -> void:
	global_position += direction * SPEED 

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		player.plus_shuriken()
		body.queue_free()
	
