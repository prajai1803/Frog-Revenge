extends RigidBody2D


const SPEED = 6000


var id = "Frog"
var touch_count = 0
var is_attack = false
var touch = false

var Dust = preload("res://Sence/Enviroments/Dust.tscn")

onready var anim = get_node("AnimationTree").get("parameters/playback")
onready var camera = get_node("Camera2D")


func _ready():
	initial_state()


func get_id():
	return id


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
	var timer = Timer.new()
	add_child(timer)
	timer.start(3)
	yield(timer,"timeout")
	hide()
	timer.start(2)
	#yield(get_tree().create_timer(2),"timeout")
	yield(timer,"timeout")
	get_parent().get_parent().spawn_frog("normal")
	queue_free()


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
		dust_emit()
		dead()
		

	if body.name == "Ground":
		dust_emit()
		dead()
func dust_emit():
	var dust = Dust.instance()
	get_parent().get_parent().call_deferred("add_child",dust)
	dust.emitting = true
	dust.position = global_position

func _on_FrogArea_body_exited(_body):
	pass # Replace with function body.




