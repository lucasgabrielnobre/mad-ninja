extends CharacterBody2D

var speed = 20.0
var bullet_scene = preload("res://scenes/enemies/guns/bullet_smg.tscn")
@onready var gun: Sprite2D = $SMG
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var game_manager: Node = get_node("/root/Level" + str(LevelManager.current_level) + "/GameManager")
var player : Node2D
func _ready(): 
	var player_path = "/root/Level" + str(LevelManager.current_level) +"/Player"
	if has_node(player_path):
		player = get_node(player_path)
func _process(delta: float) -> void:
	if (is_instance_valid(player)):
		gun.look_at(player.position) # arma mira no player
		# código para virar a arma
		if ((gun.global_rotation_degrees + 180) < 90):
			gun.flip_v = true
		elif ((gun.global_rotation_degrees + 180) > 270):
			gun.flip_v = true
		elif ((gun.global_rotation_degrees + 180) < 270):
			gun.flip_v = false
		# a arma vai sempre apontar pro player e a uma certa distancia do enemy_gun
		gun.position = (player.global_position - global_position).normalized() * 40.0
		if player.global_position.x < global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
func _on_timer_timeout() -> void:
	if is_instance_valid(player):
		gun.get_node("AnimationPlayer").play("shoot")
		var bullet = bullet_scene.instantiate() 
		bullet.position = gun.get_node("BulletLocation").global_position
		bullet.direction = (player.global_position - global_position).normalized()
		bullet.rotation = gun.rotation
		# subtrair posicao player e inimigo para pegar direcao
		get_tree().get_root().call_deferred("add_child", bullet)
