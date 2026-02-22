extends Node3D

var s = '' 
var sMesh = []
var type = false
var dic = {"LIVE":"GIVE", "GUY":"BUY", "BELL":"SELL", "WOW":"NOW", "MART":"START", "HONEY":"MONEY", \
	"JUST":"MUST", "LORE":"MORE", "BAITING":"WAITING"}
var banned = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l',
	'z', 'x', 'c', 'v', 'b', 'n', 'm', 'space']
var activeLetterIndex = -1
var rightWord : Dictionary

func _ready() -> void:
	$ToType.mesh.text = ""
	$ToType/ToType.mesh.text = ""
	#AddWords(['perpetuum', 'rotation', 'rejection', 'fighter', 'magnetometr', 'sight'], 1, $ToType)
	#AddWords(dic)
	pass

func AddWords(ans : Dictionary, perk: int = 1):
	var index = randi() % len(ans)
	$ToType.mesh.text = ans.values()[index]
	$ToType/ToType.mesh.text = ans.keys()[index]
	rightWord = {$ToType/ToType.mesh.text:$ToType.mesh.text}
	print(rightWord, ans)
	
func checkWords(object: MeshInstance3D):
	if object.mesh.text.to_upper() == rightWord.keys()[0]:
		return true


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() :
		#print_debug(event.as_text())
		if not event.get_modifiers_mask() and event.as_text().to_lower() in banned and len(s)<=9 and type:
			activeLetterIndex += 1
			sMesh.append($makeView.addLetter(\
			String.chr(event.keycode).to_lower(), activeLetterIndex-len($ToType.mesh.text)/2, 0,\
			$makeView/TypingArea.position+Vector3(0,1,0), $makeView/TypingArea.rotation).letter)
			s += String.chr(event.keycode).to_lower()
		if event.as_text() == 'Backspace' and activeLetterIndex >= 0 and type:
			$makeView/Letters.remove_child(sMesh[activeLetterIndex])
			$makeView/Letters.remove_child($makeView/Letters.get_child(activeLetterIndex))
			activeLetterIndex -= 1
			s[-1] = ''
		$JustTyped.mesh.text = s.to_lower()
		if type == true and checkWords($JustTyped):
			$makeView.move = true
			type = false
			#s = ''
			#print(sMesh)
			#for x in range(activeLetterIndex):
				#$makeView/Letters.remove_child(sMesh[-x])
			#activeLetterIndex = -1
			#AddWords(dic.values(), 1, $ToType)
