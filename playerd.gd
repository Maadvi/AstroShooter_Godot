extends Area2D
class_name Player
signal Game_Over
signal ship_exploded
var plbullet := preload("res://bullet/bullet.tscn")
var COLLECTION_ID = "AstroShooter_stats"
@export var nguns:int=2
@onready var firepos := $FirePos
@onready var fdt := $FDT
@onready var invt := $InvincibilityTimer
@onready var IShield := $Shield
@onready var animation := $AnimatedSprite2D
@onready var gamo := $toplay/Gameover
#@onready var HUD := $toplay/scoreandlives
@export var HighScore := 0
@export var isHS := false
@onready var UserName := ""

#@onready var bt := $root/Game/Player/toplay/Gameover/Panel/button

@export var lives: int=3
@export var FireDelay := 0.5
@export var ShieldTimer=2
@export var Score=0
@export var UPDScore=0

var explosion:=false
var speed: float = 360
var vel:=Vector2(0,0)
var oldPosition:=Vector2(0,0)
# Called when the node enters the scene tree for the first time.

func _ready():
	IShield.visible=false
	lives=3
	load_data()
	self.find_child("Life").text="Life: "+str(lives)
	self.find_child("Score").text="Score: "+str(Score)
	##$root/Game/Player/toplay/scoreandlives/life.text="kkkk"
	#get_node("/root/Game/Player/toplay/scoreandlives/life").set("text","sc222323")
	Game_Over.connect(_on_player_killed)
	$TryAgain.stop()
	$SongPlayer.play()
	FireDelay=0.5
	if OS.get_name() in ["Windows","Linux","macOS"]:
		$toplay/Control.visible=true
	#load_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	if !explosion:
		_update_player_mov(delta)
	
func _update_player_mov(delta):
	var dirVect:=Vector2(0,0)
	var g:int=nguns
	
	##if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		##print("mous pppp")
	if  Input.is_action_pressed("fire_button") and fdt.is_stopped():
		fdt.start(FireDelay)
		$ShootSound.play()
		##print(nguns)
		#if $Game.nguns== 3:
		#	$FirePos/FireCenter.visible=true
		for child in firepos.get_children():
			##print(child.name)
			
			if g==3 or  child.name != "FireCenter":
				var bullet := plbullet.instantiate()
				bullet.global_position = child.global_position
				get_tree().current_scene.add_child(bullet)	
		
	if  Input.is_action_pressed("move_left") or Input.is_action_pressed("ui_left"):
		dirVect.x=-1
		
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("ui_right"):
		dirVect.x=1
		
	if Input.is_action_pressed("move_up") or Input.is_action_pressed("ui_up"):
		dirVect.y=-1
		
	if Input.is_action_pressed("move_down") or Input.is_action_pressed("ui_down"):
		dirVect.y=1
		
	vel=(dirVect.normalized()  * speed) * delta
	##if Button.`
	#print(dirVect)
	position+=vel 
	if position.x > 1868:
		position.x=1868
	if position.x < 58:
		position.x=58
		
	if position.y > 1014:
		position.y=1014
	if position.y < 80:
		position.y=80		
	#if position != olPosition:
	#	print(position)				
func damage(amount: int):
	if  invt.is_stopped ( ):
		if   lives > 1:
			$ShieldSound.play()
			invt.start(1)
			IShield.visible=true
			FireDelay=0.5
		#print_tree_pretty()
		
		lives-=amount
		self.find_child("Life").text="Life: "+str(lives)
		
		if lives == 0 :
			explosion=true
			$Sprite2D.visible=false
			$ShipExplosion.play()
			emit_signal("ship_exploded")
			animation.set_animation("explosion")
			await animation.animation_looped
			
			animation.stop()
			emit_signal("Game_Over")
			
			#queue_free()
func _on_invincibility_timer_timeout():
	IShield.visible=false

func _on_area_entered(area):
	if area.is_in_group("bonus"):
		$FireBonusCollected.play()
		#print ("presobonus")
		#print("--",FireDelay)
		#print(get_node("/root/Game/PathFireB").get("bonus_expired"))
		if get_node("/root/Game/PathFireB").get("bonus_expired")==false and FireDelay >.2:
			print("decremento fd")
			FireDelay=FireDelay-0.1
		get_node("/root/Game/PathFireB").set("bonus_expired",true)
		#print(FireDelay)
		
		#/root/Game/PathFireB"
		##print($/root/Game/Player/FireB_Node)
	print(area.get_name())
	
func _on_player_killed():
	##print("ESPOSIONEEEE")
	#explosion=false
	lives=-1
	#$Gameover.visible=true
	$SongPlayer.stop()
	$TryAgain.play()
	
	$AnimatedSprite2D.visible=false
	gamo.visible=true;


func load_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var task: FirestoreTask = collection.get_doc(auth.localid)
		var finished_task: FirestoreTask = await task.task_finished
		var document = finished_task.document
		if document && document.doc_fields:
			if document.doc_fields.HighScore:
				get_node("/root/Game/Player").set("HighScore",document.doc_fields.HighScore)
		else:
			print("No data found!")
			print(finished_task.error)
	
