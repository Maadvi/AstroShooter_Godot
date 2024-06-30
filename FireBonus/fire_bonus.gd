extends Path2D
@export var speed:float=200
@export var bonus_expired:=false
@export var bonus_act_timer=10
signal FireB_TO
# Called when the node enters the scene tree for the first time.
func _ready():
	$FireBonusTimer.start(bonus_act_timer)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$PathFollow2D.progress+=speed * delta
	if bonus_expired:
		scale+=Vector2(-.01,-.01)
		#print(scale)
		if scale < Vector2.ZERO:
			emit_signal("FireB_TO")
			queue_free()

func _on_fire_bonus_timer_timeout():
	bonus_expired=true
	
func _on_fire_b_to():
	pass # Replace with function body.
