extends RigidBody2D

class_name TutorialFrog

const SPEED = 2000
const JUMP_POWER = 2000

onready var dust = get_node("Dust")
onready var anim = get_node("AnimationTree").get("parameters/playback")


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
	print("dead")
	$Timer.start()

#  Check collision for wall and groundre
func _on_FrogArea_body_entered(body):
	if body.name == "Ground":
		on_ground = true
		ground_count += 1
		if ground_count > 1:
			if is_dead == false:
				dead()
	
	if body.name == "Wall":
		dust.emitting = true
		if is_dead == false:
			dead()


	if body.name == "Handle":
		print("handle")
		get_parent().iso = true

func stop():
	gravity_scale = 0

#  Check collision for wall and ground
func _on_FrogArea_body_exited(body):
	if body.name == "Ground":
		on_ground = false
		print("of_ground")


func _on_Timer_timeout():
	queue_free()


func _on_FrogArea_area_entered(area):
	pass # Replace with function body.
