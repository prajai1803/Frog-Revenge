extends RigidBody2D

class_name Frog

const SPEED = 2000
const JUMP_POWER = 2000

var Dust = preload("res://Sence/Enviroments/Dust.tscn")

const TYPES = {
	normal = "normal",
	fire = "fire",
}




onready var anim = get_node("AnimationTree").get("parameters/playback")
onready var _timer = get_node("Timer")

signal dead

var on_ground = false
var hited = false
var ground_count = 0
var is_dead = false


func _ready():
	set_deferred("mode",MODE_CHARACTER)
	

func _physics_process(delta):
	if is_dead != true:
		run(delta)
	animation()



func run(delta):
	if on_ground == true and hited == false:
		linear_velocity.x = SPEED * delta

func animation():
	if on_ground == true and hited == false and linear_velocity.x <= 0 and is_dead == false:
		anim.travel("idle")
	elif on_ground == true and hited == false and linear_velocity.x > 0 and is_dead == false:
		anim.travel("run")
	elif on_ground == false and hited == false and linear_velocity.y < 0 and is_dead == false:
		anim.travel("jump")
	elif on_ground == false and hited == false and linear_velocity.y > 0 and is_dead == false:
		anim.travel("fall")
	elif is_dead == true:
		anim.travel("dead")

func dead():
	is_dead = true
	set_deferred("mode",MODE_RIGID)
	emit_signal("dead")
	print("frog dead")
	yield(get_tree().create_timer(3),"timeout")
	queue_free()

#  Check collision for wall and groundre
func _on_FrogArea_body_entered(body):
	if body.name == "Ground":
		dust_emit()
		_timer.start()
		on_ground = true
		ground_count += 1
		if ground_count > 1:
			if is_dead == false:
				dead()
	
	if body.name == "Wall":
		dust_emit()
		if is_dead == false:
			dead()
	
	if body.name == "Handle":
		ground_count += 1

func dust_emit():
	var dust = Dust.instance()
	get_parent().get_parent().call_deferred("add_child",dust)
	dust.position = global_position

#  Check collision for wall and ground
func _on_FrogArea_body_exited(body):
	if body.name == "Ground":
		on_ground = false


func _on_Timer_timeout():
	dead()
