extends Control

export var id: int = 0
var cost:int = 10

func _process(delta):
	cost = Global.getVar(id) * 100
	
	$Panel/Label2.text = "Cost: "+ str(cost)+"C"
	
	if Global.getVar(id) >= 10:
		$Panel/Label2.text = "MAX"
	
func upgrade():
	if(Global.coins >= cost and Global.getVar(id) < 10):
		Global.add(id)
		Global.coins -= cost


func _on_Button_pressed():
	upgrade()
