extends Node2D

func _ready():
	var language = scene_manager.language
	scene_manager.turn_language(language)
	var huds = get_tree().get_nodes_in_group("HUD")
	for hud : CanvasLayer in huds:
		if !hud.is_in_group(language):
			hud.queue_free()
