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

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		#var c = (String.chr(event.unicode) if event.unicode else event.as_text()).to_lower()
		var c = String.chr(event.keycode).to_lower()
		#print(event.get_keycode_with_modifiers())
		if event.is_pressed():
			if keysstack[-1] != c:
				keysstack.remove_at(0); keysstack.append(c)
			if c not in keyspressed:
				print(c, String.chr(event.keycode), keyspressed)
				keyspressed.append(c)
			#print_debug(keyspressed)
			#print_debug(keysstack)
		else:
			#print(c, String.chr(event.keycode), keyspressed)
			keyspressed.erase(c)
		#if event.is_pressed() and not event.is_echo():
			#if arePressed("asd"): print("left")
			#if arePressed("l;'"): print("right")	
