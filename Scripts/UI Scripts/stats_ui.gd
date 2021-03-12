extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_stats();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_stats():
	var container = get_node("GridContainer");
	
	container.get_node("coins/label").text = String(GameManager.coins_col);
	container.get_node("oranges/label").text = String(GameManager.orange_col);
	container.get_node("apples/label").text = String(GameManager.apple_col);
	container.get_node("bread/label").text = String(GameManager.bread_col);
	container.get_node("carrots/label").text = String(GameManager.carrot_col);
	container.get_node("cheese/label").text = String(GameManager.cheese_col);
	container.get_node("chips/label").text = String(GameManager.chips_col);
	container.get_node("chocolate/label").text = String(GameManager.chocolate_col);
	container.get_node("donut/label").text = String(GameManager.donut_col);
	container.get_node("ketchup/label").text = String(GameManager.ketchup_col);
	container.get_node("milk/label").text = String(GameManager.milk_col);
	container.get_node("peanutButter/label").text = String(GameManager.peanutButter_col);
	container.get_node("soup/label").text = String(GameManager.soup_col);
	container.get_node("soda/label").text = String(GameManager.soda_col);
	
	
	var g = GameManager;
	var totalItems = g.orange_col + g.apple_col + g.bread_col + g.carrot_col + g.cheese_col + g.chips_col + g.chocolate_col + g.donut_col + g.ketchup_col + g.milk_col + g.peanutButter_col + g.soda_col + g.soup_col;
	
	
	get_node("total_items").text = "Items Collected: " + String(totalItems);
	get_node("high_score").text = "High Score: " + String(GameManager.highScore);
