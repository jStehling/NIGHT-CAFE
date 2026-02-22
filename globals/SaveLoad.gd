extends Node

const save_loc := "user://SaveFile.json"
##MAKE SURE TO CHANGE BOTH DAY AND MISTAKES OTHERWISE THEY REVERT TO 0
var saveFile_contents : Dictionary ={
	"day"		:	0,
	"mistakes"	:	0,
}

func _save():
	var file = FileAccess.open(save_loc, FileAccess.WRITE)
	file.store_var(saveFile_contents.duplicate())
	file.close()

func _load():
	if FileAccess.file_exists(save_loc):
		var file = FileAccess.open(save_loc, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data		= data.duplicate()
		DaySystem.day 		= save_data.day
		DaySystem.mistakes 	= save_data.mistakes
		
