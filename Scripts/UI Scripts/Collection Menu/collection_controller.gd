extends Node2D

var skin_item = preload("res://Scenes/skin_item.tscn");

func _ready():
	load_collection();

func load_collection():
	var skins = GameManager.skin_dict;

	var rowCount: int = 0;
	for skin in skins:
		var newSkin: Control = skin_item.instance();
		get_node("skins/container").add_child(newSkin);
		
		#set the skin
		newSkin.set_skin(skin);	
	pass
	

