extends CharacterBody2D

var game_manager : Node
var slash : Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var shurikens = 0
var max_speed = 1500
var dash = 1000
const friction = 1000
var speed = 400

var shuriken_scene = preload("res://scenes/player/shuriken.tscn")
var slash_scene = preload("res://scenes/player/slash.tscn")
var direction = Vector2.ZERO
func ready():
	game_manager = get_tree().get_first_node_in_group("GameManager")
	var current_scene_file = get_tree().current_scene.scene_file_path
	print(current_scene_file)
func player_movement(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	if animation_player.current_animation != "appear":
		if direction != Vector2.ZERO:
			update_animation("walk")
		else:
			update_animation("idle")
	slash_physics(delta)
	velocity = direction * speed
	move_and_slide()
func _physics_process(delta: float) -> void:
	# movimentação
	player_movement(delta)
func _process(_delta):
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
func slashing():
	slash = slash_scene.instantiate()
	slash.game_manager = game_manager
	slash.direction = (get_global_mouse_position() - global_position).normalized()
	slash.position =  get_global_position() + slash.direction * 60
	slash.rotation =  (get_global_mouse_position() - global_position).angle()
	get_tree().get_root().call_deferred("add_child", slash)
func slash_physics(delta):
	if $SlashTimer.time_left > 0:
		return
	if Input.is_action_just_pressed("slash"):
		slashing()
		$SlashTimer.start()
func shurikens_count():
	return str(shurikens)
func update_animation(animation):
	animation_player.play(animation)
	
