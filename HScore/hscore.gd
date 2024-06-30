extends Control
var COLLECTION_ID = "AstroShooter_stats"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	##print(%EmailLineEdit.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	##pass
	%HighScore.text="Score: " #+str(get_node("/root/Game/Player").get("HighScore"))
	
func _on_save_pressed():
	save_data()
	get_tree().reload_current_scene()

func _on_logout_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://Authentication.tscn")
	
func save_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var panda_name = %PandaNameLineEdit.text

		var data: Dictionary = {
			"HighScore": get_node("/root/Game/Player").get("HighScore"),
			"UserName": %username.text
		}
		var task: FirestoreTask = collection.update(auth.localid, data)
