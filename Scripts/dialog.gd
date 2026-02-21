extends Control

@onready var lInstance = preload("res://Scenes/button.tscn")
var s =''

func _ready() -> void:
	dialog('blablabalblablablalblablbalb',  50.0, ['fert', 'gert', 'tert'])
	#await get_tree().create_timer(3).timeout
	#dialog('fucjk', 'itan', 50.0, ['reta', 'gerta', 'terta'])
	
func dialog(text: String, speed := 50.0, choose := []):
	#if name == '': s = '... \n'
	#else: s = 'name'+'\n'
	
	for i in range(0, len(text)):
		await get_tree().create_timer(1/speed).timeout
		s+=text[i]
		$VBox/DialogTextLabel.text = s
		
	if choose != []:
		for child in $VBox/Options.get_children():
			$VBox/Options.remove_child(child)
			child.queue_free()
			
		for i in range(0, len(choose)):
			var butt : Button = lInstance.instantiate()
			butt.text = choose[i]
			$VBox/Options.add_child(butt)
			butt.pres.connect(choosen)

func choosen(s1: String):
	print(s1)
	return s1
