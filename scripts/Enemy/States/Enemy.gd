extends State
class_name Enemy

@export var enemy : CharacterBody2D
@export var ray_cast : RayCast2D
@export var move_speed := 10.0
@export var view_distance := 600.0
var player : CharacterBody2D
