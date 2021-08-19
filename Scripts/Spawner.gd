extends Node2D

export var enemies:Array = []
var rng:RandomNumberGenerator = RandomNumberGenerator.new()
var time:float

var manager:GameManager

func _ready():
	var tree = get_tree()
	
	if(tree.has_group("Manager")):
		manager = tree.get_nodes_in_group("Manager")[0]

func _physics_process(delta):
	time += delta
	if time > 3:
		spawn_enemies()
		time = 0
	pass


func spawn_enemies()->void:
	if(manager.enemies <= manager.max_enemies):
		rng.randomize()
		
		var scene = load("res://Prefabs/Enemies/"+enemies[rng.randi_range(0,enemies.size()-1)]+".tscn")
		var enemy = scene.instance()
		
		enemy.global_position = $Point.global_position
		
		manager.enemies += 1
		get_owner().get_node("Navigation").add_child(enemy)


