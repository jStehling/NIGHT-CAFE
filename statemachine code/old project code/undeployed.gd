extends State

var active := false
var initial_deploy := true
var draggable := false
var origin : Vector2
@onready var statemachine: Node2D = $".."
@onready var unit: Area2D = $"../Area2D"

func Enter():
	active = true
	print(Engine.time_scale)
	print("undeployed: ", draggable)
	if initial_deploy:
		initial_deploy = false
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(unit, 'global_position', statemachine.origin, 0.1).set_ease(Tween.EASE_OUT)
		

func Exit():
	active = false
	print("exiting undeployed")
	
func Update(_delta):
	if draggable:
		if Input.is_action_pressed("click"):
			Transition.emit("deploying")
			draggable = false

func _on_area_2d_mouse_entered() -> void:
	if active:
		draggable = true
		print("undeployed: ", draggable)
		unit.scale = Vector2(1.2,1.2)

func _on_area_2d_mouse_exited() -> void:
	if active:
		draggable = false
		print("undeployed: ", draggable)
		unit.scale = Vector2(1,1)
