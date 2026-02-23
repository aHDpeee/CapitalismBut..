extends Control

var keys = "1234567890-=qwertyuiop[]asdfghjkl;'zxcvbnm,./"
var keysLetters : Dictionary = {}
var autoHide = "/z]q"

func _ready() -> void:
	var i = 0
	for row in %KeyboardRows.get_children():
		#if not row.visible:
			#i += row.get_child(0).get_child_count()-1
			#print(i)
			#continue
		for key in row.get_child(0).get_children():
			if key is Label:
				key.text = keys[i]
				key.modulate = Color(1,1,1,0)
				keysLetters[keys[i]] = key
				i += 1
	#print(keysLetters)
				
func showLetters(s : String):
	print(autoHide)
	for k in s:
		var t = create_tween()
		t.set_trans(t.TRANS_EXPO)
		t.set_ease(t.EASE_IN_OUT)
		t.tween_property(keysLetters[k], "modulate", Color(1,1,1,1), 1)
		keysLetters[k].modulate =  Color(1,1,1,1)
		
func hideLetters(s : String):
	for k in s:
		var t = create_tween()
		t.set_trans(t.TRANS_EXPO)
		t.set_ease(t.EASE_IN_OUT)
		t.tween_property(keysLetters[k], "modulate", Color(1,1,1,0), 1)
		

func _input(event: InputEvent) -> void:
	if event is InputEventKey and String.chr(event.keycode).to_lower() in keys and not event.is_echo():
		var k = String.chr(event.keycode).to_lower() 
		if event.is_pressed() :
			hideLetters(String.chr(event.keycode).to_lower())
			#keysLetters[String.chr(event.keycode).to_lower()].get_child(0).visible = 1
		elif event.is_released() and k in autoHide:
			showLetters(String.chr(event.keycode).to_lower())
			#keysLetters[String.chr(event.keycode).to_lower()].get_child(0).visible = 0
			
