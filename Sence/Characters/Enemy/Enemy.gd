extends RigidBody2D

const SPEED = 2000

signal dead

onready var anim = get_node("AnimationTree").get("parameters/playback")

func _ready():
	set_deferred("mode",MODE_CHARACTER)

func _physics_process(delta):
	pass


# Run function for some enemy
func run(delta):
	var velocity = Vector2.ZERO
	velocity.x = SPEED * delta
	linear_velocity = velocity

func hited():
	set_deferred("mode",MODE_RIGID)
	anim.travel("hit")

# when frog collide with enemy
func _on_Area2D_body_entered(body):
	if body.name == "Frog":
		hited()
		yield(get_tree().create_timer(3),"timeout")
		die()
	
	
func die():
	emit_signal("dead")
	queue_free()
	
