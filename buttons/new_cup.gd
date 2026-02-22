extends Button


func _on_mouse_entered() -> void:
	disabled = false

func _on_mouse_exited() -> void:
	disabled = true
