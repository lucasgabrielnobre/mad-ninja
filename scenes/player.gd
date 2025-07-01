extends CharacterBody2D

@export var speed = 500.0
var screen_size

func ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction.normalized() * speed * delta
	
