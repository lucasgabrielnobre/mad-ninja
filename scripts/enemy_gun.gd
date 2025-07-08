extends CharacterBody2D

var speed = 20.0
var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var gun: Sprite2D = $Gun
@onready var sprite_2d: Sprite2D = $Sprite2D


func _process(delta: float) -> void:
	gun.look_at(%Player.position) # arma mira no player
	# código para virar a arma
	if ((gun.global_rotation_degrees + 180) < 90):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) > 270):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) < 270):
		gun.flip_v = false
	# a arma vai sempre apontar pro player e a uma certa distancia do enemy_gun
	gun.position = (%Player.global_position - global_position).normalized() * 70.0
	if %Player.global_position.x < global_position.x:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
func _on_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate() 
	bullet.position = gun.get_node("BulletLocation").global_position
	bullet.direction = (%Player.global_position - global_position).normalized()
	bullet.rotation = gun.rotation
	# subtrair posicao player e inimigo para pegar direcao
	get_tree().get_root().call_deferred("add_child", bullet)
