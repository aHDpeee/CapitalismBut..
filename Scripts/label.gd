extends Node3D

func _ready() -> void:
	words(1)

func words(perk: int):
	
	var ans = ['perpetuum', 'rotation', 'rejection', 'fighter', 'magnetometr', 'sight']
	var ans3 = []
	
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
	$Label.set_text(s)
	
	if $LineEdit.get_text().to_lower() in ans3:
		return true

func _process(delta: float) -> void:
	pass
	
