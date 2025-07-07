extends CharacterBody2D

var speed = 20.0
var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var gun: Sprite2D = $Gun

func _process(delta: float) -> void:
	gun.look_at(%Player.position)
	if ((gun.global_rotation_degrees + 180) < 90):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) > 270):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) < 270):
		gun.flip_v = false
	
	
func _on_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate() 
	bullet.position = gun.get_node("BulletLocation").global_position
	bullet.direction = (%Player.global_position - global_position).normalized()
	bullet.rotation = gun.rotation
	# subtrair posicao player e inimigo para pegar direcao
	get_tree().get_root().call_deferred("add_child", bullet)
