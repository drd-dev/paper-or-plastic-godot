extends Node2D


var flipDir: bool = false;

var spawnFreq = 5;
var spawnReady: bool = true;

var car_1 = preload("res://Scenes/cars/car_black.tscn");
var car_2 = preload("res://Scenes/cars/car_purple.tscn");
var car_3 = preload("res://Scenes/cars/car_orange.tscn");
var car_4 = preload("res://Scenes/cars/car_red.tscn");
var car_5 = preload("res://Scenes/cars/car_blue.tscn");
var car_6 = preload("res://Scenes/cars/car_green.tscn");


var cars = [car_1, car_2, car_3, car_4, car_5, car_6];

var random = RandomNumberGenerator.new();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	spawn_car();
	pass

func spawn_car():
	if(!spawnReady): return;
	spawnReady = false;
	var index = random.randf_range(0, cars.size());
	
	
	#spawn the item
	var spawnedCar = cars[index].instance();
	add_child(spawnedCar);
	
	#set its position
	var carPos = Vector2();
	if(!flipDir):
		carPos.y = 10;
		carPos.x = -300;
	else:
		carPos.y = -20;
		carPos.x = 400;
		spawnedCar.get_node("car_sprite").set_flip_h(true);
		spawnedCar.speed = -spawnedCar.speed;
		spawnedCar.z_index = 900;
	
	spawnedCar.position = carPos;
	
	
	yield(get_tree().create_timer(spawnFreq), "timeout");
	spawnFreq = random.randf_range(2, 4);
	flipDir = !flipDir;
	spawnReady = true;
