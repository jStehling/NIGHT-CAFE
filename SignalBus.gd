extends Node

## called once when during initial tutorial, creates an order but no patron
##called from tutorial manager connects to root node to create an order
signal tutorialOrder

##called once  after a drink is submitted during a tutorial
##called from cup on submit only during DaySystem.currentDay = 1
signal tutorialDrinkSubmit

##changes tutorial Textbox from tutorial manager/current state machine/ current state
signal changeTutorialTextBox


##flashed text on screen, used for tutorials, tests
signal flashTextOnScreen


##called from tutorial manager/current state machine/ current state to textbox to disable its button
##true if disabled, false if enabled
signal disableForwardTextButton

##called once from camera to manager/current state machine/ current state when spacebar is pressed
signal swappedScreensTutorial

##called once tutorial is over to start spawining patrons
##from tutorial manager / current day to patron manager
signal tutorialOver
