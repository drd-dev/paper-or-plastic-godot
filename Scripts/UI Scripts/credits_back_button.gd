extends Node

export var room_name: String = "MainMenu"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_backButton_pressed():
	AudioManager.Button_Back();
	GameManager.Change_Room(room_name);
	pass # Replace with function body.
