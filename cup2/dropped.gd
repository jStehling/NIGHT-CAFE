extends State

var draggable 	:= false
var active		:= false
@onready var sprite: Sprite2D = $"../../Sprite2D"


func Enter():
	#print("entering dropped")
	active = true
	
func Exit():
	#print("exiting dropped")
	active = false
	
func Update(_delta : float) -> void:
	if draggable and Input.is_action_just_pressed("click"):
		Transition.emit("dragging")

func _on_area_mouse_entered() -> void:
	#print("selectable")
	#print(World.is_dragging)
	#print(active)
	if not World.is_dragging and active:
		draggable = true
		sprite.scale = Vector2(0.35, 0.35)

func _on_area_mouse_exited() -> void:
	#print("not selectable")
	#print(World.is_dragging)
	#print(active)
	if not World.is_dragging and active:
		draggable = false
		sprite.scale = Vector2(0.25, 0.25)
	
	
