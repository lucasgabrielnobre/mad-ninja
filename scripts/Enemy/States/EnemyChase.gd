extends Enemy
class_name EnemyChase

@export var chase_timer : Timer
@export var navigation_agent : NavigationAgent2D
var lost : bool

func Enter():
	print("enter4")
	call_deferred("chase_setup")
	player = get_tree().get_first_node_in_group("Player")
func PhysicsUpdate(delta):
	if !is_instance_valid(player):
		Transitioned.emit(self, "idle")
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position = enemy.global_position
	var next_path_position = navigation_agent.get_next_path_position()
	enemy.velocity = current_agent_position.direction_to(next_path_position) * move_speed
	"""elif lost == false:
		var direction = player.global_position - enemy.global_position
		ray_cast.target_position = direction
		enemy.velocity = direction.normalized() * move_speed
		if ray_cast.get_collider() != player or ray_cast.target_position.length() > view_distance:
			chase_timer.start()
			lost = true
	elif chase_timer.is_stopped():
		Transitioned.emit(self, "idle")"""
		
func chase_setup():
	if player:
		navigation_agent.target_position = player.global_position
