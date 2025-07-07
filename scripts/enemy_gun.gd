extends CharacterBody2D

var speed = 200.0
var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var gun: Sprite2D = $Gun

func _process(delta: float) -> void:
	gun.look_at(%Player.position)
	print(gun.global_rotation_degrees + 180)
	if ((gun.global_rotation_degrees + 180) < 90):
		gun.flip_v = true
	elif ((gun.global_rotation_degrees + 180) < 270):
		gun.flip_v = false

"""
func _on_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate() 
	# subtrair posicao player e inimigo para pegar direcao
	get_tree().get_root().call_deferred("add_child", bullet)
"""
