extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $Area2D
@onready var game_manager: Node = get_node("/root/Level" + str(LevelManager.current_level) + "/GameManager")
var speed = 80
var player : Node2D
func _ready():
	var player_path = "/root/Level" + str(LevelManager.current_level) +"/Player"
	if has_node(player_path):
		player = get_node(player_path)
	animation_player.play("walk")
func _process(delta):
	if is_instance_valid(player):
		if player.global_position.x < global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		var player_direction = (player.global_position - global_position).normalized()
		position += player_direction * delta * speed
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.game_over()
