extends CenterContainer


var force_move: bool = false;

func _ready():
	get_node("../Top_UI/timer").visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	control_visibility(delta);



func control_visibility(delta):
	if( (GameManager.game_state == GameManager.GAME_STATE.gameOver || GameManager.game_state == GameManager.GAME_STATE.paused) && !force_move):
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
	AudioManager.back_button_long();
	GameManager.Change_Room("MainMenu")
	AudioManager.set_menu_sounds(true);
	AudioManager.set_game_music(false);
	
	get_tree().paused = false;
	pass # Replace with function body

func _on_resume_button_pressed():
	AudioManager.Button_Press();
	force_move = true;
	var timer = get_node("../Top_UI/timer");
	timer.visible = true;
	timer.frame = 0;
	yield(get_tree().create_timer(1), "timeout");
	AudioManager.Button_Press();
	timer.frame = 1;
	yield(get_tree().create_timer(1), "timeout");
	AudioManager.Button_Press();
	timer.frame = 2
	yield(get_tree().create_timer(1), "timeout");
	AudioManager.Button_Press();
	timer.visible = false;
	GameManager.Resume_Game();
	force_move = false;
	pass
