class_name Asteroid
extends Area2D
signal exploded(pos,size)
enum AsteroidSize {LARGE,MEDIUM,SMALL}
@onready var asteroid_spr:=$Sprite_Asteroid
@onready var asteroid_cs:=$CollisionShape2D
@export var rotation_min:float =-4
@export var rotation_max:float = 4


@export var size:=AsteroidSize.LARGE
var life:int = 20
var move_vect=Vector2(0,-1)
var speed:float=0
var rot:float=0
var angle:float=0

# Called when the node enters the scene tree for the first time.
func _ready():
	match size:
		AsteroidSize.LARGE:
			asteroid_spr.texture=preload("res://asteroid/asteroid_ls.png")
			asteroid_cs.shape=preload("res://asteroid/resources/asteroid_ls.tres")
			speed= randf_range(50,100)
			life=20
		AsteroidSize.MEDIUM:
			asteroid_spr.texture=preload("res://asteroid/asteroid_ms.png")
			asteroid_cs.shape=preload("res://asteroid/resources/asteroid_ms.tres")
			speed=randf_range(100,150)
			life=10
		AsteroidSize.SMALL:
			asteroid_spr.texture=preload("res://asteroid/asteroid_ss.png")
			asteroid_cs.shape=preload("res://asteroid/resources/asteroid_ss.tres")
			speed=randf_range(200,300)
			life=1
	rot=randf_range(rotation_min,rotation_max)
	angle=randf_range(-PI,PI)
	position.rotated(angle)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position+=move_vect.rotated(angle)*speed * delta
	rotation_degrees+=rot
	var screen_size:=get_viewport_rect().size

	if global_position.y < 0:
		global_position.y = screen_size.y
	if global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x=screen_size.x
	if global_position.x > screen_size.x:
		global_position.x= 0

func damage(amount: int):
	life-=amount
	print(life)
	if life <= 0 :
		print("signal emitted")
		emit_signal("exploded",global_position,size)		
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	pass
func _on_area_entered(area):
	if area.is_in_group("hurt_player"):
		area.damage(1)
