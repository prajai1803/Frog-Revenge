extends Node2D


var Frog = preload("res://Sence/Characters/Frog/Frog.tscn")

onready var frog_container : Node2D = get_node("FrogContainer")
onready var label : Label= get_node("Label")
onready var timer : Timer = get_node("Timer")

var _frog_count:int = 1
var total_frog_send:int = 0
var count:int= 3

func _ready():
	_initilize_game()

func _initilize_game() -> void:
	timer.start()

func _validate_container() -> void:
	print(_frog_count)
	if frog_container.get_child_count() != 1:
		pass
	else:
		if _frog_count != 0:
			_spwan_frog('normal')
		elif _frog_count == 0:
			yield(get_tree().create_timer(4),"timeout")
			var _sence = get_tree().change_scene("res://Sence/Stages/Stage1/Stage1.tscn")



func _spwan_frog(type) -> void:
	var frog = Frog.instance()
	frog.TYPES[type]
	frog_container.call_deferred("add_child",frog)
	frog.connect("dead",self,"_validate_frog_death")
	frog.position = $SpawnPosition.global_position
	_frog_count -= 1

func _validate_frog_death() -> void :
	print("validate death")
	_validate_container()
	

func _on_CrossLine_body_entered(body) -> void:
	if body is RigidBody2D:
		body.queue_free()
		total_frog_send += 1
		_validate_container()

func update_label(label_count : int):
	label.text = "GAME START IN \n" + str(label_count)

func _on_Timer_timeout():
	count -= 1
	update_label(count)
	if count == 0:
		timer.stop()
		label.hide()
		game_start()

func game_start():
	_spwan_frog("normal")


	
