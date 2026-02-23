extends Node3D

var target_zones = {}
var placed_letters = {}

@export var position_fucked_uping: float = 0.2
@export var rotation_fucked_uping: float = 10.0 

func _ready():
	if 'test' in get_parent().name.to_lower():
		return
	setup_zones()
	setup_letter_signals()

func setup_zones():
	target_zones.clear()
	placed_letters.clear()

	for child in $".".get_children():
		if child is Area3D:
			var zone_name = child.name.to_lower()
			target_zones[zone_name] = {
				"area": child,
				"position": child.global_position,
				"rotation": child.global_rotation,
				"letter": zone_name[0],
				"occupied_by": null,
				"is_correct": false
			}
			setup_zone_signals(child, zone_name)

func setup_zone_signals(area: Area3D, zone_name: String):
	if area.is_connected("body_entered", _on_zone_body_entered):
		area.body_entered.disconnect(_on_zone_body_entered)
	if area.is_connected("body_exited", _on_zone_body_exited):
		area.body_exited.disconnect(_on_zone_body_exited)
	
	area.body_entered.connect(_on_zone_body_entered.bind(zone_name))
	area.body_exited.connect(_on_zone_body_exited.bind(zone_name))
	
	#print("Сигнал для зоны ", zone_name, " подключен! ID зоны: ", area.get_instance_id)

func setup_letter_signals():
	"""Подключаем сигналы букв для отслеживания вращения"""
	for letter in $"../Letters".get_children():
		if letter is RigidBody3D:
			if not letter.is_connected("integrated_forces", _on_letter_moved.bind(letter)):
				letter.integrated_forces.connect(_on_letter_moved.bind(letter))

func _on_zone_body_entered(body: Node, zone_name: String):
	if not (body is RigidBody3D and has_letter_property(body)):
		return
	var letter = body
	var letter_char = letter.letter
	var zone_info = target_zones[zone_name]
	
	print("Буква ", letter_char, " вошла в зону ", zone_name)
	check_letter_in_zone(letter, zone_name) if letter_char == zone_name else handle_wrong_letter_in_zone(letter, zone_name)
	
func _on_zone_body_exited(body: Node, zone_name: String):
	if not (body is RigidBody3D and has_letter_property(body)):
		return
	var letter = body
	var letter_char = letter.letter
	var zone_info = target_zones[zone_name]
	
	print("Буква ", letter_char, " вышла из зоны ", zone_name)
	
	if zone_info.occupied_by == letter:
		zone_info.occupied_by = null
		zone_info.is_correct = false
		placed_letters.erase(zone_name)
		
	check_complete_word()

func _on_letter_moved(letter: RigidBody3D):
	for zone_name in target_zones:
		var zone_info = target_zones[zone_name]
		if zone_info.occupied_by == letter:
			check_letter_rotation(letter, zone_name)
			break

func check_letter_in_zone(letter: RigidBody3D, zone_name: String):
	var zone_info = target_zones[zone_name]
	var letter_pos = letter.global_position
	var letter_rot = letter.global_rotation
	
	var pos_diff = zone_info.position.distance_to(letter_pos)
	var rot_diff = abs(zone_info.rotation.y - letter_rot.y)
	print("[РОТАЦИЯ ЙОООУ] - буква короче значит [", letter_rot.y, "], а должна быть значит [", zone_info.rotation.y, "], рахнгица - ", rot_diff)
	
	if pos_diff <= position_fucked_uping and rot_diff <= rotation_fucked_uping:
		handle_correct_letter(letter, zone_name)
	else:
		handle_attention_letter(letter, zone_name)

func check_letter_rotation(letter: RigidBody3D, zone_name: String):
	var zone_info = target_zones[zone_name]
	var rot_diff = abs(zone_info.rotation.y - letter.global_rotation.y)
	
	if rot_diff <= rotation_fucked_uping:
		if zone_info.is_correct == false:
			handle_correct_letter(letter, zone_name)
	else:
		if zone_info.is_correct == true:
			handle_attention_letter(letter, zone_name)

func handle_correct_letter(letter: RigidBody3D, zone_name: String):
	var zone_info = target_zones[zone_name]
	zone_info.occupied_by = letter
	zone_info.is_correct = true
	placed_letters[zone_name] = letter
	
	set_letter_state(letter, "attention")
	print("✅ Буква ", letter.letter, " правильно стоит в зоне ", zone_name)
	check_complete_word()

func handle_attention_letter(letter: RigidBody3D, zone_name: String):
	var zone_info = target_zones[zone_name]
	zone_info.occupied_by = letter
	zone_info.is_correct = false
	
	#set_letter_state(letter, "attention")
	print("Буква ", letter.letter, " уже в зоне ", zone_name, ", но нужен поворот")

func handle_wrong_letter_in_zone(letter: RigidBody3D, zone_name: String):
	"""В зоне неправильная буква"""
	var zone_info = target_zones[zone_name]
	
	set_letter_state(letter, "wrong")
	print("❌ Неправильная буква ", letter.letter, " в зоне ", zone_name)

func set_letter_state(letter: RigidBody3D, state: String):
	letter.changeType(state)

func has_letter_property(body: Node):
	return "letter" in body

func check_complete_word():
	if placed_letters.size() != target_zones.size():
		return
	
	for zone_name in target_zones:
		var zone_info = target_zones[zone_name]
		if not zone_info.is_correct:
			return

	on_word_completed()

func on_word_completed():
	await get_tree().create_timer(3)
	for letter in $"../Letters".get_children():
		if letter is RigidBody3D:
			letter.apply_central_impulse(Vector3.UP * 5)
			
	await get_tree().create_timer(3).timeout
	
	$"../..".clear()
	
	print("🎊 ПОБЕДА! Ты крут!")
	$"..".move = false
	$"../..".type = false
	$"../View".queue_free()
	Status.makeIndex += 1

func get_letter_in_zone(zone_name: String) -> Variant:
	if zone_name in target_zones:
		return target_zones[zone_name].occupied_by
	return null

func reset_all_zones():
	for zone_name in target_zones:
		var zone_info = target_zones[zone_name]
		zone_info.occupied_by = null
		zone_info.is_correct = false
	
	placed_letters.clear()
	
