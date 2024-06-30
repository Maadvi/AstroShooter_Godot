extends Node2D
@onready var asteroids = $Asteroids
var asteroid_scene = preload("res://asteroid/asteroid.tscn")
var firebonus_scene = preload("res://FireBonus/fire_bonus.tscn")
var score:int=0

# Called when the node enters the scene tree for the first time.
func _ready():
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Spawn_Asteroid(pos,size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)
	
func _on_asteroid_exploded(pos,size):
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				Spawn_Asteroid(pos,Asteroid.AsteroidSize.MEDIUM)
			Asteroid.AsteroidSize.MEDIUM:
				Spawn_Asteroid(pos,Asteroid.AsteroidSize.SMALL)
			Asteroid.AsteroidSize.SMALL:
				pass
