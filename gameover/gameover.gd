extends Control
var COLLECTION_ID = "AstroShooter_stats"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	##pass
	$Panel/Score.text="Score: "+str(get_node("/root/Game/Player").get("Score"))
	if (get_node("/root/Game/Player").get("isHS")):
		$Panel/HighScore.text ="New HiScore: "+str( get_node("/root/Game/Player").get("HighScore"))
	else :	
		$Panel/HighScore.text ="High Score: "+str( get_node("/root/Game/Player").get("HighScore"))

func _on_button_pressed():
	if (get_node("/root/Game/Player").get("isHS")):
		get_node("/root/Game/Player").set("isHS",false)
		save_data()
	
	get_tree().reload_current_scene()

func _on_logout_pressed():
	if (get_node("/root/Game/Player").get("isHS")):
		get_node("/root/Game/Player").set("isHS",false)
		save_data()
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Authentication.tscn")

func save_data():
	print_debug(Firebase.Auth)
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		#var panda_name = %PandaNameLineEdit.text

		var data: Dictionary = {
			"HighScore": get_node("/root/Game/Player").get("HighScore"),
			#"UserName": %username.text
		}
		var task: FirestoreTask = collection.update(auth.localid, data)
