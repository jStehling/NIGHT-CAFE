extends Node2D

var thereIsNoOrder		: bool = true
var thereIsNoCup		: bool = true
var is_dragging 		: bool = false
var canCreateNewOrder 	: bool = true
var orderTimeout		: bool 
var targetOrder 		: String

#change both to dictionary later, better for future proofing
var mainFlavors 		: Array[String]	= ['Coffee',
										'Milk',
										'Tea', 
										"Coffee Milk", 
										'Coffee Tea', 
										'Milk Tea', 
										'Coffee Milk Tea']
var target				: Array
var baseFlavors			: Dictionary = {'Coffee' 			: 'Coffee\n',
										'Milk' 				: "Milk\n", 
										'Tea' 				: 'Tea\n',
										'Coffee Milk' 		: 'Coffee\nMilk\n',
										'Coffee Tea' 		: 'Coffee\nTea\n',
										'Milk Tea' 			: 'Milk\nTea\n',
										'Coffee Milk Tea'	: "Coffee\nMilk\nTea\n"}

var sFlavors			: Dictionary = {'light spicy' 	: "spicy\n",
										'strong spicy' 	: "spicy\nspicy\n",
										'light floral' 	: "floral\n",
										'strong floral' : "floral\nfloral\n",
										'light mint' 	: "mint\n",
										'strong mint' 	: "mintmint\n",
										'light orange'	: "orange\n",
										'strong orange'	: "orange\norange\n",
										'light vanilla'	: "vanilla\n", 
										'strong vanilla': "vanilla\nvanilla\n"}

var main				: String
var sub					: Array[String]

var cup

var lives 				: int	= 3
var cup_spawn
var patron_manager


var order_ticket: Label
var orderTimer	: Timer
@onready var eo_dscreen: Node2D = $Camera2D/EODscreen

const CUP_2 = preload("uid://cb4ifvv1uv38p")

signal killPatron
signal newPatronEnters

func _ready() -> void:
	orderTimeout = true
	patron_manager = get_tree().get_first_node_in_group("patronManager")
	cup_spawn = get_tree().get_first_node_in_group("cupSpawn")
	patron_manager.patronAttemptedMurder.connect(takeDamage)
	order_ticket = get_tree().get_first_node_in_group("orderticket")
	orderTimer = get_tree().get_first_node_in_group("order timer")
	
	
func takeDamage():
	lives -= 1
	if lives != 0:
		DaySystem.mistakes += 1
		print(lives,"/3 lives left")
	else:
		print("there are consequences to your actions")
	#print("button pressed")
	
func createOrder():

	#print("function called")
	target = []
	targetOrder = ""
	if thereIsNoOrder:
		
		#print("there is no existing order")
		if canCreateNewOrder and thereIsNoCup:
			#print("can create a new order and there is no cup")
			thereIsNoOrder = false
			createNewCup()
			
			canCreateNewOrder 	= false
			
			var possibleFlavors = resetPossibleFlavors()

			chooseMainFlavor()
			chooseSubFlavors(possibleFlavors)
			
			#create order string
			
			var order = ""
			for x in range( len(target) ):
				order += target[x] +' \n'
				
			order_ticket.text = order
			create_target()
			orderTimer.start()
		else:
			print("cant create new order")
	else:
		print("there is an existing order")
		
func _on_new_cup_pressed() -> void:
	if thereIsNoCup:
		if thereIsNoOrder:
			print("there is no order, hit the other button")
		else:	
			createNewCup()
	else:
		print("theres already a cup stupid pig")
func createNewCup():
	cup = CUP_2.instantiate()
	cup.global_position	= cup_spawn.global_position
	
	self.add_child.call_deferred(cup)
	cup.checkDrink.connect(validateOrder)
	thereIsNoCup = false
#reset the set(dioctionary) of possible flavors
#reset target order return possible flavors
func resetPossibleFlavors():
	targetOrder = ""
	sub 		= []
	
	return sFlavors.duplicate()
	#return subFlavors.duplicate()
	#print("Length of possible flavors initially: " , len(possibleFlavors))
	
func chooseMainFlavor():
	#original value (0,2)
	#var mainSelect 	= randi_range(0,7)
	var ranChoise	= baseFlavors.keys().pick_random()
	var mainChoise 	= baseFlavors[ranChoise]
	#var mainChoise  = mainFlavors[mainSelect]
	main	 		= mainChoise
	#print("main choice: ", main)
	#appends the key to an array for creating gui order
	target.append(ranChoise)
	
	targetOrder 	= mainChoise 
	
	#print("target Order: ", targetOrder)
	
func chooseSubFlavors(possibleFlavors):
		#select how many sub flavors
		var subCount 	= randi_range(1,3)
		#var subChoise 	: int
		
		for x in range(subCount):
			
			var flavor = possibleFlavors.keys().pick_random()
			sub.append(possibleFlavors[flavor])
			#appends to gui order
			target.append(flavor)
			
			possibleFlavors.erase(flavor)
			flavor = flavor.split(" ")
			flavor = flavor[1]
			for key in possibleFlavors.keys():
				if key.contains(flavor):
					possibleFlavors.erase(key)

func create_target():
	for flavor in sub:
		targetOrder += flavor
		
#dronkFlavor is passed from cup to here for checking
func validateOrder(dronkFlavor): 

	resetBoolValues()
	if dronkFlavor == targetOrder:
		results(true)
	else:
		results(false)
		
func results(correctDrink : bool) -> void:
	if correctDrink:
		print("youve made the correct drink")
	else:
		takeDamage()
	resetBoolValues()
	
	order_ticket.text = ""
	
	DaySystem.patronServed()
	
	if DaySystem.numberOfPatrons == 0:
		killPatron.emit()
		
	elif DaySystem.currentDay == 1:
		SignalBus.tutorialDrinkSubmit.emit(correctDrink)
	else:
		newPatronEnters.emit(correctDrink)
	
func resetBoolValues():
	canCreateNewOrder 	= true
	thereIsNoCup 		= true
	thereIsNoOrder		= true
	
func _on_discard_cup_pressed() -> void:
	if thereIsNoCup:
		print("there isnt a cup fuckface }:[")
	else:
		cup.suicide()
		thereIsNoCup = true
	#!!!!!
	#HANDLE PATRONS
	#!!!!
	
func _on_order_timer_timeout() -> void:
	#orderTimeout = true
	pass
