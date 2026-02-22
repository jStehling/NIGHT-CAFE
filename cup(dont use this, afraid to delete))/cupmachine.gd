extends Node


var origin : Vector2
var states : Dictionary
@export var initialState : State
@export var currentState : State
@onready var cup: Node2D = $".."
@onready var sprite: Sprite2D = $"../Sprite2D"

# fill of the cup
#represented by characters i.e. CMT = Coffee Milk Tea and llmo = Strong lavender, light mint, light orange
@export var mainFlavor 	: String
@export var subFlavor 	: String


func _ready() -> void:
	origin = sprite.global_position
	
	#----	WORLD REFERENCE	  ----#
	World.finished.connect(checkcup)
	#----	WORLD REFERENCE	  ----#
	
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

func checkcup(target : String):
	pass
