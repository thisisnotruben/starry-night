extends Node

var score: int = 0


func _ready():
	for node in get_tree().get_nodes_in_group("objective"):
		node.connect("score", self, "track_score")

func track_score(_score: int) -> void:
	score += _score
