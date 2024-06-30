extends Area2D
@export var speed:float=400
@export var dissolving:=false
@export var BulletLife:float=2.8
@onready var blt:=$Sprite2D
var direction:=Vector2(0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(blt)
	#print(get_tree())
	$BulletLifeTimer.start(BulletLife)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !dissolving:
		translate(direction * speed * delta)
		direction=get_node("/root/Game/Player").global_position - global_position
		direction=direction.normalized()
		look_at(get_node("/root/Game/Player").global_position)
	else:
		#CollisionShape2D.visible=false
		scale+=Vector2(-.05,-.05)
		#print(scale)
		if scale < Vector2.ZERO:
			queue_free()
func _on_area_entered(area):
	if area.is_in_group("hurt_player"):
		#var bulleteffect:=plBulletEffect.instantiate()
		#bulleteffect.position = position
		#get_parent().add_child(bulleteffect)
		area.damage(1)
		queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_bullet_life_timer_timeout():
	#queue_free()
	dissolving=true
	
