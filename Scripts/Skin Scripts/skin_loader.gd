extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_skin(GameManager.current_skin);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _process(delta):
	scale = lerp(scale, Vector2(1,1), 5 * delta);


func load_skin(skin_name):
	var fileName: String = GameManager.skin_dict[skin_name].fileName
	
	var fullPath: String = ("res://SkinFrames/" + fileName);
	var spriteFrames: SpriteFrames = load(fullPath);
	$Front.set_sprite_frames(spriteFrames);
	$Front.set_animation("idle");
	
	$Back.set_sprite_frames(spriteFrames);
	$Back.set_animation("back");
	pass;




