extends Node2D

var timer_count = 3
var total_frog = Global.GAME_DATA["stage1"]["total_frog"]

signal next_spawn

onready var timer : Timer = $Timer
onready var label : Label = $Label 
onready var frog_container : Node2D = $Frogs
onready var spwan_postion : Position2D = $SpawnPosition
onready var Frog = preload("res://Sence/Characters/Frog/Frog.tscn")

func _ready():
	var _timer = timer.connect("timeout",self,"_on_timer_timeout")
	start()

func start() -> void:
	timer.start()
	spawn_frog()



func start_spawning() -> void:
	pass

func spawn_frog() -> void:
	var frog = Frog.instance()
	frog.set_script(load("res://Sence/Characters/Frog/Frog.gd"))
	frog_container.add_child(frog)
	frog.position = spwan_postion.global_position


func update_label(value) -> void:
	label.text = "GAME START IN \n" + str(value)

func _on_timer_timeout() -> void:
	timer_count -= 1
	update_label(timer_count)
	if timer_count < 0:
		timer.stop()
		label.hide()
