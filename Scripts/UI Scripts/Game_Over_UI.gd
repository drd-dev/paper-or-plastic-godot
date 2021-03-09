extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var showUI = false;




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(showUI):
		rect_position.y = lerp(rect_position.y, 150, 5 * delta);
