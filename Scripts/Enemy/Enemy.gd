extends KinematicBody2D

export(int) var speed:int = 50
export(int) var level:int = 1
export var bonus:Array = []

onready var ai:AI = $AI
onready var shooting:Shooting = $Shooting
onready var timer:Timer = $Timer

var distance: float
var health:int = 100
var attack:int

var isShot:bool = false

var rng:RandomNumberGenerator = RandomNumberGenerator.new()
var manager:GameManager

func _ready():
	manager = get_tree().get_nodes_in_group("Manager")[0]
	level = manager.wave
	
	ai.speed = speed
	health = level * 100
	attack = level * 2
	
	$Label.text = str(level) + "lvl"
	$ProgressBar.max_value = health


func _process(delta):
	$ProgressBar.value = health
	$ProgressBar/Label.text = str(health)
	
	death_system()

func _physics_process(delta):
	if(Global.player):
		ai.generate_path()
		ai.navigate()
	
	
	shooting.position_to_look_at = Global.player.global_position
	distance = global_position.distance_to(Global.player.global_position)
	if(distance > 30):
		move()
		
	
	if(distance < 50 and isShot == true):
		shooting.attack = attack
		shooting.shot()
		isShot = false


func move():
	ai.velocity = move_and_slide(ai.velocity)


func death_system():
	if health <= 0:
		for i in 2:
			rng.randomize()
			var bonus_scene:PackedScene = load("res://Prefabs/Bonus/"+bonus[rng.randi_range(0,bonus.size()-1)]+".tscn")
			var b = bonus_scene.instance()
		
			b.global_position = Vector2(global_position.x+i+2,global_position.y+1+i)
		
			get_parent().add_child(b)
		manager.everyone_eniemies -= 1
		Global.player.experience += 20
		queue_free()



func _on_Area2D_body_entered(body):
	if (body.is_in_group("Bullet")):
		health -= body.attack
		body.queue_free()


func _on_Timer_timeout():
	isShot = true
	timer.start(1)

