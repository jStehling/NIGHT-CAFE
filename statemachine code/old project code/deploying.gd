extends State

var droppable := false
const TIlE_SIZE = Vector2(16,16)

@onready var unit: Node2D = $".."
@onready var area: Area2D = $"../Area2D"

func Enter():
	print("entered deploying")
	droppable = false

func Exit():
	print("exiting deploying")

func Update(delta : float) -> void:
		
	if Input.is_action_pressed("click"):
		unit.global_position = unit.get_global_mouse_position()
		
	if droppable and Input.is_action_just_released("click"):
		droppable = false
		Transition.emit("deployed")
		
	elif not droppable and Input.is_action_just_released("click"):
		droppable = false
		var tween = get_tree().create_tween()
		tween.tween_property(unit, "global_position", unit.origin, 0.1).set_ease(Tween.EASE_OUT)
		Transition.emit("undeployed")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("droppable"):
		droppable = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("droppable"):
		droppable = false
