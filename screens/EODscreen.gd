extends Node2D

signal transitionNextDay
var focused = false
var origin 		
var parent 
var EODonScreen := Vector2(0, 650)

func _ready() -> void:
	origin = global_position
	DaySystem.callEODScreen.connect(callEODScreen)
	
func callEODScreen():
	var tween = get_tree().create_tween()
	print(position.x)
	print(global_position.x)
	tween.tween_property(self, "global_position", global_position + EODonScreen, .5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
func _on_button_pressed() -> void:
	if focused:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", global_position - EODonScreen, .5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		transitionNextDay.emit()

func _on_button_mouse_entered() -> void:
	focused = true

func _on_button_mouse_exited() -> void:
	focused = false
