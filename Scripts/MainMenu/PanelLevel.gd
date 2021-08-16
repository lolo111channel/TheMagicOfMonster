extends Panel
class_name PanelLevel

var id:int
var level_name:String
var level_path:String
var image_path:String

func _ready():
	$Title.text = level_name
	$Image.texture = load(image_path)



func _on_Button_pressed():
	get_tree().change_scene(level_path)
