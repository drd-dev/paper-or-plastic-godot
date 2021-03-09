extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var activationHeight = 150;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(position.y > activationHeight):
		$AnimatedSprite.frame = 1;
	
	
	
	if(position.y > 600 || position.x > 300 || position.x < -100):
		GameManager.Item_Missed();
		queue_free(); #delete the item
#	pass
