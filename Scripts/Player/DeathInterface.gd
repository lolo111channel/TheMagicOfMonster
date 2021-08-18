extends Control





func _on_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Levels/MainMenu.tscn")



func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

