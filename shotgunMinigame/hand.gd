extends Sprite2D

var ran = RandomNumberGenerator.new()
var handActive : bool
var oneTime : bool = false # set to true to enable hand movement, do not fire gun at hand when false
var twoTime : bool = false
var gunAimed : bool = false
var tween : Tween
@onready var handTime : Timer = $handTimer
@onready var shotgun_spawn: Node2D = $"../shotgunSpawn"
@onready var light_switch: AnimatedSprite2D = $"../lightSwitch"

func _ready() -> void:
	SignalBus.tutorialOver.connect(begin)
	visible = false

func begin():
	oneTime = true

func _process(_delta) -> void:
	if oneTime:
		var handRng = ran.randf_range(15, 30)
		print(handRng)
		handTime.start(handRng)
		oneTime = false
	if twoTime:
		if handActive == false:
			print("test")
			tween.kill()
			global_position = Vector2(3669, 341)
			oneTime = true
			twoTime = false
		if handActive:
			tween = create_tween()
			tween.tween_property(self, "global_position", light_switch.global_position, 10)
			print("tween active")
			twoTime = false

func _on_hand_timer_timeout() -> void:
	handActive = true
	twoTime = true
	visible = true

func _on_shotgun_gun_fired() -> void:
	if gunAimed:
		handActive = false
		twoTime = true
		visible = false

func _on_hand_area_mouse_entered() -> void:
	gunAimed = true
	# print("aim")

func _on_hand_area_mouse_exited() -> void:
	if gunAimed:
		# print("not aimed")
		gunAimed = false
