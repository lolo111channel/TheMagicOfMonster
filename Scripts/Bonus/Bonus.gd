extends Area2D

export var add_health:int = 0
export var add_mana:int = 0


func _on_Heart_body_entered(body):
	if(body.is_in_group("Player")):
		body.health += add_health
		body.mana += add_mana
		queue_free()
