extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(_delta):
	$Label.text = String(GameManager.coins);
