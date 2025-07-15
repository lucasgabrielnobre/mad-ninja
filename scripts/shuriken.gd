extends Area2D

var direction : Vector2
const SPEED = 30
var player : Node2D
@onready var game_manager: Node = get_node("/root/Level" + str(LevelManager.current_level) + "/GameManager")
func _ready(): 
	var player_path = "/root/Level" + str(LevelManager.current_level) +"/Player"
	if has_node(player_path):
		player = get_node(player_path)
func _physics_process(delta: float) -> void:
	global_position += direction * SPEED 


func _on_body_entered(body: Node2D) -> void:
	if is_instance_valid(player):
		if body.is_in_group("enemies"):
			player.position = global_position
			player.get_node("AnimationPlayer").play("appear")
			game_manager.enemy_died()
			body.queue_free()
		queue_free()
