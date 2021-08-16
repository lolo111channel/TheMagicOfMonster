extends KinematicBody2D


var bullet_speed: float = 500.0
var velocity:Vector2 = Vector2.ZERO

var attack = 10

func _physics_process(delta):
	velocity = Vector2(1,0).rotated(rotation)
	
	velocity = velocity.normalized() * bullet_speed
	velocity = move_and_slide(velocity)
	
	
	


func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if(!body.is_in_group("Enemy") and !body.is_in_group("Player")):
		queue_free()
