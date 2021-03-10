extends Node2D

#load items
const coin = preload("res://Scenes/Items/coin.tscn");

var spawnTime = 10;
var spawnReady: bool = true; #for the timer function
var random = RandomNumberGenerator.new();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GameManager.game_state != GameManager.GAME_STATE.playing): return; #return if the game isn't currently playing
	Update_Spawn_Time();
	_spawnItem(coin);

	pass;


func Update_Spawn_Time():
	spawnTime = random.randf_range(8, 12);
	if(GameManager.score > 25): spawnTime = random.randf_range(6, 10);
	if(GameManager.score > 50): spawnTime = random.randf_range(5, 8);
	if(GameManager.score > 75): spawnTime = random.randf_range(3, 4);
	if(GameManager.score > 100): spawnTime = random.randf_range(2, 3);


#spawns an item at a random location in the game
func _spawnItem(item):
	if(!spawnReady || GameManager.game_state != GameManager.GAME_STATE.playing):
		return;
		
	spawnReady = false;
	
	#spawn the item
	var spawnedItem = item.instance();
	add_child(spawnedItem);
	
	#set its position
	var itemPos = Vector2();
	itemPos.y = position.y;
	itemPos.x = random.randf_range(10, 240);
	spawnedItem.position = itemPos;
	
	#set its rotation
	spawnedItem.rotation = random.randf_range(0, 360);
	
	#reset the timer
	yield(get_tree().create_timer(spawnTime), "timeout");
	spawnReady = true;
	Update_Spawn_Time(); #set a new spawn time
