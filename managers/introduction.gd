extends State

##changes if button is enabled(false) or disabled(true)
signal changeButton
##connects to textbox to tell text to largen text
signal emphasize

var dialogueCount 					= 0
var dialogue : Array[String] = ["Welcome!, its a pleasure to have a new face around here",#--------------------------------------0
								"lets not waste and get you started on how things work",#----------------------------------------1
								"first, turn around to the drink station, come back after you familiarized yourself",#-----------2
								"good, heres my order and... ",#-----------------------------------------------------------------3
								"Ah! thats right",#------------------------------------------------------------------------------4
								"our patrons are a bit... picky",#---------------------------------------------------------------5
								"so make",#--------------------------------------------------------------------------------------6
								"ABSOLUTELY",#-----------------------------------------------------------------------------------7
								"SURE",#-----------------------------------------------------------------------------------------8
								"that you follow the order to the letter",#------------------------------------------------------9
								"now, pick up the cup and finish the order",#---------------------------------------------------10
								"good job, it seems customers are coming so ill leave you to it today",#------------------------11
								"best of luck and welcome too",#----------------------------------------------------------------12
								]

var cup
var root
var viable 							= true
var moveOnScreen 			= 600
var textBoxMoveUp			= 531
@onready var textbox: Node2D 		= $textbox
@onready var temp_manager: Sprite2D = $"temp manager" 
@onready var timer: Timer = $Timer

func Enter():
	print("tutorial starting :u")
	textbox.changeDialogue.connect(advanceTutorial)
	root = get_tree().get_first_node_in_group("rooot")
	
	SignalBus.tutorialDrinkSubmit.connect(finishTutorial)
	SignalBus.swappedScreensTutorial.connect(advanceTutorial)

	var tween = get_tree().create_tween()
	tween.tween_property(temp_manager, "global_position", Vector2(temp_manager.global_position.x - moveOnScreen, temp_manager.global_position.y), .5)
	SignalBus.changeTutorialTextBox.emit(dialogue[dialogueCount])
	tween.tween_property(textbox, "global_position", Vector2(textbox.global_position.x, textBoxMoveUp),.5).set_ease(Tween.EASE_IN_OUT)
	
func Exit():
	pass
	
func update():
	pass
	
func changeDialogue():
	dialogueCount += 1
	if dialogueCount < dialogue.size():
		SignalBus.changeTutorialTextBox.emit(dialogue[dialogueCount])
		match dialogueCount:			
				
			2:
				#connects to textbox and disables pickable
				SignalBus.flashTextOnScreen.emit("spacebar")
				changeButton.emit(false)
			3:
				changeButton.emit(true)
			10:
				changeButton.emit(false)
				specialFunc()
			11:
				changeButton.emit(true)
	else:
		var tween = get_tree().create_tween()
		#title drop
		tween.tween_property(temp_manager, "global_position", Vector2(temp_manager.global_position.x + moveOnScreen, temp_manager.global_position.y), .5)
		tween.tween_property(textbox, "global_position", Vector2(textbox.global_position.x, textbox.global_position.y + textBoxMoveUp),.5).set_ease(Tween.EASE_IN_OUT)
		SignalBus.tutorialOver.emit()

func advanceTutorial():
	changeDialogue()
	
func finishTutorial(results : bool):
	if results:
		changeDialogue()
	else:
		SignalBus.changeTutorialTextBox.emit("You made a mistake, try again")
		specialFunc()
	
func specialFunc():
	var node = get_tree().get_first_node_in_group("rooot")
	node.createOrder()
	
