extends Enemy
class_name EnemySMGChase

@export var gun_timer : Timer
@export var chase_timer : Timer
@export var gun : Sprite2D
@export var sprite : AnimatedSprite2D
@export var navigation_agent : NavigationAgent2D
var bullet_scene = preload("res://scenes/enemies/guns/bullet_smg.tscn")
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	gun_timer.start()
	chase_timer.start()
func Exit():
	gun_timer.stop()
func Update(_delta):
	if !is_instance_valid(player):
		return
	handle_sprite()
	if gun_timer.is_stopped():
		shoot()
		gun_timer.start()
func PhysicsUpdate(_delta):
	if !is_instance_valid(player):
		Transitioned.emit(self, "idle")
	if chase_timer.is_stopped():
		Transitioned.emit(self, "idle")
	field_of_view()
	navigation()





func handle_sprite():
	gun.look_at(player.position)
	if ((gun.global_rotation_degrees + 180) < 90):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) > 270):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) < 270):
		gun.flip_v = false
	gun.position = (player.global_position - enemy.global_position).normalized() * 40.0
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
		get_tree().get_root().call_deferred("add_child", bullet)
func field_of_view():
	if is_instance_valid(player):
		var direction = player.global_position - enemy.global_position
		ray_cast.target_position = direction
		if ray_cast.is_colliding():
			if ray_cast.get_collider() == player and ray_cast.target_position.length() < view_distance:
				chase_timer.start()
func navigation():
	if player:
		navigation_agent.target_position = player.global_position
		if navigation_agent.is_navigation_finished():
			return
		if ray_cast.target_position.length() < 300.0 and ray_cast.get_collider() == player:
			enemy.velocity = (player.global_position - enemy.global_position).normalized() * (-move_speed)
		else:
			var current_agent_position = enemy.global_position
			var next_path_position = navigation_agent.get_next_path_position()
			enemy.velocity = current_agent_position.direction_to(next_path_position) * move_speed
