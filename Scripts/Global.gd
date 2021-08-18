extends Node

var lang:String = "eng"
var player:Player = null
var coins:int = 0

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file =="":
			break
		elif !file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	
	return files
