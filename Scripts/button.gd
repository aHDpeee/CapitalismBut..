extends Button

signal pres(txt:String)

func _on_pressed() -> void:
	pres.emit(text)
