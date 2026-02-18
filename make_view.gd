extends Node3D

@onready var lInstance = preload("res://Scenes/letter.tscn")
var activeLetterIndex = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addWord("Hello")
func addWord(alf,row=0):
	for x in range(len(alf)):
		addLetter(alf[x],x-len(alf)/2,row)
		await get_tree().create_timer(0.5).timeout
func addLetter(alf,col=0,row=0):
		var l : RigidBody3D = lInstance.instantiate()
		l.letter = alf
		l.position.y = 1
		l.rotate_x(-PI*(0.45+randf()*0.15))
		l.get_node("Shape").mesh = l.get_node("Shape").mesh.duplicate()
		l.get_node("Shape/Outline").mesh = l.get_node("Shape/Outline").mesh.duplicate()
		$Letters.add_child(l)
		l.apply_central_force(Vector3((randf()-0.5)*0.3+col,0,(randf()-0.5)*0.25+row)*20)
		activeLetterIndex = $Letters.get_child_count()-1
		
		return col+1

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		Controller._input(event)
		var chi = $Letters.get_children()
		var achi : RigidBody3D = chi[activeLetterIndex]
		if event.is_pressed() and not event.is_echo():
			if Controller.inStack("asd") and Controller.arePressed("asd"): 
				achi.changeType("default")
				activeLetterIndex = (activeLetterIndex-1+$Letters.get_child_count()) % $Letters.get_child_count()
				chi[activeLetterIndex].changeType("focus")
			elif Controller.inStack("l;'") and Controller.arePressed("l;'"):
				achi.changeType("default")
				activeLetterIndex = (activeLetterIndex+1) % $Letters.get_child_count()
				chi[activeLetterIndex].changeType("focus")
		if 1:
			if Controller.arePressed("e"):
				achi.angular_velocity = Vector3(0,-120,0)
			if Controller.arePressed("o"):
				achi.angular_velocity = Vector3(0,120,0)
			if Controller.arePressed("p"):
				achi.apply_central_force(Vector3(1,0,-1)*50)
			if Controller.arePressed("w"):
				achi.apply_central_force(Vector3(-1,0,-1)*50)
			if Controller.arePressed(","):
				achi.apply_central_force(Vector3(1,0,1)*50)
			if Controller.arePressed("c"):
				achi.apply_central_force(Vector3(-1,0,1)*50)
			if Controller.arePressed("r"):
				get_tree().reload_current_scene()
			
