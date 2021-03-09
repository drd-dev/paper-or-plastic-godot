extends Node

var openPos = 200;

var settingsOpen: bool = false

var startX = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var panel = get_node("/root/MainMenu/Top_UI/SettingsPanel");
	if(settingsOpen):
		panel.rect_position.x = lerp(panel.rect_position.x, openPos, 15 * delta);
	else:
		panel.rect_position.x = lerp(panel.rect_position.x, 240, 15 * delta);
#	pass


func _on_Settings_pressed():
	settingsOpen = !settingsOpen;
	if(settingsOpen):
		AudioManager.Button_Press();
	else:
		AudioManager.Button_Back();


func _on_music_button_pressed():
	AudioManager.Toggle_Music();


func _on_sfx_button_pressed():
	AudioManager.Toggle_SFX();


func _on_credits_button_pressed():
	AudioManager.Button_Press();
	GameManager.Change_Room("Credits");
	pass # Replace with function body.
