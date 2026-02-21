extends Camera3D

@onready var defRot = rotation
@onready var defPos = position
var status = "table" # "table"
var t : Tween

func myTween():
	var t = get_tree().create_tween()
	t.set_parallel(true)
	t.set_ease(Tween.EASE_IN)
	t.set_trans(Tween.TRANS_QUAD)
	return t


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed():
			print(status)
			if Controller.arePressed("/z")   and status== "table":
				status = "window"; 
				if t && t.is_running(): t.stop();
				print(position)
				t = myTween()
				t.tween_property(self, "position", Vector3(0,2.502*0.7,1.2), 1.5)
				t.tween_property(self, "rotation", Vector3(0,0,0), 1.5)
				t.play()
				#if Controller.inStack("]q"):
					#pass
		if event.is_released():
			if t && not Controller.arePressed("/z") and status == "window":
				status = "table";
				if t.is_running(): t.stop();
				t = myTween()
				t.tween_property(self, "position", defPos, 1.5)
				t.tween_property(self, "rotation", defRot, 1.5)
				t.play()
			
		
