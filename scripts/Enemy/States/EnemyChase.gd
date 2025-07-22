extends Enemy
class_name EnemyChase

@export var chase_timer : Timer
@export var navigation_agent : NavigationAgent2D
var lost : bool
@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter():
	print("entrou")
	player = get_tree().get_first_node_in_group("Player")
	chase_timer.start()
func PhysicsUpdate(delta):
	if !is_instance_valid(player):
		Transitioned.emit(self, "idle")
	if chase_timer.is_stopped():
		Transitioned.emit(self, "idle")
	navigation()
	field_of_view()
func Update(delta):
	handle_sprite()
func navigation():
	if player:
		navigation_agent.target_position = player.global_position
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position = enemy.global_position
	var next_path_position = navigation_agent.get_next_path_position()
	enemy.velocity = current_agent_position.direction_to(next_path_position) * move_speed

func field_of_view():
	if is_instance_valid(player):
		var direction = player.global_position - enemy.global_position
		ray_cast.target_position = direction
		if ray_cast.is_colliding():
			if ray_cast.get_collider() == player and ray_cast.target_position.length() < view_distance:
				chase_timer.start()
func handle_sprite():
	if is_instance_valid(player):
		if player.global_position.x > enemy.global_position.x: 
			sprite.flip_h = false
		else:
			sprite.flip_h = true	
