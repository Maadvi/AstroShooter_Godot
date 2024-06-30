extends Area2D
signal exploded(pos,size)
@onready var FireT:=$FireTimer
@onready var fireposition=$FirePosition
var ufobullet := preload("res://ufo/bullet/ufo_bullet.tscn")
var life:int=10
var ufo_exploded:bool=false
#
func _ready():
	set_fire_timer()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pl:=get_tree().get_root().get_child(0).get_path()
	#print(pl)
	#pass
func _physics_process(delta):
	if !ufo_exploded:
		if FireT.is_stopped():
			ufo_shoot()
			set_fire_timer()
	else:
		scale+=Vector2(-.01,-.01)
		print("esplodo")
		print(scale)
		if scale < Vector2.ZERO:
			queue_free()
		
func set_fire_timer():
	var stime:=randf_range(4.0,10.0)
	FireT.start(stime)
	#print("start timer")
	
func damage(amount: int):
	life-=amount
	#print(life)
	if life <= 0 :
		#print("signal emitted")
		emit_signal("exploded",global_position,0)
		ufo_exploded=true

func _on_area_entered(area):
	print("ufo are entered")
	if area.is_in_group("hurt_player"):
		area.damage(1)
func ufo_shoot():
	if is_instance_valid(get_node("/root/Game/Player")) :
		var bullet := ufobullet.instantiate()
		bullet.global_position = fireposition.global_position
		get_tree().current_scene.add_child(bullet)
	
		#print("ufo shoot from %s" % global_position)
		#print("to: ")
		#print(get_node("/root/Game/Player").global_position)
