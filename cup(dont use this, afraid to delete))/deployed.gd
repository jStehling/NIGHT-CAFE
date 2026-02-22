extends State

var active 			:= false
var mouseOnTarget 	:= false
var can_fill		:= false
var draggable		:= false
var finished		:= false


signal fill
@onready var sprite: Sprite2D = $"../../Sprite2D"
@onready var cup: Node2D = $"../.."
@onready var area_2d: Area2D = $"../../Area2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("machines"):
		node.fill.connect(fillcup)
#check where cup is so i know as to where to tween cup
func Enter():
	active 			= true
	mouseOnTarget 	= false
	can_fill		= false
	draggable		= false
	print("entering deployed")
	
func Exit():
	active = false
	print("exiting deployed")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(_delta: float) -> void:
	if draggable and Input.is_action_pressed("click"):
		Transition.emit("deploying")
		draggable = false
		

func fillcup(type, flavor):
	fill.emit(type, flavor)


func _on_area_2d_mouse_entered() -> void:
	if active:
		print("on target")
		mouseOnTarget 	= true
		sprite.scale 	= Vector2(.35,.35)
		#----	WORLD REFERENCE	  ----#
		if not World.is_dragging:
			draggable 	= true

func _on_area_2d_mouse_exited() -> void:
	
	if active:
		print("not on target")
		sprite.scale 	= Vector2(.25,.25)
		#----	WORLD REFERENCE	  ----#
		if not World.is_dragging:
			draggable 	= false
			mouseOnTarget = false
		else:
			mouseOnTarget = true
