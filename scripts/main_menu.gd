extends Control

func _on_button_button_up() -> void:
	scene_manager.change_scene(get_tree().current_scene, str(0), "level")
