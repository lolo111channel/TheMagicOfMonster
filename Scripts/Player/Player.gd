extends KinematicBody2D
class_name Player

export var movement_speed:float =100.0
export var max_health:int = 100
export var max_mana:int = 100
export var level:int = 1

var experience:int = 0
var max_experience:int = 100

var health:int = 100
var mana:int = 100

var attack:int = 10

var mana_cost = 2

var velocity:Vector2 = Vector2.ZERO
var forward:float
var right:float

onready var shooting:Shooting = $Shooting
onready var health_bar:ProgressBar = $Canvas/HealthBar
onready var mana_bar:ProgressBar = $Canvas/ManaBar


var attack_time: float = 0
var max_attack_time:float = 0.5


func _ready():
	Global.player = self
	
	max_health = 100 * Global.base_health_level 
	max_mana = 100 * Global.base_mana_level
	attack = 10 * Global.base_attack_level
	movement_speed = 100.0 + Global.base_speed_level * 2
	max_attack_time = Global.attack_speed
	
	regeneration_health_mana()
	

func _process(delta):
	attack_time += delta
	
	update_UI()
	
	health = clamp(health,0,max_health)
	mana = clamp(mana,0,max_mana)
	
	shooting.position_to_look_at = get_global_mouse_position()
	if(Input.is_action_pressed("Shot") and mana >= mana_cost and attack_time >= max_attack_time):
		shooting.attack = attack + level * 10
		shooting.shot()
		mana -= mana_cost
		attack_time = 0
	
	level_up()
	
	if(health <= 0):
		death_system()
	

func _physics_process(delta):
	player_movement()

func player_movement():
	velocity = Vector2.ZERO
	
	forward = Input.get_action_strength("Forward") - Input.get_action_strength("Backward")
	right = Input.get_action_strength("Left") - Input.get_action_strength("Right")
	
	velocity = Vector2(-right,-forward)
	
	velocity = velocity.normalized() * movement_speed
	velocity = move_and_slide(velocity)
	

func update_UI():
	health_bar.value = health
	health_bar.max_value = max_health
	
	mana_bar.value = mana
	mana_bar.max_value = max_mana
	
	health_bar.get_node("Label").text = str(health)
	mana_bar.get_node("Label").text = str(mana)
	
	$Canvas/Label.text = "Level: "+str(level)
	

func level_up():
	if experience >= max_experience:
		experience = 0
		level += 1
		max_experience += 200
		
		max_health += 100
		max_mana += 100
		regeneration_health_mana()
		
func regeneration_health_mana():
	health = max_health
	mana = max_mana

func death_system():
	$CollisionShape2D.disabled = true
	$Sprite.texture = null
	$Canvas/DeathInterface.visible = true
	
	get_tree().paused = true
	
	pass


func _on_Area2D_body_entered(body):
	if(body.is_in_group("EnemyBullet")):
		health -= body.attack
		body.queue_free()


func _on_mana_regeneration_timeout():
	mana += 2
	$mana_regeneration.start(1)
