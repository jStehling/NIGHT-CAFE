extends Area2D

var focused 		:= false
var can_fill		:= false
@export var type 	: int
@export var label	: String
@export var flavor 	: String
@onready var button	: Button = $Button

signal fill

func _ready():
	button.text = label

func _on_button_pressed() -> void:
	
	if focused and can_fill:
		fill.emit(type, flavor)


func _on_button_mouse_entered() -> void:
	focused = true

func _on_button_mouse_exited() -> void:
	focused = false


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("drink"):
		can_fill = true
		#print("can_fill ", can_fill)
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("drink"):
		can_fill = false
		#print("can_fill", can_fill)
