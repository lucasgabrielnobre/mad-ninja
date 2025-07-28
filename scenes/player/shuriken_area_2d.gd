extends Area2D
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		$"..".queue_free()
