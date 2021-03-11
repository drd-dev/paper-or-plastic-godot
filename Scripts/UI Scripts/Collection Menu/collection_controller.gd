extends Node2D

export var xSpacing: float = 50;
export var ySpacing: float = 100;
export var xSize: int = 3;

var skin_item = preload("res://Scenes/skin_item.tscn");

func _ready():
	load_collection();

func load_collection():
	var skins = GameManager.skin_dict;
	var xPos: float
	var yPos: float
	var rowCount: int = 0;
	for skin in skins:
		var newSkin: Node2D = skin_item.instance();
		$skins.add_child(newSkin);
		newSkin.position.x = xPos;
		newSkin.position.y = yPos;
		
		#increase pos
		if(rowCount < xSize -1):
			xPos += xSpacing;
			rowCount += 1
		else:
			xPos = 0
			yPos += ySpacing;
			rowCount = 0;
		
		
	pass
	

