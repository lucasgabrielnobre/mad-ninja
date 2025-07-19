extends CharacterBody2D

func _physics_process(delta: float) -> void:
	move_and_slide()

"""
var speed = 20.0
var bullet_scene = preload("res://scenes/enemies/guns/bullet.tscn")
@onready var gun: Sprite2D = $Gun
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var game_manager: Node = get_node("/root/Level" + str(LevelManager.current_level) + "/GameManager")
var player : Node2D
func _ready(): 
	#sprite.play("idle")
	var player_path = "/root/Level" + str(LevelManager.current_level) +"/Player"
	if has_node(player_path):
		player = get_node(player_path)
		
func _on_timer_timeout() -> void:
	if is_instance_valid(player):
		gun.get_node("AnimationPlayer").play("shoot")
		var bullet = bullet_scene.instantiate() 
		bullet.position = gun.get_node("BulletLocation").global_position
		bullet.direction = (player.global_position - global_position).normalized()
		bullet.rotation = gun.rotation
		# subtrair posicao player e inimigo para pegar direcao
		get_tree().get_root().call_deferred("add_child", bullet)
"""
