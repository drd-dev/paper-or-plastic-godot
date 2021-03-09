extends Node


func _on_retry_button_pressed():
	SaveManager.Save_Game();
	AudioManager.Button_Press();
	GameManager.Change_Room("Game")
	pass # Replace with function body.
