extends Node2D

onready var enemy_container = get_node("EnemyContrainer")
onready var frog_container = get_node("FrogContainer")
onready var spawn_positon = get_node("Position2D")

var frog_list = ["normal","fire"]
var Frog = preload("res://Sence/Characters/Frog/Frog.tscn")


func _ready():
	inilize()


func inilize():
	spawn_frog("normal")



func get_frog_queue():
	return frog_list


func spawn_frog(type):
	if len(frog_list) > 0:
		var frog = Frog.instance()
		frog.set_script(load("res://Sence/Characters/Frog/FrogAir.gd"))
		frog.position = spawn_positon.global_position
		frog_container.call_deferred("add_child",frog)
		frog_list.pop_back()
		print(frog_list)
		

func _completion_check():
	if enemy_container.get_child_count() == 0:
		print("game win")
	elif frog_container.get_child_count() == 0:
		if _verify_frog_death():
			print("game lose")

func _verify_frog_death():
	return true



func _on_CrossLine_body_entered(body):
	if body.has_method("get_id"):
		if body.get_id() == "Frog":
			spawn_frog('normal')

