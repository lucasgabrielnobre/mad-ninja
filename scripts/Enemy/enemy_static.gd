extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var game_manager: Node
var speed = 80
var player : Node2D
func _ready():
	game_manager = get_tree().get_first_node_in_group("GameManager")
	player = get_tree().get_first_node_in_group("Player")
func _process(_delta):
	if is_instance_valid(player):
		if player.global_position.x < global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.game_over()
