extends Node
@onready var hud: CanvasLayer = $"../HUD"
@onready var player: CharacterBody2D = %Player
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"
@onready var invicibility_timer: Timer = $InvicibilityTimer
var explosion_scene = preload("res://scenes/explosion.tscn")
var level_timer: Timer
var time_completion : float
var enemies_count = 1
var current_level = LevelManager.current_level
var player_invicible = false
var next_level = false
const FILE_LEVEL = "res://scenes/levels/Level"
var next_level_path = ""
func _ready():
	level_timer = get_tree().get_first_node_in_group("LevelTimer")
	if level_timer:
		level_timer.connect("timeout", Callable(self, "_on_level_timer_timeout"))
	hud.get_node("GameOver").visible = false
	hud.get_node("NextLevel").visible = false
	enemies_count = get_tree().get_nodes_in_group("enemies").size()
	# codigo pro next level
	var current_scene_file = get_tree().current_scene.scene_file_path
	current_level = current_scene_file.to_int()
	var next_level_number = current_level + 1
	next_level_path  = FILE_LEVEL + str(next_level_number) + ".tscn"
func game_over():
	if level_timer:
		level_timer.stop()
	if next_level != true:
		create_explosion_player(explosion_scene, player.global_position)
		hud.get_node("GameOver").visible = true
		player.queue_free()
		canvas_modulate.color = "#a6a6a6"
func _process(_delta):
	format_time(level_timer)
	input_Manager()
	if is_instance_valid(player):
		hud.get_node("ShurikensCounter").set_text(player.shurikens_count())
	if enemies_count < 1:
		if !level_timer.is_stopped():
			time_completion = level_timer.wait_time - level_timer.time_left
			level_timer.stop()
		next_level = true
		hud.get_node("GameOver").visible = false
		hud.get_node("TimeOver").visible = false
		hud.get_node("NextLevel").visible = true
		canvas_modulate.color = "#d4d4d4"
	
func enemy_died(attack):
	enemies_count -= 1
	if is_instance_valid(player):
		if attack == "shuriken":
			player_invicible = true
			invicibility_timer.start()
		player.shurikens += 1
func change_levels(number):
	LevelManager.current_level = number
	number = str(number)
	await get_tree().create_timer(0.1).timeout
	scene_manager.change_scene(get_tree().current_scene, number, "level")
func input_Manager():
	if Input.is_action_just_pressed("reset"):
		var number = str(LevelManager.current_level)
		scene_manager.change_scene(get_tree().current_scene, number, "level")
	if Input.is_action_just_pressed("next_level") and next_level:
		LevelManager.set_score(LevelManager.current_level, time_completion)
		LevelManager.current_level += 1
		var number = str(LevelManager.current_level)
		scene_manager.change_scene(get_tree().current_scene, number, "level")
	if Input.is_key_pressed(KEY_0):
		change_levels(0)
	if Input.is_key_pressed(KEY_1):
		change_levels(1)
	if Input.is_key_pressed(KEY_2):
		change_levels(2)
	if Input.is_key_pressed(KEY_3):
		change_levels(3)
	if Input.is_key_pressed(KEY_4):
		change_levels(4)
	if Input.is_key_pressed(KEY_5):
		change_levels(5)
	if Input.is_key_pressed(KEY_6):
		change_levels(6)
	if Input.is_key_pressed(KEY_7):
		change_levels(7)
	if Input.is_key_pressed(KEY_8):
		change_levels(8)
	if Input.is_key_pressed(KEY_9):
		change_levels(9)
func is_player_invicible():
	return player_invicible
func format_time(timer : Timer):
	if !timer:
		return
	if !timer.is_stopped():
		var time_left = timer.time_left
		var seconds = int(time_left) % 60
		var milliseconds = int((time_left - int(time_left)) * 100)
		var formatted_time = "%02d:%02d" % [seconds, milliseconds]
		hud.get_node("LevelTimer").text = formatted_time
func _on_invicibility_timer_timeout() -> void:
		player_invicible = false
func _on_level_timer_timeout() -> void:
	hud.get_node("GameOver").visible = false
	hud.get_node("NextLevel").visible = false
	hud.get_node("TimeOver").visible = true
	canvas_modulate.color = "#a6a6a6"
	if player:
		player.queue_free()
func create_explosion_player(explosion_scene, origin : Vector2):
	var explosion = explosion_scene.instantiate()
	explosion.global_position = origin
	explosion.emitting = true
	explosion.spread = 180
	explosion.color = "bbffbb"
	explosion.amount = 16
	get_tree().get_root().call_deferred("add_child", explosion)
