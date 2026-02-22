extends Node2D


@export var finalScale 	:		= Vector2(3.5,3.5)
@onready var timer		: Timer = $Timer

func _ready() -> void:
	
	scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", finalScale, 3.5).set_ease(Tween.EASE_OUT)
