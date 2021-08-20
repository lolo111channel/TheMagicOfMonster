extends Node2D
class_name GameManager

var wave:int = 0
var spawners:Array = []
var everyone_eniemies:int = 0
var enemies:int = 0
var max_enemies:int = 10

var time = 0

func _ready():
	yield(get_tree(),"idle_frame")
	var tree = get_tree()
	
	if(tree.has_group("Spawner")):
		spawners = tree.get_nodes_in_group("Spawner")
	
func _process(delta):
	
	$CanvasLayer/Label.text = str(wave) +" wave \n" + str(everyone_eniemies) +" enemies to defeat" 
	
	
	if(everyone_eniemies <= 0):
		wave+=1
		everyone_eniemies = wave * 10
		enemies = 0
		max_enemies = everyone_eniemies
		Global.coins += 20
	pass
