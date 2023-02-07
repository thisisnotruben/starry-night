extends Node
class_name Ship

export var speed = 20.0
var path_follow: PathFollow = null

onready var tween: Tween = $tween

func _ready() -> void:
	tween.connect("tween_completed", self, "start_movement")

func init(_path_follow: PathFollow) -> Node:
	path_follow = _path_follow
	start_movement(null, @"")
	return self

func start_movement(object: Object, key: NodePath) -> void:
	tween.interpolate_property(path_follow, "unit_offset",
		0.0, 1.0, speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
