extends State

var onTarget : bool
func Enter():
	print("entering deployed")

func Exit():
	print("exiting deployed")

func Update(delta : float) -> void:
	if onTarget:
		if Input.is_action_just_pressed("click"):
			Transition.emit("selected")

func _on_area_2d_mouse_entered() -> void:
	onTarget = true

func _on_area_2d_mouse_exited() -> void:
	onTarget = false
