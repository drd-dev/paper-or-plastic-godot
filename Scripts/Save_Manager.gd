extends Node



#unlocks


#save system
var path: String = "user://save_data.cfg"
var config = ConfigFile.new();
var processing = false;



# Called when the node enters the scene tree for the first time.
func _ready():
	Load_Save();
	pass # Replace with function body.


#saves the game
func Save_Game():
	if(processing): return;
	processing = true;
	if(GameManager.show_logs): print("saving game...")
	#audio
	config.set_value("audio", "music_muted", AudioManager.music_muted);
	config.set_value("audio", "sfx_muted", AudioManager.sfx_muted);
	
	#stats
	config.set_value("stats", "high_score", GameManager.highScore);	
	config.set_value("stats", "coins", GameManager.coins);

	
	
	#collection stats
	config.set_value("stats", "items_col", GameManager.items_col);
	config.set_value("stats", "apple_col", GameManager.apple_col);
	config.set_value("stats", "bread_col", GameManager.bread_col);
	config.set_value("stats", "carrot_col", GameManager.carrot_col);
	config.set_value("stats", "cheese_col", GameManager.cheese_col);
	config.set_value("stats", "chips_col", GameManager.chips_col);
	config.set_value("stats", "chocolate_col", GameManager.chocolate_col);
	config.set_value("stats", "donut_col", GameManager.donut_col);
	config.set_value("stats", "ketchup_col", GameManager.ketchup_col);
	config.set_value("stats", "milk_col", GameManager.milk_col);
	config.set_value("stats", "orange_col", GameManager.orange_col);
	config.set_value("stats", "peanutButter_col", GameManager.peanutButter_col);
	config.set_value("stats", "soda_col", GameManager.soda_col);
	config.set_value("stats", "soup_col", GameManager.soup_col);
	config.set_value("stats", "coins_col", GameManager.coins_col);
	
	#unlocks
	config.set_value("unlocks", "current_skin", GameManager.current_skin);
	config.set_value("unlocks", "skin_unlocks", GameManager.skin_unlocks);

	
	config.save(path); #save the file
	if(GameManager.show_logs): print("save completed.")
	processing = false
	pass;

#loads the players save file
func Load_Save():
	if(processing): return;
	processing = true;
	if(GameManager.show_logs): print("loading save...")
	var err = config.load(path);
	if err == OK:
		#load audio states
		AudioManager.music_muted = config.get_value("audio", "music_muted", false);
		AudioManager.sfx_muted = config.get_value("audio", "sfx_muted", false);
		AudioManager.Update_Sound_Settings();  #update the audio manager after we load settings
		
		#load stats
		GameManager.highScore = config.get_value("stats", "high_score", 0);
		GameManager.coins = config.get_value("stats", "coins", 0);
		
		#collection stats
		GameManager.items_col = config.get_value("stats", "items_col", 0)
		GameManager.apple_col = config.get_value("stats", "apple_col", 0);
		GameManager.apple_col = config.get_value("stats", "apple_col", 0);
		GameManager.bread_col = config.get_value("stats", "bread_col", 0);
		GameManager.carrot_col = config.get_value("stats", "carrot_col", 0);
		GameManager.cheese_col = config.get_value("stats", "cheese_col", 0);
		GameManager.chips_col = config.get_value("stats", "chips_col", 0);
		GameManager.chocolate_col = config.get_value("stats", "chocolate_col", 0);
		GameManager.donut_col = config.get_value("stats", "donut_col", 0);
		GameManager.ketchup_col = config.get_value("stats", "ketchup_col", 0);
		GameManager.milk_col = config.get_value("stats", "milk_col", 0);
		GameManager.orange_col = config.get_value("stats", "orange_col", 0);
		GameManager.peanutButter_col = config.get_value("stats", "peanutButter_col", 0);
		GameManager.soda_col = config.get_value("stats", "soda_col", 0);
		GameManager.soup_col = config.get_value("stats", "soup_col", 0);
		GameManager.coins_col = config.get_value("stats", "coins_col", 0);

		
		#unlocks
		GameManager.current_skin = config.get_value("unlocks", "current_skin", "brown");
		GameManager.skin_unlocks = config.get_value("unlocks", "skin_unlocks", {});
		
		if(GameManager.show_logs):
			print("Bag Unlock Data:")
			print(GameManager.skin_unlocks)
			print("load completed")
		processing = false;
	else:
		if(GameManager.show_logs): print("no save currently exists, creating a new one now...")
		processing = false;
		Save_Game(); #setup a new save if one doesnt currently exist or we cant open ones
