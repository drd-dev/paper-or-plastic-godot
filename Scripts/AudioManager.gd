extends Node

var music_muted: bool = false;
var sfx_muted: bool = false;

func _ready():
	#set sound mutes when game loads
	Update_Sound_Settings();
	
	
func Button_Press():
	$Button_Press.play();

func Button_Back():
	$Button_Back.play();

func Item_Missed():
	$Miss_Sound.play();

func high_score():
	$high_score.play();
	
func game_start():
	$game_start.play();
	
func max_multiplier():
	$max_multiplier.play();
	
func back_button_long():
	$Button_Back_Long.play();


func menu_transition():
	$menu_transition.play();
	
func multiplier_up():
	$multiplier_up.play();

func set_menu_sounds(state: bool):
	if state:
		$mainMenuSounds.play();
	else:
		$mainMenuSounds.stop();
		
		
func set_game_music(state: bool):
	if state:
		$Music_Game.play();
	else:
		$Music_Game.stop();


func Toggle_Music():
	music_muted = !music_muted;
	Update_Sound_Settings();
	AudioManager.Button_Press();
	SaveManager.Save_Game();
	
func Toggle_SFX():
	sfx_muted = !sfx_muted;
	Update_Sound_Settings();
	AudioManager.Button_Press();
	SaveManager.Save_Game();

func Coin_Collected():
	$Coin_Collected.play();


func Update_Sound_Settings():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), music_muted);
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), sfx_muted);

