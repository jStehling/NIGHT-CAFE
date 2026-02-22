extends State

var active 		: bool
var droppable 	: bool
var finished	: bool
@onready var cup: StaticBody2D = $"../.."
@onready var statemachine: Node2D = $".."

signal valid_area
signal drinkSubmitted

func Enter():
	#print("entering dragging")
	active 		= true
	droppable 	= false
	
func Exit():
	#print("exiting dragging")
	active = false
	droppable = false

func Update(_delta) -> void:
	if Input.is_action_pressed("click"):
		cup.global_position = cup.get_global_mouse_position()
	
	if droppable and Input.is_action_just_released("click"):
		if !finished:
			#valid area to tell brain that cup can be filled
			Transition.emit("dropped")
		else:
			#connects to root/cup2, tells root to submit drink info
			drinkSubmitted.emit()
			Transition.emit("dropped")
			
	elif not droppable and Input.is_action_just_released("click"):
		var tween = get_tree().create_tween()
		tween.tween_property(cup, "global_position", statemachine.origin, 0.1).set_ease(Tween.EASE_OUT)
		Transition.emit("dropped")
		
		#tells statemachine that cup cant be filled
		valid_area.emit(false)
		
func _on_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("machines"):
		#print("valid droppable area")
		droppable 	= true
		valid_area.emit(true)
		
	elif area.is_in_group("finished"):
		#print("valid droppable area")
		valid_area.emit(false)
		droppable 	= true
		finished 	= true
		
func _on_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("machines") or area.is_in_group("finished"):
		#print("valid droppable area")
		valid_area.emit(false)
		droppable 	= false
		finished 	= false
		
