extends Node2D
class_name AI

var speed:int = 0
var velocity:Vector2 = Vector2.ZERO

var path:Array = []
var navigation: Navigation2D = null


func _ready():
	var tree = get_tree()
	
	if(tree.has_group("Navigation")):
		navigation = tree.get_nodes_in_group("Navigation")[0]

func navigate():
	if(path.size() >0):
		velocity = get_parent().global_position.direction_to(path[1]) * speed
		
		if(get_parent().global_position == path[0]):
			path.pop_front()


func generate_path(position):
	if (navigation != null):
		path = navigation.get_simple_path(get_parent().global_position,position,false)
