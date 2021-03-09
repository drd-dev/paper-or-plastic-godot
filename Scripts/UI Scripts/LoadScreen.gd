extends Node

var showLoad = false;
var showDone = false;

enum SCREEN_STATE { IDLE, FADE_IN, FADE_OUT }
var screen_state: int = SCREEN_STATE.IDLE;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(screen_state == SCREEN_STATE.FADE_IN):
		get_node("load_background").position.y = lerp(get_node("load_background").position.y, 150, 6 * delta);
		get_node("load_text").position.y = lerp(get_node("load_text").position.y, 150, 4 * delta);
	if(screen_state == SCREEN_STATE.FADE_OUT):
		get_node("load_background").position.y = lerp(get_node("load_background").position.y, 1000, 3 * delta);
		get_node("load_text").position.y = lerp(get_node("load_text").position.y, 1000, 5 * delta);
	if(screen_state == SCREEN_STATE.IDLE):
		get_node("load_background").position.y = - 1000;
		get_node("load_text").position.y = - 1000;	
#	pass


func ShowLoadScreen(time):
	if(screen_state == SCREEN_STATE.FADE_OUT || screen_state == SCREEN_STATE.FADE_IN || GameManager.loading): return;
	screen_state = SCREEN_STATE.FADE_IN;
	yield(get_tree().create_timer(time), "timeout");
	screen_state = SCREEN_STATE.FADE_OUT
	yield(get_tree().create_timer(.60), "timeout");
	screen_state = SCREEN_STATE.IDLE
	GameManager.loading = false;
