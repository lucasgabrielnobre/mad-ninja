extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var game_manager = get_node("/root/Game/GameManager")
var speed = 80
var player : Node2D
func _ready():
	if has_node("/root/Game/Player"):
		player = get_node("/root/Game/Player")

func _process(delta):
	if is_instance_valid(player):
		if player.global_position.x < global_position.x:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		var player_direction = (player.global_position - global_position).normalized()
		position += player_direction * delta * speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.game_over()
