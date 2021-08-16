extends Control

onready var panel_level_path:PackedScene = load("res://Prefabs/PanelLevel.tscn")

func _ready():
	var files:Array = Global.list_files_in_directory("res://LevelsInJson/")
	var number = 0
	
	for i in files.size():
		var file = File.new()
		
		for x in files.size():
			file.open("res://LevelsInJson/"+files[x],file.READ)
			var text = file.get_as_text()
			var parse = parse_json(text)
			
			
			
			if(parse["id"] == number):
				var panel_level:PanelLevel = panel_level_path.instance()
				
				panel_level.level_name = parse[Global.lang]["name"]
				panel_level.level_path = parse["levelPath"]
				panel_level.image_path = parse["image"]
				
				$Panel/Scroll/VBox/Grid.add_child(panel_level)
				number += 1
		
	
	pass



func _on_Exit_pressed():
	visible = false
