extends Area2D

var direction : Vector2
const SPEED = 30

@onready var player = get_node("/root/Game/Player")


func _physics_process(delta: float) -> void:
	global_position += direction * SPEED 


func _on_body_entered(body: Node2D) -> void:
	# mudar para inimigo
	if body is not TileMapLayer:
		player.position = global_position
		body.queue_free()
	queue_free()
