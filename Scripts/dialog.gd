extends Node3D

@onready var lInstance = preload("res://Scenes/button.tscn")
var s =''

func _ready() -> void:
	dialog('blablabalblablablalblablbalb', '', 50.0, ['fert', 'gert', 'tert'])
	#await get_tree().create_timer(3).timeout
	#dialog('fucjk', 'itan', 50.0, ['reta', 'gerta', 'terta'])
	
func dialog(text: String, name := '', speed := 50.0, choose := []):
	if name == '': s = '... \n'
	else: s = 'name'+'\n'
	
	for i in range(0, len(text)):
		await get_tree().create_timer(1/speed).timeout
		s+=text[i]
		$DialogTextLabel.text = s
		
	if choose != []:
		for child in $VBoxContainer.get_children():
			$VBoxContainer.remove_child(child)
			child.queue_free()
			
		for i in range(0, len(choose)):
			var butt : Button = lInstance.instantiate()
			butt.text = choose[i]
			$VBoxContainer.add_child(butt)
			butt.pres.connect(choosen)

func choosen(s1: String):
	return s1
