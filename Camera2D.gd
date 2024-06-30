extends Camera2D
@export var RandomStrengnt = 30
@export var shake_fade = 5
var rng = RandomNumberGenerator.new()
var shake_strengnt:float=0
var ship_exploded:=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func apply_shake():
		shake_strengnt=RandomStrengnt
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ship_exploded:
		$Timer.start(.8)
		ship_exploded=false

	if !$Timer.is_stopped():
		apply_shake()
		if shake_strengnt >0:
			shake_strengnt=lerpf(shake_strengnt,0,shake_fade*delta)
			offset=RandomOffset()

func RandomOffset():
	return Vector2(rng.randf_range(-shake_strengnt,shake_strengnt),rng.randf_range(-shake_strengnt,shake_strengnt))
	

func _on_player_ship_exploded():
	ship_exploded=true


func _on_timer_timeout():
	offset=Vector2.ZERO
	pass # Replace with function body.
