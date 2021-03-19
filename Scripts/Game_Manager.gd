extends Node

#debug
var show_logs = true;

enum GAME_STATE {pre_game, playing, gameOver, paused};

var game_state = GAME_STATE.pre_game;


#game vars
var score: int = 0;
var misses: int = 0;
var highScore: int = 0;

var multiplier: int = 1;
var max_multiplier: int = 10;
var multiplier_progress = 0;
var multiplier_progress_max = 4;


var coins: int = 0;
var current_skin: String = "brown";
var skin_unlocks = {}; #dictionary to store unlocks
var player: Node = null;

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
	setup_unlocks();

	
	if(show_logs):
		print("PAPER OR PLASTIC RELOADED");
		print("=============================");
	pass # Replace with function body.


func Reset_Game():
	misses = 0;
	score = 0;
	game_state = GAME_STATE.pre_game;
	get_tree().paused = false;


	
	
#called when the player misses an item
func Item_Missed():
	if(game_state != GAME_STATE.playing): return;
	misses += 1;
	multiplier = 1;
	multiplier_progress = 0;
	player.miss_animation();
	#shake screen
	get_node("/root/Game/ShakeCamera2D").add_trauma(0.5)
	
	if(misses >= 3):
		misses = 3;
		Game_over();
		
	AudioManager.Item_Missed();

	get_node("/root/Game/screenTint").visible = true;
	yield(get_tree().create_timer(1), "timeout");
	get_node("/root/Game/screenTint").visible = false;


