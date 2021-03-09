extends Node


func _on_quit_button_pressed():
	SaveManager.Save_Game();
	AudioManager.Button_Back();
	GameManager.Change_Room("MainMenu")
	get_tree().paused = false;
	pass # Replace with function body.
