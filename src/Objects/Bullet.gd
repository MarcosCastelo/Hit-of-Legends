extends KinematicBody2D

var speed = 750
var velocity: = Vector2.ZERO


func _ready() -> void:
	velocity = (get_global_mouse_position() - global_position).normalized() * speed


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
