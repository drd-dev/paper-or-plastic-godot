extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var paused = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("score").text = String(GameManager.score);
	get_node("highScore").text = String(GameManager.highScore);
	
	if(GameManager.game_state == GameManager.GAME_STATE.paused):
		get_node("../buttons/resume_button").visible = true;
	else:
		get_node("../buttons/resume_button").visible = false;
