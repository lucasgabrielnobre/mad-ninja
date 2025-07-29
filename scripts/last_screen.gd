extends Control
	
func _ready():
	scene_manager.turn_language(scene_manager.language)
	var labels = get_node("Labels")
	var i = 0
	for label : Label in labels:
		label.text = str(i+1) + ":" + (scene_manager.score[i])
		i += 1
func _on_retry_button_up() -> void:
	scene_manager.change_scene(get_tree().current_scene, str(0), "level")
