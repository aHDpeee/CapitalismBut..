extends Node3D

var chooseLen : int
signal choosed(index : int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../SubViewportContainer/cameras".fixed.connect(f)
	await get_tree().create_timer(0.8)
	%Keyboard.showLetters("z/")
	%Hint.visible = false
	

func f():
	await get_tree().create_timer(0.1)
	%Hint.visible = true
	%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
	%Hint.texture = load(Status.hints[Status.makeIndex])
	match Status.makeIndex:
		0:
			%Keyboard.hideLetters("]q/z")
			%Keyboard.autoHide = ""
			await %Dialogue.dialog('Store? Here?')
			await get_tree().create_timer(2).timeout
			var anss = await %Dialogue.dialog('I\'ve never seen it before',  50.0, ['fdfdsadf', 'asdasdsad'])
			%Keyboard.autoHide = "hjg"
			%Keyboard.showLetters("hj")
			await get_tree().create_timer(0.1).timeout
			%Keyboard.hideLetters("hj")
			await get_tree().create_timer(0.1).timeout
			%Keyboard.showLetters("hg")
			chooseLen = len(anss)
			print(anss[await choosed])
			%Keyboard.autoHide = ""
			%Keyboard.hideLetters("ghj")
			get_tree().create_timer(1)
			await %Dialogue.dialog('Just... Give me something?')
			await get_tree().create_timer(4).timeout
			for i in range(len(%cameras.cameras)):
				%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
			%Words.AddWords({"GIVE":"LIVE"})
		1:
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
			var chi = %Dialogue.get_node("VBox/Options").get_children()
			print(chi)
			for b in len(chi):
				chi[b].button_pressed = b == r
			await get_tree().create_timer(0.2).timeout
			choosed.emit(r)
			


		 
