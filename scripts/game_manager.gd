extends Node
@onready var hud: CanvasLayer = $"../HUD"
@onready var player: CharacterBody2D = %Player
var hud_shurikens = 0
func _ready():
	hud.get_node("GameOver").visible = false
func game_over():
	hud.get_node("GameOver").visible = true
	player.queue_free()
func _process(delta):
	if (Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene()	
	hud.get_node("ShurikensCounter").set_text(player.shurikens_count())
