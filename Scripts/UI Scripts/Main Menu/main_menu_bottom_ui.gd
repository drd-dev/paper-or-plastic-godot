extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_Button_pressed():
	AudioManager.Button_Press();
	GameManager.Change_Room("Game")
	pass # Replace with function body.


func _on_Collection_Button_pressed():
	AudioManager.Button_Press();
	GameManager.Change_Room("CollectionMenu")
	pass # Replace with function body.


func _on_Stats_Button_pressed():
		AudioManager.Button_Press();
		GameManager.Change_Room("StatsMenu")
		pass # Replace with function body.
