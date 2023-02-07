extends Spatial


func _ready() -> void:
	for child in get_children():
		var mesh = child.get_child(0).get_child(0)
		if mesh is MeshInstance:
			mesh.get_parent().remove_child(mesh)
			add_child(mesh)
			mesh.owner = self
		else:
			printerr(child, "-- didn't find mesh")

	var packed_scene = PackedScene.new()
	packed_scene.pack(self)
	ResourceSaver.save(filename.get_basename() + "_mesh.tscn", packed_scene)
