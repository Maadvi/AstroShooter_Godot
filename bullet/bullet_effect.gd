extends Sprite2D
func _ready():
	##pass
	$FastExplosion.play()
func _on_timer_timeout():
	queue_free()
