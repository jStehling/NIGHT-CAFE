extends State

var moveOnScreen 			= 600
var textBoxMoveUp			= 531
@onready var temp_manager: Sprite2D = $"../../temp manager"
@onready var textbox: Node2D = $"../../textbox"

var dialogueCount 					= 0
var dialogue : Array[String] = ["Good to see you again",#---------------------------------------0
								"Im heading out but before I do I have to tell you something",#-1
								"there is a...",#-----------------------------------------------2
								"thing",#-------------------------------------------------------3
								"that will reach for the lights",#------------------------------4
								"I dont believe I need to say this but",#-----------------------5
								"do not let it turn off the lights",#---------------------------6
								"I left a... deterrant by the counter",#------------------------7
								"go ahead and grab it",#----------------------------------------8
								"good, now try using it on this target",#-----------------------9
								"great, im heading out now",#----------------------------------10
								"best of luck today, ill see you tommorow"]#-------------------11

func Enter():
	print("CurrentDay:", DaySystem.currentDay)
	var tween = get_tree().create_tween()
	var tween1 = get_tree().create_tween()
	tween.tween_property(temp_manager, "global_position", Vector2(temp_manager.global_position.x - moveOnScreen, temp_manager.global_position.y), .5)
	tween1.tween_property(textbox, "global_position", Vector2(textbox.global_position.x, textBoxMoveUp),.5).set_ease(Tween.EASE_IN_OUT)
	
	SignalBus.changeTutorialTextBox.emit(dialogue[dialogueCount])
	SignalBus.shotgunGrabbed.connect(changeDialogue)
	SignalBus.d2GunFired.connect(changeDialogue)
	SignalBus.advanceDialogue.connect(changeDialogue)
	
func changeDialogue():
	print("hello2")
	dialogueCount += 1
	if dialogueCount < dialogue.size():
		SignalBus.changeTutorialTextBox.emit(dialogue[dialogueCount])
		match dialogueCount:
			8:
				SignalBus.changeButton.emit(false)
			10:
				SignalBus.changeButton.emit(true)
			
	else:
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		#title drop
		tween.tween_property(temp_manager, "global_position", Vector2(temp_manager.global_position.x + moveOnScreen, temp_manager.global_position.y), .5)
		tween1.tween_property(textbox, "global_position", Vector2(textbox.global_position.x, textbox.global_position.y + textBoxMoveUp),.5).set_ease(Tween.EASE_IN_OUT)
		SignalBus.tutorialOver.emit()
		
		
func finishTutorial():
		changeDialogue()
