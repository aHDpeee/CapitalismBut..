extends Node3D

var s = '' 
var banned = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l',
	'z', 'x', 'c', 'v', 'b', 'n', 'm', 'space']

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Node3D.words(['perpetuum', 'rotation', 'rejection', 'fighter', 'magnetometr', 'sight'], 1, $WordsMesh)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		$LineEditMesh.mesh.text = s.to_upper()
		#print_debug(event.as_text())
		if event.is_pressed() and not event.is_echo() and not event.get_modifiers_mask() and event.as_text().to_lower() in banned:
			s += String.chr(event.keycode).to_lower()
		if event.is_pressed() and not event.is_echo() and event.as_text() == 'Backspace' and len(s) > 0:
			s[-1] = ''
		if event.is_pressed() and not event.is_echo() and event.as_text() == 'Enter' and $Node3D.check($LineEditMesh):
			print_debug('correct')
			s = ''
			$Node3D.words(['perpetuum', 'rotation', 'rejection', 'fighter', 'magnetometr', 'sight'], 1, $WordsMesh)
