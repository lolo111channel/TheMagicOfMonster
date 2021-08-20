extends Node

var lang:String = "eng"
var player:Player = null
var coins:int = 0

var base_health_level:int = 1
var base_mana_level:int = 1
var base_attack_level:int = 1
var base_speed_level:int = 1
var base_attack_speed_level:int = 1

var attack_speed = 0.5


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
	

func add(x):
	match x:
		0:
			base_health_level += 1
		1:
			base_mana_level += 1
		2:
			base_attack_level += 1
		3: 
			attack_speed -= 0.05
			base_attack_speed_level += 1
		4: 
			base_speed_level += 1
			
func getVar(x:int)->int:
	match x:
		0:
			return base_health_level
		1:
			return base_mana_level
		2:
			return base_attack_level
		3: 
			return base_attack_speed_level
		4: 
			return base_speed_level
	return 0


	
