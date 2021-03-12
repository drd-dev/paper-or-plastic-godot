extends Node

#debug
var show_logs = true;

enum GAME_STATE {pre_game, playing, gameOver, paused};

var game_state = GAME_STATE.pre_game;


#game vars
var score = 0;
var misses = 0;
var highScore = 0;
var coins = 0;
var current_skin = "brown";
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
	player.miss_animation();
	#shake screen
	get_node("/root/Game/ShakeCamera2D").add_trauma(0.5)
	
	
	if(misses >= 3):
		misses = 3;
		Game_over();
		
	AudioManager.Item_Missed();

func Item_Caught(body):
	if(game_state != GAME_STATE.playing): return;
	
	score += 1;
	if(score > highScore):
		highScore = score;
		
	#collection stats
	print(body.type);
	if(body.type == "orange"):
		orange_col += 1;
	elif(body.type == "apple"):
		apple_col += 1;
	elif(body.type == "bread"):
		bread_col += 1;
	elif(body.type == "carrot"):
		carrot_col += 1;
	elif(body.type == "cheese"):
		cheese_col += 1;
	elif(body.type == "chocolate"):
		chocolate_col += 1;
	elif(body.type == "chips"):
		chips_col += 1;
	elif(body.type == "donut"):
		donut_col += 1;
	elif(body.type == "ketchup"):
		ketchup_col += 1;
	elif(body.type == "milk"):
		milk_col += 1;
	elif(body.type == "peanutButter"):
		peanutButter_col += 1;
	elif(body.type == "soda"):
		soda_col += 1;
	elif(body.type == "soup"):
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
		"fileName": "bag_brown.tres" },
	"blue:": { 
		"name": "BILLY",
		"fileName": "bag_blue.tres" },
	"green": { 
		"name": "GARY",
		"fileName": "bag_green.tres" },
	"pink": { 
		"name": "PENNY",
		"fileName": "bag_pink.tres" },
	"purple":{
		"name": "PERRI",
		"fileName": "bag_purple.tres" },
	"red": { 
		"name": "JERRY",
		"fileName": "bag_red.tres" },
	"knight": { 
		"name": "SIR WILLIAM",
		"fileName": "bag_knight.tres" },
	"viking": { 
		"name": "JORIS",
		"fileName": "bag_viking.tres" },
	"roman": { 
		"name": "ALEX",
		"fileName": "bag_roman.tres" },
	"scuba": { 
		"name": "SNORKEL",
		"fileName": "bag_scuba.tres" },
	"cat": { 
		"name": "STOMPY",
		"fileName": "bag_cat.tres" },
	"dog": { 
		"name": "PUDGY",
		"fileName": "bag_dog.tres" },
	"suit": { 
		"name": "PETER",
		"fileName": "bag_suit.tres" },
	"doctor": { 
		"name": "DR. HUGH",
		"fileName": "bag_doctor.tres" },
	"pilot": { 
		"name": "CAPTAIN FRANK",
		"fileName": "bag_pilot.tres" },
	"army":{ 
		"name": "DAN",
		"fileName": "bag_army.tres" },
	"construct": { 
		"name": "BOB",
		"fileName": "bag_construct.tres" },
	"zombie": { 
		"name": "BITER",
		"fileName": "bag_zombie.tres" },
	"skull": { 
		"name": "DOOT",
		"fileName": "bag_skull.tres" },
	"devil": { 
		"name": "STAN",
		"fileName": "bag_devil.tres" },
	"angel": { 
		"name": "ANGELICA",
		"fileName": "bag_angel.tres" },
	"boy": { 
		"name": "BAG BOY",
		"fileName": "bag_boy.tres" },
	"alien": { 
		"name": "ALLEN",
		"fileName": "bag_alien.tres" },
	"farmer": { 
		"name": "JOHN BROWN",
		"fileName": "bag_farmer.tres" },
	"cow": { 
		"name": "DAISY",
		"fileName": "bag_cow.tres" },
	"fish": { 
		"name": "SMALLFINS",
		"fileName": "bag_fish.tres" },
	"shark": { 
		"name": "GNAWS",
		"fileName": "bag_shark.tres" },
	"robot": { 
		"name": "00110110x3",
		"fileName": "bag_robot.tres" },
	"gorilla": { 
		"name": "HARAMBO",
		"fileName": "bag_gorilla.tres" },
	"football": { 
		"name": "CHRIS",
		"fileName": "bag_football.tres" },
	"princess": { 
		"name": "CINDERBELLA",
		"fileName": "bag_princess.tres" },
	"king": { 
		"name": "KING GEORGE",
		"fileName": "bag_king.tres" },
	"scientist": { 
		"name": "ALBERT",
		"fileName": "bag_scientist.tres" },
	"blaike": { 
		"name": "HAT GUY",
		"fileName": "bag_blaike.tres" },
	"astronaut": { 
		"name": "BUZZ",
		"fileName": "bag_astronaut.tres" },
	"nathan": { 
		"name": "NATHAN",
		"fileName": "bag_nathan.tres" },
	"penguin": { 
		"name": "WADDLES",
		"fileName": "bag_penguin.tres" },
	"ginger": { 
		"name": "GINGY",
		"fileName": "bag_ginger.tres" },
	"elf": { 
		"name": "JANGLES",
		"fileName": "bag_elf.tres" },
	"snowman": { 
		"name": "FROSTY",
		"fileName": "bag_snowman.tres" },
	"deer": { 
		"name": "RUDOLPH",
		"fileName": "bag_deer.tres" },
	"santa": { 
		"name": "NICK",
		"fileName": "bag_santa.tres"},
}




