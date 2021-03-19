extends AnimatedSprite

var random = RandomNumberGenerator.new();
var time_set: bool = false;
var delay: float = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	stop();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	play_animation();
	
	if(get_owner().position.x < (255/2)):
		scale.x = 1;
	else:
		scale.x = -1;


func play_animation():
	if(time_set): return;
	stop();
	frame = 0;
	var delay = random.randf_range(1, 5);
	time_set = true;
	
	yield(get_tree().create_timer(delay), "timeout");
	play();
	
	yield( self, "animation_finished" )
	time_set = false;
