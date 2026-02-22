extends Node3D

var chooseLen : int
signal choosed(index : int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../SubViewportContainer/cameras".fixed.connect(f)

func f():
	await get_tree().create_timer(0.1)
	match Status.makeIndex:
		0:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			%Dialogue.dialog('Store? Here?')
			await get_tree().create_timer(2).timeout
			var anss = await %Dialogue.dialog('I\'ve never seen it before',  50.0, ['fdfdsadf', 'asdasdsad'])
			chooseLen = len(anss)
			print(anss[await choosed])
			%Dialogue.dialog('Just... Give me something?')
			for i in range(len(%cameras.cameras)):
				%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
			%Words.AddWords({"GIVE":"LIVE"})
		1:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog('Hey. What\'s wrong here?')
			await get_tree().create_timer(2).timeout
			await %Dialogue.dialog('What are you doing here?')
			await get_tree().create_timer(2).timeout
			var anss = await %Dialogue.dialog('Any prices..?', 50, ['NO', 'are they necessary?'])
			chooseLen = len(anss)
			print(anss[await choosed])
			await %Dialogue.dialog('...')
			await get_tree().create_timer(2).timeout
			await %Dialogue.dialog('Okay.. you sounds like devil..')
			for i in range(len(%cameras.cameras)):
				%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
			%Words.AddWords({"PRICES":"MICES"})
	

func whichChoosed(n : int):
	match n:
		1:
			if Controller.inStack("gjh"):
				return 0
		2:
			if Controller.inStack("gh"):
				return 0
			if Controller.inStack("jh"):
				return 1
		3:
			if Controller.inStack("g"):
				return 0
			if Controller.inStack("h"):
				return 1
			if Controller.inStack("j"):
				return 2
	return -1
			 
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var r = whichChoosed(chooseLen)
		if r != -1:
				choosed.emit(r)


		 
