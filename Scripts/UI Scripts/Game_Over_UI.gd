extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var showUI = false;




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	control_visibility(delta);



func control_visibility(delta):
	if(GameManager.game_state != GameManager.GAME_STATE.playing):
		rect_position.y = lerp(rect_position.y, 150, 5 * delta);
	else:
		rect_position.y = lerp(rect_position.y, 700, 5 * delta);


#buttons
func _on_retry_button_pressed():
	SaveManager.Save_Game();
	AudioManager.Button_Press();
	GameManager.Change_Room("Game")
	pass # Replace with function body.

func _on_quit_button_pressed():
	SaveManager.Save_Game();
	AudioManager.Button_Back();
	GameManager.Change_Room("MainMenu")
	get_tree().paused = false;
	pass # Replace with function body

func _on_resume_button_pressed():
	AudioManager.Button_Press();
	GameManager.Resume_Game();
	pass
