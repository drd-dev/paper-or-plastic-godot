extends Node


var playing = false;
var gameOver = false;

#game vars
var score = 0;
var misses = 0;
var highScore = 0;
var coins = 0;

#collected items
var items_col: int = 0;
var orange_col: int = 0;
var apple_col: int = 0;
var carrot_col: int = 0;
var bread_col: int = 0;
var cheese_col: int = 0;
var chips_col: int = 0;
var chocolate_col: int = 0;
var donut_col: int = 0;
var ketchup_col: int = 0;
var milk_col: int = 0;
var peanutButter_col: int = 0;
var soda_col: int = 0;
var soup_col: int = 0;
var coins_col: int = 0;




var loading = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true);
	playing = true;
	pass # Replace with function body.


func Reset_Game():
	misses = 0;
	score = 0;
	playing = true;
	gameOver = false;
	get_tree().paused = false;




	
	
#called when the player misses an item
func Item_Missed():
	if(gameOver || !playing): return;
	misses += 1;
	
	#shake screen
	get_node("/root/Game/ShakeCamera2D").add_trauma(0.5)
	
	
	if(misses >= 3):
		misses = 3;
		Game_over();
		
	AudioManager.Item_Missed();

func Item_Caught():
	if(gameOver || !playing): return;
	
	score += 1;
	if(score > highScore):
		highScore = score;

func Coin_Caught():
	coins += 1;
	coins_col += 1;
	AudioManager.Coin_Collected();


#called when the player misses 3 items
func Game_over(): 
	if(gameOver): return;
	
	playing = false;
	gameOver = true;

	#show game over UI
	get_node("/root/Game/Game_Over_UI").showUI = true;
	
	#save the current game
	SaveManager.Save_Game();
	

func Pause_Game():
	playing = false;
	get_node("/root/Game/Game_Over_UI").showUI = true;
	get_tree().paused = true;

func Resume_Game():
	playing = true;
	get_node("/root/Game/Game_Over_UI").showUI = false;
	get_tree().paused = false;

func Change_Room(roomName):
	if(loading): return;
	var time = 1.5;
	get_node("Load_screen").ShowLoadScreen(time);
	loading = true;
	yield(get_tree().create_timer(time), "timeout");
	var r = get_tree().change_scene("res://Scenes/Rooms/" + roomName + ".tscn");
	print(r);
	GameManager.Reset_Game();


