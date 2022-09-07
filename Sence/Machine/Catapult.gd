extends KinematicBody2D

const SPEED = 20000
const HIT_POWER = 3000
const HANDLE_MAX_ROTATION_DEGREE = 160

var velocity : Vector2 = Vector2()
var motion : Vector2 = Vector2()

onready var anim := get_node("AnimationPlayer")
onready var handle := get_node("Handle")

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction = direction.normalized()
	velocity.x = direction.x * SPEED * delta
	motion = move_and_slide(velocity)
	
	# Hit The Frog
	if Input.is_action_pressed("Hit"):
		anim.play("Hit")
		
	





