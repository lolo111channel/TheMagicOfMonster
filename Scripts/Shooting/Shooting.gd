extends Node2D
class_name Shooting

export var bullet: PackedScene
var position_to_look_at:Vector2

var attack:int = 10
func _physics_process(delta):
	look_at(position_to_look_at)
	
func shot():
	var real_bullet = bullet.instance()
	
	real_bullet.global_position = $point.global_position
	real_bullet.global_rotation_degrees = global_rotation_degrees
	real_bullet.attack = attack
	
	get_node("/root/Test_Level").add_child(real_bullet)
	pass
