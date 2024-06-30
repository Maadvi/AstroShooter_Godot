extends Path2D
@onready var ufo_path_follow = $PathFollow2D
@export var speed = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	ufo_path_follow.progress +=speed * delta
