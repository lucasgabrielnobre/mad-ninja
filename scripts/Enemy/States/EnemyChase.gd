extends Enemy
class_name EnemyChase

@export var chase_timer : Timer
var lost : bool

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	lost = false
func PhysicsUpdate(delta):
	if !is_instance_valid(player):
		Transitioned.emit(self, "idle")
	elif lost == false:
		var direction = player.global_position - enemy.global_position
		ray_cast.target_position = direction
		enemy.velocity = direction.normalized() * move_speed
		if ray_cast.get_collider() != player or ray_cast.target_position.length() > view_distance:
			chase_timer.start()
			lost = true
	elif chase_timer.is_stopped():
		Transitioned.emit(self, "idle")
		
	
		
