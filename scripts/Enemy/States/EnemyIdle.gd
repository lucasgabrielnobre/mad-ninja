extends Enemy
class_name EnemyIdle

var stop_time : float
var speed : float
var move_direction : Vector2
var wander_time : float
@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var gun : Sprite2D
func randomize_wander():
	speed = move_speed # reset speed
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	stop_time = randf_range(1,2)
	if gun:
		handle_gun()
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
	if !enemy:
		return
	if enemy.is_on_wall() or enemy.is_on_ceiling() or enemy.is_on_floor():
		move_direction *= - 1
	enemy.velocity = move_direction * speed
	if is_instance_valid(player) and enemy:		
		field_of_view()	
		if enemy.velocity.x > 0:
			sprite.flip_h = false
		elif enemy.velocity.x < 0:
			sprite.flip_h = true
func field_of_view():
	if ray_cast:
		if is_instance_valid(player) and enemy:
			var direction = player.global_position - enemy.global_position
			ray_cast.target_position = direction
			if ray_cast.is_colliding():
				if ray_cast.get_collider() == player and ray_cast.target_position.length() < view_distance:
					alert_nearby_enemies(get_nearby_enemies(enemy))
					Transitioned.emit(self, "chase")
func handle_gun():
	var angle = move_direction.angle()
	# Calcula a posição na circunferência (raio 70) com base nesse ângulo
	var offset : Vector2
	offset = Vector2.RIGHT.rotated(angle) * 70.0
	if gun.name == "SMG":
		offset = Vector2.RIGHT.rotated(angle) * 40.0
	if move_direction.x > 0:
		gun.flip_v = false
	else:
		gun.flip_v = true
	gun.position = offset
	gun.rotation = offset.angle()
		
func get_nearby_enemies(origin: CharacterBody2D, radius: float = 200.0) -> Array:
	var enemies_in_radius = []
	var all_enemies = get_tree().get_nodes_in_group("enemies")  # Certifique-se de adicionar seus inimigos a esse grupo
	for enemy in all_enemies:
		if enemy == origin:  # Evita considerar o próprio personagem (caso esteja no grupo)
			continue
		
		if origin.global_position.distance_to(enemy.global_position) <= radius:
			enemies_in_radius.append(enemy)
	
	return enemies_in_radius

	
func alert_nearby_enemies(nearby : Array):
	for en in nearby:
		var current_state = en.get_node("StateMachine").current_state
		if current_state:
			current_state.Transitioned.emit(current_state, "chase")
