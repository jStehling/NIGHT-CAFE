extends Sprite2D

var onTarget :	bool = false

@onready var area_2d: Area2D = $Area2D
@onready var shotgun: Sprite2D = $"../shotgun"


func _ready():
	shotgun.gunFired.connect(gunFired)
	area_2d.mouse_entered.connect(mouseEntered)
	area_2d.mouse_exited.connect(mouseExited)

func gunFired():	
	if onTarget:
		SignalBus.d2GunFired.emit()
		queue_free()
func mouseEntered()->void:
	onTarget = true
func mouseExited()->void:
	onTarget = false
