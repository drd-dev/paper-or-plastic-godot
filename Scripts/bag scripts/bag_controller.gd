extends KinematicBody2D

export (int) var speed = 200;



func _physics_process(delta):
	if(GameManager.game_state != GameManager.GAME_STATE.playing): return;
	var newPos = Vector2();
	newPos.x = get_viewport().get_mouse_position().x;
	newPos.y = position.y;
	position = lerp(position, newPos, 6 * delta);
	
