extends Node

var states 						: Dictionary
@export var initialState 		: State
@export var currentState 		: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(Transition)
			
	if initialState:
		initialState.Enter()
		currentState = initialState
		
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
