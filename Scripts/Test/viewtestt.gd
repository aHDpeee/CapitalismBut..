extends Node3D


func _ready() -> void:
	var v = $View
	for lsh in $View.get_children():
		var l = lsh.get_node("MeshInstance3D")
		l.mesh = TextMesh.new()
		l.visible = true
		l.mesh.text = lsh.name.to_lower()[0]
		lsh.get_node("shadow").hide()
