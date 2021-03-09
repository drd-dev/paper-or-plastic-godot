extends Node

var music_muted: bool = false;
var sfx_muted: bool = false;

func _ready():
	#set sound mutes when game loads
	Update_Sound_Settings();
	Play_Music();
	
	
func Button_Press():
	$Button_Press.play();

func Button_Back():
	$Button_Back.play();

func Item_Missed():
	$Miss_Sound.play();


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


func Play_Music():
	$Music_Game.play();


func Update_Sound_Settings():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), music_muted);
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), sfx_muted);

