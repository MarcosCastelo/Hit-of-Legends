extends KinematicBody2D

var speed = 750
var velocity: = Vector2.ZERO


func _ready() -> void:
	velocity = (get_global_mouse_position() - global_position).normalized() * speed
	print(velocity)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
