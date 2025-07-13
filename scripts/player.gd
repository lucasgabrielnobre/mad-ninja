extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var game_manager: Node = $"../GameManager"
var shurikens = 0
var max_speed = 1500
const friction = 1000
const dash = 10000

var speed = 400

var shuriken_scene = preload("res://scenes/shuriken.tscn")
var slash_scene = preload("res://scenes/slash.tscn")
var direction = Vector2.ZERO
func ready():
	var current_scene_file = get_tree().current_scene.scene_file_path
	print(current_scene_file)
func player_movement(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	slash_physics(delta)
	position += direction * speed * delta
	move_and_slide()
func _physics_process(delta: float) -> void:
	# movimentação
	player_movement(delta)
func _process(delta):
	#flip do sprite
	sprite.flip_h = get_global_mouse_position().x < position.x
	#tiro
	if (Input.is_action_just_pressed("shoot")):
		if shurikens > 0:
			shoot_shuriken()
			shurikens -= 1
func shoot_shuriken():
	var shuriken = shuriken_scene.instantiate() 
	shuriken.direction = (get_global_mouse_position() - global_position).normalized()
	shuriken.position = get_global_position() + shuriken.direction * 60
	get_tree().get_root().call_deferred("add_child", shuriken)
func slash():
	var slash = slash_scene.instantiate()
	slash.game_manager = game_manager
	slash.direction = (get_global_mouse_position() - global_position).normalized()
	slash.position =  get_global_position() + slash.direction * 60
	slash.rotation =  (get_global_mouse_position() - global_position).angle()
	get_tree().get_root().call_deferred("add_child", slash)
func slash_physics(delta):
	if $SlashTimer.time_left > 0:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
		velocity =  velocity.limit_length(max_speed)
	else:
		if Input.is_action_just_pressed("slash"):
			slash()
			$SlashTimer.start()
			velocity += (get_global_mouse_position() - global_position).normalized() * dash * delta * 2
func shurikens_count():
	return str(shurikens)
