extends Node

const days = [1,2,3,4,5]

var currentDay
var numberOfPatrons
var tutorial	: bool 	= true
var mistakes 			= 0

var root
var EODscreen

signal startNewDay
signal callEODScreen

func _ready() -> void:
	#print("daysystem")
	SignalBus.tutorialOver.connect(tutorialOver)
	EODscreen = get_tree().get_first_node_in_group("EODscreen")
	EODscreen.transitionNextDay.connect(nextDay)
	
	currentDay = days[1]
	print("current day: ", currentDay)
	numberOfPatrons = 1
	#print("DAY 1")
func tutorialOver():
	tutorial = false
func patronServed() -> void:
	if tutorial:
		pass
	else:
		numberOfPatrons -= 1
		print("patron served")
		print("number of patrons left: ", numberOfPatrons)
	
	
	if numberOfPatrons == 0:
		callEODScreen.emit()

func nextDay() -> void:
	print("nextday")
	currentDay = days[currentDay]
	
	match currentDay:
		2:
			numberOfPatrons = 2
			print("DAY 2")
			#randi_range(4,7)
		3:
			numberOfPatrons = randi_range(6,8)
			print("day 3")
		4:
			numberOfPatrons = 10 
			print("day 4")
		5:
			print("day 5")
			finalDay()
	startNewDay.emit(false)
	
func finalDay():
	numberOfPatrons = 2
