extends Node2D

#load items
const Item_1 = preload("res://Scenes/Items/orange.tscn");
const Item_2 = preload("res://Scenes/Items/apple.tscn");
const Item_3 = preload("res://Scenes/Items/bread.tscn");
const Item_4 = preload("res://Scenes/Items/carrot.tscn");
const Item_5 = preload("res://Scenes/Items/cheese.tscn");
const Item_6 = preload("res://Scenes/Items/chips.tscn");
const Item_7 = preload("res://Scenes/Items/chocolate.tscn");
const Item_8 = preload("res://Scenes/Items/donut.tscn");
const Item_9 = preload("res://Scenes/Items/ketchup.tscn");
const Item_10 = preload("res://Scenes/Items/milk.tscn");
const Item_11 = preload("res://Scenes/Items/peanutButter.tscn");
const Item_12 = preload("res://Scenes/Items/soup.tscn");
const Item_13 = preload("res://Scenes/Items/soda.tscn");


const itemList = [Item_1, Item_2, Item_3, Item_4, Item_5, Item_6, Item_7, Item_8, Item_9, Item_10, Item_11, Item_12, Item_13]; #list of all items

var spawnTime = 2;
var initialDelay = 2;
var spawnReady: bool = false; #for the timer function
var spawnerStarted: bool = false;
var random = RandomNumberGenerator.new();


func start_spawner():
	if(spawnerStarted): return;
	spawnerStarted = true;
	yield(get_tree().create_timer(initialDelay), "timeout");
	spawnReady = true;
	yield(get_tree().create_timer(initialDelay), "timeout");
	get_node("../Coin_Spawner").spawnReady = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GameManager.game_state != GameManager.GAME_STATE.playing || !spawnReady): return; #return if the game isn't currently playing
	var index = 0;
	
	if(GameManager.score > 10): index = random.randf_range(0,2)
	if(GameManager.score > 20): index = random.randf_range(0,3)
	if(GameManager.score > 50): index = random.randf_range(0,5)
	if(GameManager.score > 150): index = random.randf_range(0,6)
	if(GameManager.score > 400): index = random.randf_range(0,10)
	if(GameManager.score > 600): index = random.randf_range(0,13)

	_spawnItem(itemList[index]);

	if(GameManager.game_state != GameManager.GAME_STATE.pre_game):
		$tutorial.visible = false;


func Update_Spawn_Time():
	spawnTime = random.randf_range(0.75, 1.25);
	if(GameManager.score > 25): spawnTime = random.randf_range(0.60, 1);
	if(GameManager.score > 50): spawnTime = random.randf_range(0.50, 0.75);
	if(GameManager.score > 150): spawnTime = random.randf_range(0.45, 0.5);
	if(GameManager.score > 400): spawnTime = random.randf_range(.40, 0.45);


#spawns an item at a random location in the game
func _spawnItem(item):
	if(!spawnReady ||GameManager.game_state != GameManager.GAME_STATE.playing):
		return;
		
	spawnReady = false;
	
	#spawn the item
	var spawnedItem = item.instance();
	add_child(spawnedItem);
	
	#set its position
	var itemPos = Vector2();
	itemPos.y = position.y;
	itemPos.x = random.randf_range(15, get_viewport_rect().size.x - 15);
	spawnedItem.position = itemPos;
	
	#set its rotation
	spawnedItem.rotation = random.randf_range(0, 360);
	
	#reset the timer
	yield(get_tree().create_timer(spawnTime), "timeout");
	spawnReady = true;
	Update_Spawn_Time(); #set a new spawn time
