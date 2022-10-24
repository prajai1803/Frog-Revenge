extends RigidBody2D


const SPEED = 6000

var id = "Frog"
var is_attack = false
var stoped = false


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
	if is_attack != true and stoped == false:
		movement(delta)
	
	if Input.is_action_just_pressed("Hit") and stoped == true:
		attack(delta)



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
	#anim.travel("jump")

func not_process():
	set_physics_process(false)


func yes_process():
	set_physics_process(true)

func _on_FrogArea_body_entered(body):
	if body.name == "Wall":
		pass
	
	if body.name == "Ground":
		pass


func _on_FrogArea_body_exited(body):
	if body is RigidBody2D:
		pass



#Declear for Tutorial
func stop():
	stoped = true
	linear_velocity.x = 00
