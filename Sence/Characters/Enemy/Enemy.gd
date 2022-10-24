extends RigidBody2D

const SPEED = 2000

signal dead

var is_hited = false

export (int) var direction = 0
onready var anim = get_node("AnimationTree").get("parameters/playback")
onready var animated_sprite = get_node("AnimatedSprite")
onready var area_collision = get_node("Area2D/CollisionShape2D")

func _ready():
	set_deferred("mode",MODE_CHARACTER)
	if direction == 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	




# Run function for some enemy
func run(delta):
	var velocity = Vector2.ZERO
	velocity.x = SPEED * delta
	linear_velocity = velocity
	


func hited():
	set_deferred("mode",MODE_RIGID)
	anim.travel("hit")
	area_collision.set_deferred("disable",true)
	yield(get_tree().create_timer(3),"timeout")
	die()
	

# when frog collide with enemy
func _on_Area2D_body_entered(body):
	print(body.name)
	if body.has_method("get_id"):
		if body.get_id() == "Frog":
			hited()

func die():
	print("Enemy Dead")
	emit_signal("dead")
	queue_free()

