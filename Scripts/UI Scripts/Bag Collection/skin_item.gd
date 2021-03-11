extends Node

var skin: String ="brown";
var price: int = 100;
var unlocked: bool = false

func set_skin(skin_name: String, cost: int):
	skin = skin_name;
	price = cost;
	
	var fileName: String = GameManager.skin_dict[skin_name].fileName
	unlocked = GameManager.skin_unlocks[skin_name];
	
	var fullPath: String = ("res://SkinFrames/" + fileName);
	var spriteFrames: SpriteFrames = load(fullPath);
	get_node("TextureButton/skin_front").set_sprite_frames(spriteFrames);
	get_node("TextureButton/skin_front").set_animation("idle");
	
	get_node("TextureButton/skin_back").set_sprite_frames(spriteFrames);
	get_node("TextureButton/skin_back").set_animation("back");
	
	set_gfx();
	
	pass;


func set_gfx():
	get_node("TextureButton/price").text = String(price);
	get_node("TextureButton/price").visible = !unlocked;
	get_node("TextureButton/coin").visible = !unlocked;
	
	var col = 1;
	if(!unlocked): col = 0;
	get_node("TextureButton/skin_back").modulate = Color(col,col, col, 1);
	get_node("TextureButton/skin_front").modulate = Color(col,col, col, 1);


func _process(_delta):
	if(GameManager.current_skin == skin):
		$TextureButton.pressed = true;
	else:
		$TextureButton.pressed = false;


func _on_TextureButton_pressed():
	if(!unlocked):
		if(GameManager.coins >= price):
			purchase_skin()
		else:
			AudioManager.Button_Back();
			pass
	else:
		AudioManager.Button_Press();
		GameManager.current_skin = skin;
		SaveManager.Save_Game();
		pass # Replace with function body.


func purchase_skin():
	GameManager.skin_unlocks[skin] = true;
	GameManager.coins -= price;
	unlocked = true;
	
	#apply the skin
	AudioManager.Button_Press();
	GameManager.current_skin = skin;
	SaveManager.Save_Game();	
	set_gfx();
