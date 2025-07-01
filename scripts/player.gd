extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite2D
@export var speed = 500.0

func _process(delta):
	#movimento
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction.normalized() * speed * delta
	#flip do sprite
	sprite.flip_h = get_global_mouse_position().x < position.x
	#tiro
	if (Input.is_action_just_pressed("shoot")):
		print("shoot")
	
