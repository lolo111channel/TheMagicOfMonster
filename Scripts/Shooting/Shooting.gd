extends Node2D
class_name Shooting

export var bullet: PackedScene
var position_to_look_at:Vector2

var attack:int = 10
var weapon_scatter:int = 0

var rng:RandomNumberGenerator = RandomNumberGenerator.new()
func _physics_process(delta):
	look_at(position_to_look_at)
	
func shot():
	rng.randomize()
	var real_bullet = bullet.instance()
	
	real_bullet.global_position = $point.global_position
	real_bullet.global_rotation_degrees = global_rotation_degrees + rng.randi_range(-weapon_scatter,weapon_scatter)	
	real_bullet.attack = attack
	
	get_node("/root/Test_Level").add_child(real_bullet)
	pass
