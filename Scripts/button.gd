extends Button

signal pres(txt:String)

func _on_pressed() -> void:
	print(text)
	pres.emit(text)
