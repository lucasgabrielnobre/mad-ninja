extends CanvasLayer

var scenes_path = "res://scenes/"
var level_path = scenes_path + "levels/Level"
@onready var animation: AnimationPlayer = $TransitionAnimation
var last_scene_name : String

func change_scene(from, to_scene_name, type):
	last_scene_name = from.name
	var full_path = scenes_path  + to_scene_name + ".tscn"
	if type == "level":
		full_path = level_path + to_scene_name + ".tscn"
	animation.play("diamond_out")
	await animation.animation_finished
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	animation.play_backwards("diamond_out")
