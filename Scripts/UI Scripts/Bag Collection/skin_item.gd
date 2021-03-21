extends Node

var skin: String ="brown";
var price: int = 100;
var unlocked: bool = false


var front;
var back;

func _ready():
	front = get_node("TextureButton/skin_front")
	back = get_node("TextureButton/skin_back")

func set_skin(skin_name: String):
	skin = skin_name;
	price = GameManager.skin_dict[skin_name].price;
	
	var fileName: String = GameManager.skin_dict[skin_name].fileName
	unlocked = GameManager.skin_unlocks[skin_name];
	
	var fullPath: String = ("res://SkinFrames/" + fileName);
	var spriteFrames: SpriteFrames = load(fullPath);
	front.set_sprite_frames(spriteFrames);
	front.set_animation("idle");
	
	back.set_sprite_frames(spriteFrames);
	back.set_animation("back");
	
	set_gfx();
	
	pass;


func set_gfx():
	get_node("TextureButton/price").text = String(price);
	get_node("TextureButton/price").visible = !unlocked;
	get_node("TextureButton/coin").visible = !unlocked;
	
	var col = 1;
	if(!unlocked): col = .1;
	back.modulate = Color(col,col, col, 1);
	front.modulate = Color(col,col, col, 1);


func _process(delta):
	
	back.scale = lerp(back.scale, Vector2(0.6, 0.6), 5 * delta);
	front.scale = lerp(front.scale, Vector2(0.6, 0.6), 5 * delta);
	
	if(GameManager.current_skin == skin):
		$TextureButton.pressed = true;
	else:
		$TextureButton.pressed = false;


func _on_TextureButton_pressed():
	if(!unlocked):
		if(GameManager.coins >= price):
			purchase_skin()
			front.scale = Vector2(1,1);
			back.scale = Vector2(1,1);
		else:
			AudioManager.Button_Back();
			pass
	else:
		AudioManager.Button_Press();
		GameManager.current_skin = skin;
		front.scale = Vector2(.8,.8);
		back.scale = Vector2(.8,.8);
		SaveManager.Save_Game();
		pass # Replace with function body.


func purchase_skin():
	GameManager.skin_unlocks[skin] = true;
	get_node("TextureButton/CPUParticles2D").emitting = true;
	$AudioStreamPlayer.play();
	GameManager.coins -= price;
	unlocked = true;
	
	#apply the skin
	AudioManager.Button_Press();
	GameManager.current_skin = skin;
	SaveManager.Save_Game();	
	set_gfx();
