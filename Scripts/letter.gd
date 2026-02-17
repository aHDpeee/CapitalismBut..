extends MeshInstance3D

@export var letter = ""


func _ready() -> void:
	mesh.text = letter
	pass
	

func _process(delta: float) -> void:
	pass
