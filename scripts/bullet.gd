extends Area2D

var speed = 200
var direction : Vector2

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pass
	queue_free()
