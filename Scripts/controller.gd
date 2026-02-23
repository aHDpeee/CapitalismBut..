extends Node

@export var keyspressed = []
@export var keysstacklen = 10
@export var keysstack = []

func shouldBeKeysArr(str):
	var c = []
	if str is String:
		if "&" in str:
			for x in str.split("&"): c.append(x)
		else:
			for x in str: c.append(x)
		return c
	return str

func inStackInPlace(str: String):
	str = shouldBeKeysArr(str)
	
	var l = len(str)
	for x in range(1, l + 1):
		if keysstack[keysstacklen-x] != str[l-x]:
			return false
	return true and len(str)
func inStack(str : String):
	var l = len(str)
	var c = []
	for x in range(1, l + 1):
		c.append(keysstack[keysstacklen-x])
	#print(c)
	for x in str:
		if x not in c:
			return false
	return true and len(str)
func arePressed(str):
	str = shouldBeKeysArr(str)
	#print(str)
	#print(keyspressed)
	#print("")
	for x in str:
		if x not in keyspressed:
			#print(x)
			return false
	return true and len(str)

func _ready() -> void:
	for x in range(keysstacklen):
		keysstack.append("")
		
	DisplayServer.window_set_mouse_passthrough([])
	if OS.get_name() == "Web":
		JavaScriptBridge.eval("""
			var canvas = document.querySelector('canvas');
			canvas.setAttribute('tabindex', '0');
			canvas.focus();
		""")

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo:
			if event.ctrl_pressed and event.shift_pressed:
				match event.keycode:
					KEY_0:
						set_level_index(0)
					KEY_1:
						set_level_index(1)
					KEY_2:
						set_level_index(2)
					KEY_3:
						set_level_index(3)
					KEY_4:
						set_level_index(4)
					KEY_5:
						set_level_index(5)
					KEY_6:
						set_level_index(6)
					KEY_7:
						set_level_index(7)
					KEY_8:
						set_level_index(8)
					KEY_9:
						set_level_index(9)
					KEY_F1:
						set_level_index(10)
					KEY_F2:
						set_level_index(11)
					KEY_F3:
						set_level_index(12)
					KEY_F4:
						set_level_index(13)

		#var c = (String.chr(event.unicode) if event.unicode else event.as_text()).to_lower()
		var c = String.chr(event.keycode).to_lower()
		#print(event.get_keycode_with_modifiers())
		if event.is_pressed():
			if keysstack[-1] != c:
				keysstack.remove_at(0); keysstack.append(c)
			if c not in keyspressed:
				#print(c, String.chr(event.keycode), keyspressed)
				keyspressed.append(c)
			#print_debug(keyspressed)
			#print_debug(keysstack)
		else:
			#print(c, String.chr(event.keycode), keyspressed)
			keyspressed.erase(c)
		#if event.is_pressed() and not event.is_echo():
			#if arePressed("asd"): print("left")
			#if arePressed("l;'"): print("right")	


func set_level_index(index: int) -> void:
	"""
	Меняет индекс уровня, предсавленных в dialog_node.gd
	"""
	Status.makeIndex = index
	get_tree().reload_current_scene()
