extends StaticBody2D

var finished 			: bool		= false
@onready var cupBrain 	: Node2D 	= $Statemachine
@onready var dragging	: Node 		= $Statemachine/dragging

signal checkDrink

func _ready() -> void:
	dragging.drinkSubmitted.connect(Drinksubmit)

func Drinksubmit():
	var flavor = cupBrain.mainFlavor + cupBrain.subFlavor
	finished = true
	#connects to world script
	checkDrink.emit(flavor)
	suicide()
	
func suicide():
	queue_free()
