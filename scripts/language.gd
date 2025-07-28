extends Control

func _on_pt_button_up() -> void:
	scene_manager.language = "pt"
	scene_manager.change_scene(get_tree().current_scene, "main_menu", "menu")
	
func _on_en_button_up() -> void:
	scene_manager.language = "en"
	scene_manager.change_scene(get_tree().current_scene, "main_menu", "menu")
