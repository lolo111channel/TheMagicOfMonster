extends Control

onready var select_level:Control = get_owner().get_node("Canvas/SelectLevel")
onready var shop:Control = get_node("/root/MainMenu/Canvas/Shop")


func _on_PlayButton_pressed():
	if(!select_level.visible):
		select_level.visible = true

func _on_ShopButton_pressed():
	shop.visible = true


func _on_OptionsButton_pressed():
	print("Options")


func _on_QuitButton_pressed():
	get_tree().quit()
	
