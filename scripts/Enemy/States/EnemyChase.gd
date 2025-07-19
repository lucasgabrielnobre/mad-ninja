extends Enemy
class_name EnemyChase



func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func PhysicsUpdate(delta):
	if is_instance_valid(player):
		var direction = player.global_position - enemy.global_position
		ray_cast.target_position = direction
		enemy.velocity = direction.normalized() * move_speed
		if ray_cast.get_collider() != player or ray_cast.target_position.length() > view_distance:
			Transitioned.emit(self, "idle")
	else:
		Transitioned.emit(self, "idle")
