extends Control



onready var anim: AnimationPlayer= get_node("AnimationPlayer")

func _ready():
	anim.play("UpDown")
	

func _on_Play_pressed():
	anim.play("Transition")
	yield(anim,"animation_finished")
	var _sence = get_tree().change_scene("res://Sence/Tutorial/TutorialCatapult.tscn")
