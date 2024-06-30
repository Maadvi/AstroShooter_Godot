extends Area2D
@export var speed: float = 500
signal updatescore
var plBulletEffect:=preload("res://bullet/bullet_effect.tscn")
func _physics_process(delta):
	position.y-=speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("damageable"):
		var bulleteffect:=plBulletEffect.instantiate()
		var sc := 0
		var sctxt :="Score: "
		
		sc = get_node("/root/Game/Player").get("Score") + 5
		sctxt=sctxt + str(sc)
		
		bulleteffect.position = position
		get_parent().add_child(bulleteffect)
		area.damage(1)
		get_node("/root/Game/Player").set("Score",sc)
		get_node("/root/Game/Player").set("UPDScore",1)
		print("score@ ", sc," ",sctxt)
		#if get_node("/root/Game/Player").get("HighScore") < 
		
		queue_free()
