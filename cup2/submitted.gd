extends State

signal drinkSubmitted

func Enter():
	drinkSubmitted.emit()
	
func Exit():
	pass
