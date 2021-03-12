extends KinematicBody2D

export (int) var speed = 200;

var start_pos;
var game_started = false;

func _ready():
	start_pos = position.x;
	GameManager.player = self;

func _physics_process(delta):
	if(GameManager.game_state != GameManager.GAME_STATE.playing && GameManager.game_state != GameManager.GAME_STATE.pre_game): return;
	var newPos = Vector2();
	newPos.x = get_viewport().get_mouse_position().x;
	newPos.y = position.y;
	position = lerp(position, newPos, 6 * delta);
	
func _process(_delta):
	if(game_started): return;
	if(position.x != start_pos):
		game_started = true;
		GameManager.game_state = GameManager.GAME_STATE.playing;
		get_node("../Item_Spawner").start_spawner();

func miss_animation():
	if(get_node("SkinLoader/Front").get_animation() == "miss"): return;
	get_node("SkinLoader/Front").play("miss");
	yield( get_node("SkinLoader/Front"), "animation_finished" );
	yield(get_tree().create_timer(1), "timeout");
	get_node("SkinLoader/Front").play("idle");

