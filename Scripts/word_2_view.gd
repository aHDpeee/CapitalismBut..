extends Node3D

var letterInstans
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letterInstans = preload("res://Scenes/letter.tscn")
	while 1:
		await get_tree().create_timer(2).timeout
		var l = letterInstans.instantiate()
		l.position = Vector3(0,1,0)
		l.letter = "a"
		l.process_mode = Node.PROCESS_MODE_ALWAYS
		add_child(l)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
