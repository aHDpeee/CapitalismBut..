extends Node3D

@onready var defRot
@onready var defPos
var status = "table" # "table"
var tweens = []
var cameras = []

func _ready() -> void:
	for x in get_parent().get_children():
		if x is SubViewport:
			cameras.append(x.get_node("Camera"))
			tweens.append(myTween())
	defPos = cameras[0].position
	defRot = cameras[0].rotation
	print(cameras)

func myTween():
	var t = get_tree().create_tween()
	t.set_parallel(true)
	t.set_ease(Tween.EASE_IN)
	t.set_trans(Tween.TRANS_QUAD)
	return t
	
func lookAtWindow(camera : Camera3D, t : Tween):
	status = "window"; 
	print(camera)
	if t && t.is_running(): t.stop();
	t = myTween()
	t.tween_property(camera, "position", Vector3(0,2.502*0.7,1.2), 1.5)
	t.tween_property(camera, "rotation", Vector3(0,0,0), 1.5)
	t.play()
	
func lookAtTable(camera : Camera3D, t : Tween):
	status = "table";
	if t && t.is_running(): t.stop();
	t = myTween()
	t.tween_property(camera, "position", defPos, 1.5)
	t.tween_property(camera, "rotation", defRot, 1.5)
	t.play()
				#if Controller.inStack("]q"):
					#pass
	
	


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed():
			if Controller.arePressed("/z")   and status== "table":
				for ct in range(len(cameras)):
					lookAtWindow(cameras[ct], tweens[ct])
		if event.is_released():
			if not Controller.arePressed("/z") and status == "window":
				for ct in range(len(cameras)):
					lookAtTable(cameras[ct], tweens[ct])
			
		
