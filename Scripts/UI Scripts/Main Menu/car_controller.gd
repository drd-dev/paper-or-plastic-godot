extends Node2D


export var speed = 1;

var random = RandomNumberGenerator.new();

func _ready():
	$AudioStreamPlayer2D.pitch_scale = random.randf_range(0.5, 1.5);

func _process(delta):
	position.x += speed * delta;
	
	if(position.x < -301 || position.x > get_viewport_rect().size.x + 301):
		queue_free();
