extends Node2D
@onready var FireB:=$FB_Timer
var FB := preload("res://FireBonus/fire_bonus.tscn")
@export var BR:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	var stime:=randf_range(3,6)
	FireB.start(stime+5.0)
	BR=true
	#print_tree_pretty()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fb_timer_timeout():
	var a = FB.instantiate()
	get_tree().current_scene.add_child(a)
	a.connect("FireB_TO", _on_FireBonus_expired)

func _on_FireBonus_expired():
	BR=false
	print("fire bonus expired")
