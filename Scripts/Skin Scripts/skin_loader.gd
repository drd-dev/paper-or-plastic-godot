extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_skin("doctor");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func load_skin(skin_name):
	var fileName: String = skin_dict[skin_name].fileName
	
	var fullPath: String = ("res://SkinFrames/" + fileName);
	var spriteFrames: SpriteFrames = load(fullPath);
	$Front.set_sprite_frames(spriteFrames);
	$Front.set_animation("idle");
	
	$Back.set_sprite_frames(spriteFrames);
	$Back.set_animation("back");
	pass;



var skin_dict = {
	"brown": { "fileName": "bag_brown.tres" },
	"blue:": { "fileName": "bag_blue.tres" },
	"green": { "fileName": "bag_green.tres" },
	"pink": { "fileName": "bag_pink.tres" },
	"red": { "fileName": "bag_red.tres" },
	"knight": { "fileName": "bag_knight.tres" },
	"viking": { "fileName": "bag_viking.tres" },
	"roman": { "fileName": "bag_roman.tres" },
	"scuba": { "fileName": "bag_scuba.tres" },
	"cat": { "fileName": "bag_cat.tres" },
	"dog": { "fileName": "bag_dog.tres" },
	"suit": { "fileName": "bag_suit.tres" },
	"doctor": { "fileName": "bag_doctor.tres" },
	"pilot": { "fileName": "bag_pilot.tres" },
	"army":{ "fileName": "bag_army.tres" },
	"construct": {},
	"zombie": {},
	"skull": {},
	"devil": {},
	"angel": {},
	"boy": {},
	"alien": {},
	"farmer": {},
	"cow": {},
	"fish": {},
	"robot": {},
	"gorilla": {},
	"football": {},
	"princess": {},
	"king": {},
	"scientist": {},
	"blaike": {},
	"astronaut": {},
	"nathan": {},
	"penguin": {},
	"ginger": {},
	"elf": {},
	"snowman": {},
	"deer": {},
	"santa": {},
}
