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
			%Words.AddWords({"JUST":"DUST"})
		# LEVEL 4!!!!!!!!
		7:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			# приходит желательно баба
			await %Dialogue.dialog("Hi, sweetie! I see your little shop is doing great - people are coming by...")
			await timer(2)
			await %Dialogue.dialog("So, what's your take? If it's not a secret.", 50, ['What the duck is.. "take?"'])
			await timer(1)
			look_at_table()
			%Words.AddWords({"TAKE":"CAKE"})
		8:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog("What you mean, honey? Of course, i'm talking about income!")
			await timer(2)
			await %Dialogue.dialog("What's wrong with your face?.. Something wrong?..", 50, ["I don't know, what income is..."])
			await timer(2)
			await %Dialogue.dialog("AHHHHHH, COMMUNIST!!! RUN AWAY!!!!", 70)
			# не уходит чел, а прям убегает"
			await timer(1.5)
			look_at_table()
			%Words.AddWords({"RUN":"FUN"})
		# LEVEL 5!!!!!!!!!!
		9:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			# подходит мутный типок
			await %Dialogue.dialog("Hey! Yeah, you! Need to talk. Business.")
			await timer(2)
			look_at_table()
			%Words.AddWords({"BUSY":"MUSY"})
		10:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog("I need a place to sell some... sugar. Well, the sweety one, you know.")
			await timer(2)
			await %Dialogue.dialog("Can you help me out? I'll pay for that.", 50, ["Sell?.. Can we give it away for free?"])
			# экаран трясётся
			await %Dialogue.dialog("CAN WHAT?! ARE YOU SERIOUS?!", 70, ["I just think no one will *buy* sugar..."])
			await %Dialogue.dialog("W..Why?..", 50, ["Well... It's just that I'd only *buy* sugar if I could make snowmen out of it..."])
			await timer(4)
			# чел уходит
			await timer(1)
			look_at_table()
			%Words.AddWords({"CLIENT":"GLIENT"})
		# LEVEL SIX!!!!!!!!!!!!
		11:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			# приходит чел
			await %Dialogue.dialog("Uhh.. Hello?")
			await timer(1.5)
			var anss = await %Dialogue.dialog("I heard you're giving stuff away for free around here... Is that true?..", 50, ["Yes. That's true.", "Why are you all so surprised?"])
			chooseLen = len(anss)
			if anss[await choosed] == "Why are you all so surprised?":
				await %Dialogue.dialog("It's just... There's gotta be a catch...")
				await timer(2)
			await %Dialogue.dialog("Why??? What profit do you get from this?", 50, ["..."])
			await %Dialogue.dialog("My mom says there's no such thing as a free lunch.")
			await timer(2)
			# чел уходит
			look_at_table()
			%Words.AddWords({"PROFIT":"OUTFIT"})
		# LEVEL SIX-SEVEN!!!!!!!!!!!!!!
		12:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			# приходит чувачок
			await %Dialogue.dialog("Greetings, trader. Have mercy on me, and the Devs will have mercy on you.")
			await timer(3)
			await %Dialogue.dialog("Would you happen to have a coin for a poor man?", 50, ["No. I don't have any."])
			look_at_table()
			%Words.AddWords({"COIN":"JOIN"})
		13:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog("How dare you lie to me! You're a trader in a shop - you definitely have coins!")
			await %Dialogue.dialog("Give it to me now, or the Devs will punish you!", 50, ["But why you ask me for coins? Don't you have your own?"])
			await %Dialogue.dialog("You're bringing trouble upon yourself, boy! If you don't give me the money — then the Devs will forget about you after the jam and never come back to finish you!", 40, ['...'])
			await timer(2)
			await %Dialogue.dialog("You'll regret not giving me that money.")
			await timer(2)
			# чел уходит
			look_at_table()
			%Words.AddWords({"MONEY":"HONEY"})
		# LEVEL 8!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		14:
			%Words/makeView.add_child(Status.makeScene[Status.makeIndex].instantiate())
			await %Dialogue.dialog("")
			
			
#	x - готово; p - в процессe; n! - не начинали, а надо бы;
#   было - GIVE/LIVE - x, PRICES/MICES - x, BUY/GUY - x, FREE/TREE - x, THINK/BLINK - x, DEAL/MEAL - x, JUST/MUST - n!, TAKE/CAKE - x, RUN/FUN - x, BUSY/MUSY - x, CLIENT/GLIENT - x,
#   PROFIT/OUTFIT - n!, COIN/JOIN - n!, MONEY/HONEY - n!

#  будет - WEALTH/HEALTH, CASH/DASH
		

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
	"""
	Просто упрощённый вид обычного .timeout из годота, nothing special
	"""
	await get_tree().create_timer(time).timeout
	
func look_at_table() -> void:
	"""
	Функция, опускающая все камеры на стол, йоу
	"""
	for i in range(len(%cameras.cameras)):
		%cameras.lookAtTable(%cameras.cameras[i], %cameras.tweens[i])
		 
