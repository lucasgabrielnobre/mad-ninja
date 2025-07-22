extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast: RayCast2D = $RayCast2D
var game_manager : Node
var player : CharacterBody2D
var speed = 80
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	game_manager = get_tree().get_first_node_in_group("GameManager")
func _physics_process(delta: float) -> void:
	move_and_slide()
	if velocity.length() > 0:
		sprite.play("walk")
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
		sprite.play("idle")
	if is_instance_valid(player):
		var player_direction = (player.global_position - global_position).normalized()
		velocity = player_direction * speed
		move_and_slide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.game_over()

func _process(delta):
	if is_instance_valid(player):
		if player.global_position.x < global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
