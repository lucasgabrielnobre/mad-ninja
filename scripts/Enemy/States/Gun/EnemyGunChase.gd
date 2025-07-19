extends Enemy
class_name EnemyGunChase

@export var timer : Timer
@export var gun : Sprite2D
@export var sprite : AnimatedSprite2D
var bullet_scene = preload("res://scenes/enemies/guns/bullet.tscn")
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	timer.start()
	
func Exit():
	timer.stop()
func Update(_delta):
	if !is_instance_valid(player):
		pass
	else:
		handle_sprite()
		if timer.is_stopped():
			shoot()
			timer.start()

func handle_sprite():
	gun.look_at(player.position) # arma mira no player
	# código para virar a arma
	if ((gun.global_rotation_degrees + 180) < 90):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) > 270):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) < 270):
		gun.flip_v = false
	# a arma vai sempre apontar pro player e a uma certa distancia do enemy_gun
	gun.position = (player.global_position - enemy.global_position).normalized() * 70.0
	if player.global_position.x < enemy.global_position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
func shoot():
	if is_instance_valid(player):
		gun.get_node("AnimationPlayer").play("shoot")
		var bullet = bullet_scene.instantiate() 
		bullet.position = gun.get_node("BulletLocation").global_position
		bullet.direction = (player.global_position - enemy.global_position).normalized()
		bullet.rotation = gun.rotation
		# subtrair posicao player e inimigo para pegar direcao
		get_tree().get_root().call_deferred("add_child", bullet)
