
##A state machine of state machines, every day is a state machine where every state is a new state of the tutorial
extends Node2D

var states 						: Dictionary
@export var initialState 		: state_machine_state
@export var currentState 		: state_machine_state


func _ready() -> void:
	DaySystem.startNewDay.connect(beginTutorial)

	for child in get_children():
		if child is state_machine_state:
			states[child.name] = child
	
	#will be removed later
	beginTutorial()

	
func beginTutorial() -> void:
	match DaySystem.currentDay:
		1:
			Transition("day1")
		2:
			print('day2')
			Transition("day2")
		
func Transition(newState : String) -> void:
	if !currentState:
		print("no current State")
	
	var nextState = states[newState]
	
	if !nextState:
		print("state does not exist\ncheck spelling")
	if currentState:
		currentState.Exit()
	
	currentState = nextState
	currentState.Enter()
	
	
	
