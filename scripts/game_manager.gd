extends Node
@onready var hud: CanvasLayer = $"../HUD"
@onready var player: CharacterBody2D = %Player
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"
var hud_shurikens = 0
var enemies_count = 1
var current_level = LevelManager.current_level

var next_level = false
const FILE_LEVEL = "res://scenes/levels/Level"
var next_level_path = ""
func _ready():
	hud.get_node("GameOver").visible = false
	hud.get_node("NextLevel").visible = false
	enemies_count = get_tree().get_nodes_in_group("enemies").size()
	# codigo pro next level
	var current_scene_file = get_tree().current_scene.scene_file_path
	current_level = current_scene_file.to_int()
	var next_level_number = current_level + 1
	next_level_path  = FILE_LEVEL + str(next_level_number) + ".tscn"
func game_over():
	hud.get_node("GameOver").visible = true
	player.queue_free()
	canvas_modulate.color = "#a6a6a6"
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()	
	if Input.is_action_just_pressed("next_level") and next_level:
		LevelManager.current_level += 1
		get_tree().change_scene_to_file(next_level_path)
	if is_instance_valid(player):
		hud.get_node("ShurikensCounter").set_text(player.shurikens_count())
	if enemies_count < 1:
		next_level = true
		hud.get_node("NextLevel").visible = true
		canvas_modulate.color = "#a6a6a6"
func enemy_died():
	enemies_count -= 1
	if is_instance_valid(player):
		player.shurikens += 1
	
