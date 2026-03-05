extends Node2D

signal changeDialogue
var parent
var camera
var focused = false
@onready var text: Label = $text
@onready var button: Area2D = $Sprite2D/Area2D

func _ready() -> void:
	parent = get_parent()
	SignalBus.changeButton.connect(changeButton)
	SignalBus.changeTutorialTextBox.connect(updatetext)
	camera = get_tree().get_first_node_in_group("camera")
	
func updatetext(newText):
	text.text = newText 
	
func _process(_delta: float) -> void:
	if focused and Input.is_action_just_pressed("click"):
		SignalBus.advanceDialogue.emit()

func changeButton(state : bool):
	button.input_pickable = state
	
func emphasize(largenText : bool):
	if largenText:
		text.label_settings.font_size = 50
	else:
		text.label_settings.font_size = 40


func _on_area_2d_mouse_entered() -> void:
	focused = true


func _on_area_2d_mouse_exited() -> void:
	focused = false
