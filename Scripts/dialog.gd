extends Node3D

var s =''

func _ready() -> void:
	dialog('blablabalblablablalblablbalb', '', 50.0, ['fert', 'gert', 'tert'])
	
func dialog(text: String, name := '', speed := 50.0, choose := []):
	if name == '': s = '... \n'
	else: s = 'name'+'\n'
	
	for i in range(0, len(text)):
		await get_tree().create_timer(1/speed).timeout
		s+=text[i]
		$DialogTextLabel.text = s
		
	if choose != []:
		for i in range(0, len(choose)):
			$ItemList.add_item(choose[i])
			$ItemList.sort_items_by_text()
	#$ItemList.is_anything_selected().connect()
