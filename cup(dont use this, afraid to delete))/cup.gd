extends Node2D
class_name Cup

var is_selected := false
var can_fill 	:= false
var droppable	:= false
var draggable	:= false
var finished	:= false
var target_ref	: Vector2
var origin		: Vector2
var root
@onready var sprite: Sprite2D = $Sprite2D

# fill of the cup
#represented by characters i.e. CMT = Coffee Milk Tea and llmo = Strong lavender, light mint, light orange
@export var mainFlavor 	: String
@export var subFlavor 	: String

var machines
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = global_position
	mainFlavor 	= ''
	subFlavor 	= ''
	
	root = get_tree().get_root()
	for node in get_tree().get_nodes_in_group("machines"):
		node.fill.connect(fillcup)
	#----	WORLD REFERENCE	  ----#
	World.finished.connect(checkcup)
	#----	WORLD REFERENCE	  ----#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_selected:
		if Input.is_action_pressed("click"):
			#----	WORLD REFERENCE	  ----#
			World.is_dragging 	= true
			#----	WORLD REFERENCE	  ----#
			global_position		= get_global_mouse_position()
		
		if Input.is_action_just_released("click"):
			var tween = get_tree().create_tween()
			if droppable:
				tween.tween_property(self, "position", target_ref, 0.1).set_ease(Tween.EASE_IN)
			else:
				tween.tween_property(self, "position", origin, 0.1).set_ease(Tween.EASE_IN)
			is_selected = false
			
func fillcup(type : int , flavor : String):
	if type == 0:
		mainFlavor 	+= flavor
	else:
		subFlavor 	+= flavor

#checking mouse is on target
func _on_area_2d_mouse_entered() -> void:
	is_selected 	= true
	sprite.scale 	= Vector2(.35,.35)
	#----	WORLD REFERENCE	  ----#
	if not World.is_dragging:
	#----	WORLD REFERENCE	  ----#
		draggable 	= true
		
#checking mouse is on target
func _on_area_2d_mouse_exited() -> void:	
	sprite.scale 	= Vector2(.25,.25)
	#----	WORLD REFERENCE	  ----#
	if not World.is_dragging:
	#----	WORLD REFERENCE	  ----#
		draggable 	= false
		is_selected = false
	else:
		is_selected = true

#for when order is handed to patron
func checkcup():
	pass

#checking if area is a droppable area
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('machines'):
		droppable 	= true
		target_ref 	= area.global_position 
#checking if area is a droppable area
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group('machines'):
		droppable 	= false
		target_ref 	= origin

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if finished:
		queue_free()
