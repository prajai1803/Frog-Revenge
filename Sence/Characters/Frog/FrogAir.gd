extends RigidBody2D


const SPEED = 6000

signal dead

var touch_count = 0
var is_attack = false
var touch = false


onready var dust = get_node("Dust")
onready var anim = get_node("AnimationTree").get("parameters/playback")
onready var camera = get_node("Camera2D")

func _ready():
	initial_state()


func initial_state():
	rotation_degrees = 90
	gravity_scale = 0
	camera.current = true

func _physics_process(delta):
	if is_attack != true:
		movement(delta)
	
	if touch == true:
		attack(delta)
		

func _input(event):
	if event is InputEventScreenTouch and touch_count <= 2:
		touch_count += 1
		if event.pressed:
			touch = true
		else:
			touch = false



func dead():
	anim.travel("dead")
	yield(get_tree().create_timer(3),"timeout")
	queue_free()
	get_parent().next_spwan()


func attack(delta):
	var velocity = Vector2.ZERO
	is_attack = true
	velocity.x = 50 * delta
	velocity.y = 100 * delta
	apply_impulse(Vector2.ZERO,velocity)
	gravity_scale = 2
	angular_velocity = 3

func movement(delta):
	linear_velocity.x = SPEED * delta
	anim.travel("jump")


func _on_FrogArea_body_entered(body):
	if body.name == "Wall":
		dust.emitting = true
		dead()

	if body.name == "Ground":
		dust.emitting = true
		dead()


func vanish():
	queue_free()

func _on_FrogArea_body_exited(body):
	pass # Replace with function body.


func _on_FrogArea_area_entered(area):
	if area.name == "CrossLine":
		vanish()
		get_parent().re_spwan()
