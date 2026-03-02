extends Camera2D

var on_drinks 		:= false
var drinkPos 		:= Vector2(576,328)
var patronPos		:= Vector2(3207,328)

signal cameraSwapPosition

var patronManager
var pauseScreen
var watchingForInput	:= false
signal pausescreen
@onready var warning_label: Label = $"warning Label"
@onready var timer: Timer = $Timer
var count = 0
func _ready() -> void:
	patronManager = get_tree().get_first_node_in_group("patronManager")
	patronManager.warning.connect(warningLabel)
	SignalBus.flashTextOnScreen.connect(hints)
	pauseScreen = get_tree().get_first_node_in_group("pauseScreen")
	
func hints(text : String) -> void:
	watchingForInput = true
	warning_label.text = text
	#var tween = get_tree().create_tween()
	#tween.tween_property(warning_label, "modulate", 1), 1)

func _process(_delta : float) -> void:
	if Input.is_action_just_pressed("Swap Screen"):
		move_screen()
		
	if Input.is_action_just_pressed("pause"):
		pausescreen.emit()
		
	if watchingForInput:
		if Input.is_action_just_pressed("Swap Screen"):
			watchingForInput = false
			SignalBus.swappedScreensTutorial.emit()
			warning_label.text = ""
			
func move_screen():
	
	if on_drinks: 
		
		on_drinks = !on_drinks
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", patronPos, 0.3).set_ease(Tween.EASE_IN)
		cameraSwapPosition.emit(on_drinks)
	else:
		
		on_drinks = !on_drinks
		var tween = get_tree().create_tween() 
		tween.tween_property(self, "global_position", drinkPos, 0.3).set_ease(Tween.EASE_IN)
		cameraSwapPosition.emit(on_drinks)

func warningLabel():
	warning_label.label_settings.font_color = Color(Color.WHITE, 1)
	warning_label.text = '"scary noise"'
	timer.start()

func _on_timer_timeout() -> void:
	warning_label.text = ""
	timer.stop()
