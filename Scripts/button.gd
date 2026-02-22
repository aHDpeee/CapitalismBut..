extends Button

signal pres(txt:String)

func _on_pressed() -> void:
	button_pressed = true
	pres.emit(text)
	
func _on_released() -> void:
	button_pressed
