extends Node2D

onready var enemy_container = get_node("EnemyContrainer")
onready var frog_container = get_node("FrogContainer")
onready var spawn_positon = get_node("Position2D")

var frog_list = Global.get_frog_list()
#var frog_list = [1]
var Frog = preload("res://Sence/Characters/Frog/Frog.tscn")



func _ready():
	initilize()


func initilize():
	print(frog_list)
	frog_spawnner()




func frog_spawnner() -> void:
	if len(frog_list) >0:
		spawn_frog()

func spawn_frog() -> void:
	var frog = Frog.instance()
	frog.set_script(load("res://Sence/Characters/Frog/FrogAir.gd"))
	frog.position = spawn_positon.global_position
	frog_container.call_deferred("add_child",frog)
	frog.connect("dead",self,"_on_frog_death")
	print(frog_list)


func _on_frog_death() -> void:
	frog_list.pop_back()
	if _completion_check():
		pass
	else:
		frog_spawnner()

func _completion_check():
	
	if enemy_container.get_child_count() == 0:
		print("game win")
		return true
	elif len(frog_list) == 0:
		if _verify_last_frog_death():
			print("game lose")
			return false
	return false


func _verify_last_frog_death() -> bool:
	return true


func _on_CrossLine_body_entered(body) -> void:
	if body.has_method("get_id"):
		if body.get_id() == "Frog":
			spawn_frog()

