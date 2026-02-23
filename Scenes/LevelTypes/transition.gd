extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t = create_tween()
	t.tween_property(self, "self_modulate", Color(0,0,0,0), 1)
	t.play()