func Item_Caught(body):
	if(game_state != GAME_STATE.playing): return;
	
	
	if(multiplier_progress < multiplier_progress_max):
		multiplier_progress += 1;
	
	if(multiplier < max_multiplier && multiplier_progress >= multiplier_progress_max): 
		multiplier += 1;
		multiplier_progress = 0;
		
		
	score += 1 * multiplier;
	
	
	if(score > highScore):
		highScore = score;
		
	#collection stats
	print(body.type);
	if(body.type == "orange"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		orange_col += 1;
	elif(body.type == "apple"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		apple_col += 1;
	elif(body.type == "bread"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		bread_col += 1;
	elif(body.type == "carrot"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		carrot_col += 1;
	elif(body.type == "cheese"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		cheese_col += 1;
	elif(body.type == "chocolate"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		chocolate_col += 1;
	elif(body.type == "chips"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		chips_col += 1;
	elif(body.type == "donut"):
		donut_col += 1;
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.2)
	elif(body.type == "ketchup"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.2)
		ketchup_col += 1;
	elif(body.type == "milk"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.3)
		milk_col += 1;
	elif(body.type == "peanutButter"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.3)
		peanutButter_col += 1;
	elif(body.type == "soda"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.1)
		soda_col += 1;
	elif(body.type == "soup"):
		get_node("/root/Game/ShakeCamera2D").add_trauma(0.2)
		soup_col += 1;
	else:
		print("unidentified item caught " + body.type);

func Coin_Caught():
	coins += 1;
	coins_col += 1;
	AudioManager.Coin_Collected();


#called when the player misses 3 items
func Game_over(): 
	if(game_state == GAME_STATE.gameOver): return;
	game_state = GAME_STATE.gameOver
	
	#save the current game
	SaveManager.Save_Game();
	

func Pause_Game():
	game_state = GAME_STATE.paused
	get_tree().paused = true;

func Resume_Game():
	game_state = GAME_STATE.playing
	get_tree().paused = false;

func Change_Room(roomName):
	if(loading): return;
	var time = 1.5;
	get_node("Load_screen").ShowLoadScreen(time);
	loading = true;
	yield(get_tree().create_timer(time), "timeout");
	
	if get_tree().change_scene("res://Scenes/Rooms/" + roomName + ".tscn") != OK:
		print("error loading new scene " + roomName)
	GameManager.Reset_Game();




#Region skin system
func setup_unlocks():
	skin_unlocks.clear(); #make sure the dict is empty
	for key in skin_dict:
		if(key == "brown"):
			skin_unlocks[key] = true;
		else:
			skin_unlocks[key] = false;

var skin_dict = {
	"brown": { 
		"name": "BARRY",
		"fileName": "bag_brown.tres",
		"price": 25 },
	"blue:": { 
		"name": "BILLY",
		"fileName": "bag_blue.tres",
		"price": 25 },
	"green": { 
		"name": "GARY",
		"fileName": "bag_green.tres",
		"price": 25 },
	"pink": { 
		"name": "PENNY",
		"fileName": "bag_pink.tres",
		"price": 25 },
	"purple":{
		"name": "PERRI",
		"fileName": "bag_purple.tres",
		"price": 25 },
	"red": { 
		"name": "JERRY",
		"fileName": "bag_red.tres",
		"price": 25 },
	"knight": { 
		"name": "SIR WILLIAM",
		"fileName": "bag_knight.tres",
		"price": 50 },
	"viking": { 
		"name": "JORIS",
		"fileName": "bag_viking.tres",
		"price": 50 },
	"roman": { 
		"name": "ALEX",
		"fileName": "bag_roman.tres",
		"price": 50 },
	"scuba": { 
		"name": "SNORKEL",
		"fileName": "bag_scuba.tres",
		"price": 35 },
	"cat": { 
		"name": "STOMPY",
		"fileName": "bag_cat.tres",
		"price": 35 },
	"dog": { 
		"name": "PUDGY",
		"fileName": "bag_dog.tres",
		"price": 35 },
	"suit": { 
		"name": "PETER",
		"fileName": "bag_suit.tres",
		"price": 35 },
	"doctor": { 
		"name": "DR. HUGH",
		"fileName": "bag_doctor.tres",
		"price": 35 },
	"pilot": { 
		"name": "CAPTAIN FRANK",
		"fileName": "bag_pilot.tres",
		"price": 35 },
	"army":{ 
		"name": "DAN",
		"fileName": "bag_army.tres",
		"price": 35 },
	"construct": { 
		"name": "BOB",
		"fileName": "bag_construct.tres",
		"price": 35 },
	"zombie": { 
		"name": "BITER",
		"fileName": "bag_zombie.tres",
		"price": 35 },
	"skull": { 
		"name": "DOOT",
		"fileName": "bag_skull.tres",
		"price": 50 },
	"devil": { 
		"name": "STAN",
		"fileName": "bag_devil.tres",
		"price": 50 },
	"angel": { 
		"name": "ANGELICA",
		"fileName": "bag_angel.tres",
		"price": 50 },
	"boy": { 
		"name": "BAG BOY",
		"fileName": "bag_boy.tres",
		"price": 50 },
	"alien": { 
		"name": "ALLEN",
		"fileName": "bag_alien.tres",
		"price": 35 },
	"farmer": { 
		"name": "JOHN BROWN",
		"fileName": "bag_farmer.tres",
		"price": 35 },
	"cow": { 
		"name": "DAISY",
		"fileName": "bag_cow.tres",
		"price": 35 },
	"fish": { 
		"name": "SMALLFINS",
		"fileName": "bag_fish.tres",
		"price": 35 },
	"shark": { 
		"name": "GNAWS",
		"fileName": "bag_shark.tres",
		"price": 50 },
	"robot": { 
		"name": "00110110x3",
		"fileName": "bag_robot.tres",
		"price": 50 },
	"gorilla": { 
		"name": "HARAMBO",
		"fileName": "bag_gorilla.tres",
		"price": 35 },
	"football": { 
		"name": "CHRIS",
		"fileName": "bag_football.tres",
		"price": 35 },
	"princess": { 
		"name": "CINDERBELLA",
		"fileName": "bag_princess.tres",
		"price": 35 },
	"king": { 
		"name": "KING GEORGE",
		"fileName": "bag_king.tres",
		"price": 35 },
	"scientist": { 
		"name": "ALBERT",
		"fileName": "bag_scientist.tres",
		"price": 50 },
	"blaike": { 
		"name": "HAT GUY",
		"fileName": "bag_blaike.tres",
		"price": 35 },
	"astronaut": { 
		"name": "BUZZ",
		"fileName": "bag_astronaut.tres",
		"price": 50 },
	"nathan": { 
		"name": "NATHAN",
		"fileName": "bag_nathan.tres",
		"price": 35 },
	"penguin": { 
		"name": "WADDLES",
		"fileName": "bag_penguin.tres",
		"price": 35 },
	"ginger": { 
		"name": "GINGY",
		"fileName": "bag_ginger.tres",
		"price": 50 },
	"elf": { 
		"name": "JANGLES",
		"fileName": "bag_elf.tres",
		"price": 50 },
	"snowman": { 
		"name": "FROSTY",
		"fileName": "bag_snowman.tres",
		"price": 50 },
	"deer": { 
		"name": "RUDOLPH",
		"fileName": "bag_deer.tres",
		"price": 35 },
	"santa": { 
		"name": "NICK",
		"fileName": "bag_santa.tres",
		"price": 50 }
}




