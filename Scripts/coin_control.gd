extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if(position.y > 600 || position.x > 300 || position.x < -100):
		queue_free(); #delete the item
#	pass
