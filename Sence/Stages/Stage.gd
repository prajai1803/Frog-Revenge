extends Node2D



onready var spwan_postion = get_node("Position2D")

var Frog = preload("res://Sence/Characters/Frog/Frog.tscn")

func _ready():
	spwan_frog()



func next_spwan():
	spwan_frog()

func spwan_frog():
	var frog = Frog.instance()
	frog.set_script(load("res://Sence/Characters/Frog/FrogAir.gd"))
	add_child(frog)
	frog.position = spwan_postion.global_position

func re_spwan():
	spwan_frog()


