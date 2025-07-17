extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 10.0

var stop_time := 1.0
var speed : float
var move_direction : Vector2
var wander_time : float



# funcao para criar os valores aleatorios
func randomize_wander():
	speed = move_speed
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	stop_time = randf_range(1,2)
func Enter():
	randomize_wander()
func Update(delta): 
	# functiona como um timer
	if wander_time > 0:
		wander_time -= delta
	else:
		speed = 0
		stop_time -= delta
		if stop_time <= 0:
			randomize_wander()
		
func Physics_Update(_delta):
	if enemy:
		enemy.velocity = move_direction * speed
