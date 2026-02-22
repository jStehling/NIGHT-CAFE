extends State

var target_ref 	: Vector2
var droppable 	= false

@onready var cupmachine: Node = $".."
@onready var cup: Node2D = $"../.."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Enter():
	print("Entering deploying")
	
func Exit():
	print("exiting deploying")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(_delta: float) -> void:
	if Input.is_action_pressed("click"):
		cup.global_position = cup.get_global_mouse_position()
	
	if droppable and Input.is_action_just_released("click"):
		droppable = false
		var tween = get_tree().create_tween()
		tween.tween_property(cup, "global_position", target_ref, 0.1).set_ease(Tween.EASE_OUT)
		Transition.emit("deployed")
		
	elif not droppable and Input.is_action_just_released("click"):
		var tween = get_tree().create_tween()
		tween.tween_property(cup, "global_position", cupmachine.origin, 0.1).set_ease(Tween.EASE_OUT)
		Transition.emit("deployed")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("test")
	if body.is_in_group('machines'):
		print("droppable")
		droppable = true 
		target_ref = body.global_position

func _on_body_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('machines'):
		print("not droppable")
		droppable = false
