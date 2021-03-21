extends Node



var score: float = 0;
var max_reached = false;
var high_score_beat: bool = false;
var highScore: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("highScore").visible = false;
	highScore = GameManager.highScore;
	pass # Replace with function body.


func _process(delta):
	$Misses.frame = GameManager.misses;
	score = lerp(score, GameManager.score, 5 * delta);
	var s = round(score);
	get_node("ScorePanel/Label").text = String( s ) ;
	
	
	get_node("multiplier_fill").scale = lerp(get_node("multiplier_fill").scale, Vector2(1.25,1.25), 5 * delta);
	
	get_node("multiplier_fill/multiplier").text = String(GameManager.multiplier);
	
	if(GameManager.multiplier < GameManager.max_multiplier):
		get_node("multiplier_fill").frame = GameManager.multiplier_progress;
	else:
		get_node("multiplier_fill").frame = 4;
		


	if(GameManager.score > highScore) && highScore != 0:
		if(!high_score_beat):
			high_score_beat = true;
			var hs = get_node("highScore");
			AudioManager.high_score();
			hs.visible = true;
			yield(get_tree().create_timer(2), "timeout");
			hs.visible = false;


	
	if(GameManager.multiplier >= 10):
		$CPUParticles2D.emitting = true;
		if(!max_reached):
			$burst.emitting = true;
			max_reached = true;
			AudioManager.max_multiplier();
	else:
		$CPUParticles2D.emitting = false;
		max_reached = false;
		
		



func _on_Pause_Button_pressed():
	AudioManager.Button_Press();
	GameManager.Pause_Game();
	pass # Replace with function body.
