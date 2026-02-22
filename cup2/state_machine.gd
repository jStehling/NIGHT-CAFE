extends Node2D

var can_fill 					:= false

var mainFlavor 					: String
var subFlavor					: String

var origin 						: Vector2
var states 						: Dictionary
@export var initialState 		: State
@export var currentState 		: State

@onready var dragging	: Node = $dragging
@onready var label: RichTextLabel = $"../RichTextLabel"

func _ready() -> void:
	mainFlavor 	= ""
	subFlavor	= ""
	
	for node in get_tree().get_nodes_in_group("machines"):
		if node.has_signal("fill"):
			node.fill.connect(fill)
	
	origin = global_position
	
	
	dragging.valid_area.connect(valid_area)
	
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
	
func valid_area(valid : bool) -> void:
	can_fill = valid
	
func fill(type : int, flavor : String):
	if can_fill:
		if type == 0:
			mainFlavor += flavor + "\n"
		else:
			subFlavor += flavor + "\n"
			
		updateLabel()
	else:
		print("cannot fill")
		
func updateLabel():
	label.text = mainFlavor + subFlavor
