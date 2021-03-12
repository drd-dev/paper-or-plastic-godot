extends Area2D

var gameManager
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body.is_in_group("collectables")):
		body.queue_free();
		get_node("../AudioPlayer").play(); #play audio
		GameManager.Item_Caught(body);
		
	if(body.is_in_group("coins")):
		body.queue_free();
		GameManager.Coin_Caught();

		
	pass # Replace with function body.
