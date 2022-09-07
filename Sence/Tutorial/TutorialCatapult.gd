extends Node2D

var frog_passed = 0
var count = 3
var iso = false
func _ready():
	$Frog.set_physics_process(false)
	$Timer.start()
	$CataputlHUD/Control/HBoxContainer/Left.hide()
	$CataputlHUD/Control/HBoxContainer/Right.hide()
	$CataputlHUD/Control/HBoxContainer/Hit.hide()

func _physics_process(delta):
	if $Frog.is_dead == false:
		if $Frog.global_position.y > 442 and iso == false:
			$Frog.set_deferred("mode",RigidBody2D.MODE_KINEMATIC)
			$CataputlHUD/Control/HBoxContainer/Hit.show()
			$Label.show()
			$Label.text = "HIT THE ORANGE \n BUTTON"
			
		elif iso == true:
			$Frog.set_deferred("mode",RigidBody2D.MODE_RIGID)
			$Label.hide()

func update_label(value):
	$Label.text = "GAME START IN \n" + str(value)

func _on_CrossLine_body_entered(body):
	if body.name == "Frog":
		print("frog pass")
		frog_passed += 1
		if body.has_method("dead"):
			body.dead()
		$AnimationPlayer.play("Transition")
		yield($AnimationPlayer,"animation_finished")
		var sence = get_tree().change_scene("res://Sence/Tutorial/TurorialStage.tscn")


func _on_Timer_timeout():
	print("hey")
	count -= 1
	update_label(count)
	if count <0:
		$Label.hide()
		start()
		$Timer.stop()

func start():
	$Frog.set_physics_process(true)



