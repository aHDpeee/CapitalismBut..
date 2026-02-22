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
		# LEVEL 1!!!!
		0:
			%Keyboard.hideLetters("]q/z")
			%Keyboard.autoHide = ""
			await %Dialogue.dialog('Store? Here?')

			await timer(2)
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
			await timer(3)
			for i in range(len(%cameras.cameras)):
				%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
			%Words.AddWords({"GIVE":"LIVE"})
		1:
			await %Dialogue.dialog('Hey. What\'s wrong here?')
			await timer(2)
			await %Dialogue.dialog('What are you doing here?')
			await timer(2)
			var anss = await %Dialogue.dialog('Any prices..?', 50, ['NO', 'are they necessary?'])
			chooseLen = len(anss)
			print(anss[await choosed])
			await %Dialogue.dialog('...')
			await timer(2)
			await %Dialogue.dialog('Okay.. you sounds like devil..')
			for i in range(len(%cameras.cameras)):
				%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
			%Words.AddWords({"PRICES":"MICES"})
		# LEVEL 2!!!!!
		2:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			# ЧЕЛ ПРИХОДИТ
			var anss = await %Dialogue.dialog('Wow! How long has this place been here?', 50, ['I just opened up', 'Since the world began to exist'])
			chooseLen = len(anss)
			if anss[await choosed] == 'I just opened up':
				await %Dialogue.dialog('Oh! That\'s great!')
			else:
				await %Dialogue.dialog('Our world has only existed for a week, not that long.')
			await timer(2)
			await %Dialogue.dialog('So... What can I buy?')
			await timer(3)
			look_at_table()
			%Words.AddWords({"BUY":"GUY"})
		3:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog('Wait a minute. Did I hear that right?')
			await timer(2)
			await %Dialogue.dialog('Are you really doing this for free?!')
			await timer(2)
			await %Dialogue.dialog('You\'re mad. I don\'t think you\'ll last long.')
			await timer(2.5)
			# ЧЕЛ УХОДИТ
			look_at_table()
			%Words.AddWords({"FREE":"TREE"})
		# LEVEL 3!!!!!!
		4:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			# ЧЕЛ ПРИХОДИТ
			await %Dialogue.dialog('Hello there. This spot has a lot of potential. Shame to waste it.')
			await timer(3)
			var anss = await %Dialogue.dialog('Ever thought about selling this place?', 50, ['Nope.', 'For what?'])
			chooseLen = len(anss)
			if anss[await choosed] == 'Nope.':
				await %Dialogue.dialog('Think carefully!  I\'ll make it worth your while.')
			else:
				await %Dialogue.dialog('To make a real killing! Just think carefully about it.')
				await timer(2)
				await %Dialogue.dialog('You don\'t think I\'m offering you peanuts, do you?')
			await timer(2)
			look_at_table()
			%Words.AddWords({"THINK":"BLINK"})
		5:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog('This deal buys you four stores.')
			await timer(2)
			await %Dialogue.dialog('(In the woods)', 70)
			await timer(0.6)
			look_at_table()
			%Words.AddWords({"DEAL":"MEAL"})
		6:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog('I\'ll give you some time to think. I\'ll be back in two days. Just think about it carefully!')
			await timer(3.1)
			# ЧЕЛ УХОДИТ
			look_at_table()
			%Words.AddWords({"JUST":"MUST"})
		# LEVEL 4!!!!!!!!
		
		
# Привет, дорогуша! Вижу, у тебя тут магазин процветает, люди подходят.
# Расскажи мне, если не секрет, а сколько ты зарабатываешь?

# What the duck is "
	
#   было - GIVE/LIVE, PRICES/MICES, BUY/GUY, FREE/TREE, THINK/BLINK, DEAL/MEAL, JUST/MUST

#  будет -
		

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
			


func timer(time: float) -> void:
	await get_tree().create_timer(time).timeout
	
func look_at_table() -> void:
	"""
	Функция, опускающая все камеры на стол, йоу
	"""
	for i in range(len(%cameras.cameras)):
		%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
		 
