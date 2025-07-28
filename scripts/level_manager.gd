extends Node

var current_level = 0
var score : Array[float] = []

func set_score(level, time):
	if score.size() <= level:
		score.resize(level + 1)
	score[level] = time
