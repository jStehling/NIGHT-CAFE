extends Node2D

var origin = Vector2(0, -650)

var parent
func _ready() -> void:
	parent = get_parent()
	parent.pausescreen.connect(pausingGame)
	hide()

func pausingGame():
	
	get_tree().paused = true
	print("pausing game")
	show()
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "global_position", Vector2(global_position.x, -325), .5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	
	
func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "global_position", global_position + origin, .5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	print("resuming game")
	
	
func _on_save_pressed() -> void:
	SaveLoad.saveFile_contents.day		= DaySystem.currentDay
	SaveLoad.saveFile_contents.mistakes = DaySystem.mistakes
	SaveLoad._save()

func _on_settings_pressed() -> void:
	print("not uet implemented")
