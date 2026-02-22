extends Button

func _ready() -> void:
	disabled 	= true
	
func _on_mouse_entered() -> void:
	disabled 	= false
	
func _on_mouse_exited() -> void:
	disabled 	= true
