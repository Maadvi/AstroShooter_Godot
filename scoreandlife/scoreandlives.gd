extends Control
var COLLECTION_ID = "AstroShooter_stats"
@onready var scr=$Score:
	set(value):
		scr.text="Life :"+str(value)

@onready var lf=$Life:
	set(value):
		lf.text="Life :"+str(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	##print("tree")
	##print_tree_pretty()
	##print(get_tree().get_root().get_child(0).get_path())
	pass
			
	##pass # Replace with function body.
	##$Score.text="Score: "+str(get_node("/root/Game/Player").get("Score"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var s=get_node("/root/Game/Player").get("Score")
	if $/root/Game/Player.UPDScore==1:
		
		$Score.text="Score: "+str(s)
		print("score",s)
		
		if s  > get_node("/root/Game/Player").get("HighScore"):
			
			
			#aggiormo hscore
			get_node("/root/Game/Player").set("isHS" , true)
			get_node("/root/Game/Player").set("HighScore" , s)
			
		get_node("/root/Game/Player").set("UPDScore",0)
		print("Hscore",get_node("/root/Game/Player").get("HighScore"))
		##print("score set")
			

func save_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var HighScore = get_node("/root/Game/Player").get("HighScore")
		var UserName=get_node("/root/Game/Player").get("UserName")
		var data: Dictionary = {
			"HighScore": HighScore,
			"UserName": UserName
		}
		var task: FirestoreTask = collection.update(auth.localid, data)

