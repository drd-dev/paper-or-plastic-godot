extends Node2D

export var type: String = "";

var activationHeight = 150;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(position.y > activationHeight):
		$AnimatedSprite.frame = 1;
	
	
	
	if(position.y > 600 || position.x > get_viewport_rect().size.x + 30 || position.x < - 30):
		GameManager.Item_Missed();
		queue_free(); #delete the item
#	pass
