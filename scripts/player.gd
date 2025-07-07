extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite2D
var speed = 500.0
var shuriken_scene = preload("res://scenes/shuriken.tscn")

func _physics_process(delta: float) -> void:
	# movimentação
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction.normalized() * speed * delta
	move_and_slide()

func _process(delta):
	#flip do sprite
	sprite.flip_h = get_global_mouse_position().x < position.x
	#tiro
	if (Input.is_action_just_pressed("shoot")):
		shoot_shuriken()
	if (Input.is_action_just_pressed("slay")):
		slay()
	if (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()	
func shoot_shuriken():
	var shuriken = shuriken_scene.instantiate() 
	shuriken.direction = (get_global_mouse_position() - global_position).normalized()
	shuriken.position = get_global_position() + shuriken.direction * 40
	get_tree().get_root().call_deferred("add_child", shuriken)

func slay():
	print("slay")
