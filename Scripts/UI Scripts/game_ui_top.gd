extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$Misses.frame = GameManager.misses;
	var count = GameManager.score;
	get_node("ScorePanel/Label").text = String(count);
	

func _on_Pause_Button_pressed():
	AudioManager.Button_Press();
	GameManager.Pause_Game();
	pass # Replace with function body.
