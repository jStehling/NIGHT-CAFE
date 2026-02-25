extends Sprite2D

var gunActive : bool = false
var ammoCount : int = 2
signal gunFired

func _input(event: InputEvent) -> void:
	if gunActive == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					gunActive = false
					print("bang!")
					ammoCount -= 1
					gunFired.emit()

func _process(_delta) -> void:
	if gunActive == true:
		global_position = get_global_mouse_position()
	if gunActive == false:
		global_position = Vector2(3037, 625)
		

func _on_grab_gun_pressed() -> void:
	if ammoCount > 0:
		if gunActive == false:
			gunActive = true
			print("gun is active")
		else:
			gunActive = false
			print("gun is inactive")
	else:
		print("You have no ammo!!!!")
