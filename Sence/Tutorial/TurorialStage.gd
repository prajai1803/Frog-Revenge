extends Node2D

onready var frog_camera = $Frog/Camera2D
onready var frog = $Frog



func _ready():
	pass

func _physics_process(_delta):
	if frog.global_position.x > 500:
		frog.stop()



func _on_EndLine_body_entered(body):
	if body.name == "Frog":
		pass


func _on_Enemy_dead():
	$Label.text = "Tutorial \nComplete"
	$AnimationPlayer.play("Transition")
	yield($AnimationPlayer,"animation_finished")
	var _sence = get_tree().change_scene("res://Sence/Menu/StartMenu.tscn")
