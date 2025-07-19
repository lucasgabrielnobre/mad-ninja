extends Enemy
class_name EnemyIdle

var stop_time : float
var speed : float
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	speed = move_speed # reset speed
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	stop_time = randf_range(1,2)
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()
	wander_time = 0
func Update(delta): 
	if wander_time > 0:
		wander_time -= delta
	else:
		speed = 0
		stop_time -= delta
		if stop_time <= 0:
			randomize_wander()
		
func PhysicsUpdate(_delta):
	if enemy:
		enemy.velocity = move_direction * speed
	if is_instance_valid(player):		
		var direction = player.global_position - enemy.global_position
		ray_cast.target_position = direction
		if ray_cast.is_colliding():
			if ray_cast.get_collider() == player and ray_cast.target_position.length() < view_distance:
				Transitioned.emit(self, "chase")
				

		
	
