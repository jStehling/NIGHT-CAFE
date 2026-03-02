extends Node2D
class_name state_machine_state

var states 						: Dictionary
@export var initialState 		: State
@export var currentState 		: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(Transition)
			
func Enter():
	if initialState:
		initialState.Enter()
		currentState = initialState
		
func Exit():
	currentState = null
		
func _process(delta: float) -> void:
	if currentState:
		currentState.Update(delta)
		
func _physics_process(delta: float) -> void:
	if currentState:
		currentState.Physics_Update(delta)
		
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
	
