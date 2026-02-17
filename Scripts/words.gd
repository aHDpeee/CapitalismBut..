extends Node3D

var s = '' 
var banned = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l',
	'z', 'x', 'c', 'v', 'b', 'n', 'm', 'space']

func _ready() -> void:
	AddWords(['perpetuum', 'rotation', 'rejection', 'fighter', 'magnetometr', 'sight'], 1, $ToType)

var ans3 = []
func AddWords(ans, perk: int, object: MeshInstance3D):
	
	ans3 = []
	while len(ans3) < 3:
		var n = randi() % len(ans)
		if ans[n] not in ans3:
			ans3.append(ans[n])
	#print_debug(ans3)
	
	var s = ''
	for i in ans3:
		var nums = []
		
		while len(nums) < int(len(i)/2 - perk):
			var x = randi() % len(i)
			if x not in nums:
				nums.append(randi() % len(i))
		
		for x in range(0, len(i)):
			if x in nums:
				i[x] = '_'
		s+=i+'\n'
	object.mesh.text = s
	
func checkWords(object: MeshInstance3D):
	if object.mesh.text.to_lower() in ans3:
		return true


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		$JustTyped.mesh.text = s.to_upper()
		#print_debug(event.as_text())
		if event.is_pressed() and not event.is_echo() and not event.get_modifiers_mask() and event.as_text().to_lower() in banned:
			s += String.chr(event.keycode).to_lower()
		if event.is_pressed() and not event.is_echo() and event.as_text() == 'Backspace' and len(s) > 0:
			s[-1] = ''
		if event.is_pressed() and not event.is_echo() and event.as_text() == 'Enter' and checkWords($JustTyped):
			print_debug('correct')
			s = ''
			AddWords(['perpetuum', 'rotation', 'rejection', 'fighter', 'magnetometr', 'sight'], 1, $ToType)
