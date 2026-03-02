extends Node2D

var gamestart				: bool		= true
var cameraOnDrinks			: bool		= false
var phase 					: int
var root 
var patron
@onready var patron_spawn	: Node2D 	= $"patron spawn"
@onready var node			: Node 		= $".."
@onready var camera			: Camera2D 	= $"../Camera2D"

#initial wait is for when game start
@onready var initial_wait: Timer = $"initial wait"
#animation wait is to wait until entering animation is finished
@onready var animation_wait: Timer = $"animation wait"
#second wait is to read order
@onready var second_wait: Timer = $"second wait"
#patron act timer is for when a patron acts
@onready var patronActTimer: Timer = $patronActTimer

const PATRON							= preload("uid://bfcb0vacxsaut")

#connects to world script to tell player to take damage
signal patronAttemptedMurder

signal warning

func _ready() -> void:
	node.newPatronEnters.connect(newPatronEnters)
	node.killPatron.connect(killPatron)
	camera.cameraSwapPosition.connect(cameraPosUpdate)
	DaySystem.startNewDay.connect(newPatronEnters)
	SignalBus.tutorialOver.connect(startgame)

func startgame()-> void:
	initial_wait.start()
func newPatronEnters(_unused):	
	#print("new patron")
	if patron:
		#print("killing existing patron")
		killPatron()
	#print("creating new patorn")
	
	root = get_tree().get_root()
	patron = PATRON.instantiate()
	patron.global_position = patron_spawn.global_position
	root.add_child.call_deferred(patron)
	#print("patron created")
	
	phase = 2
	if not gamestart:
		initial_wait.start()
		
func cameraPosUpdate(isOnPatron : bool):
	#true when camea is on drinks, false when on patron
	cameraOnDrinks = isOnPatron

func _on_initial_wait_timeout() -> void:
	newPatronEnters(false)
	initial_wait.stop()
	animation_wait.start()
	#print("INITIAL WAIT")
	gamestart = false
	 
func _on_patron_act_timer_timeout() -> void:
	#print("patron act timer")
	if cameraOnDrinks:
		phase -= 1
		if phase % 2 == 1:
			warning.emit()
		else:
			print("*stabs you UwU*")
			patronAttemptedMurder.emit()
	else:
		print("could you hurry up")

func _on_second_wait_timeout() -> void:
	#print("second wait")
	second_wait.stop()
	patronActTimer.start(randf_range(4,8))

func _on_animation_wait_timeout() -> void:
	second_wait.start(8)
	node.createOrder()
	print("not here")
	#print("order created")
	animation_wait.stop()
	second_wait.start(10)

func killPatron():
	patron.queue_free()
	second_wait.stop()
	patronActTimer.stop()
	
