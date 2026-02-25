extends AnimatedSprite2D

func _on_hand_area_area_entered(area):
	if area.is_in_group("ShotgunMiniGame"):
		frame = 1
