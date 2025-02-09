extends KinematicBody2D

onready var sprite: Sprite = $TriangleRed
onready var target: = get_parent().get_node("CharacterArriveTo")

const ARRIVE_THRESHOLD: = 3.0
export var follow_offset: = 100.0

export var max_speed: float = 500.0
var _velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if target == self:
		set_physics_process(false)
	var target_global_position: Vector2 = target.global_position
	
	var to_target: = global_position.distance_to(target_global_position)
	
	if to_target < ARRIVE_THRESHOLD:
		return
		
	var follow_global_position: Vector2 = (
		target_global_position - (target_global_position - global_position).normalized() * 
		follow_offset
		if to_target > follow_offset
		else global_position
		)
	
	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		follow_global_position,
		max_speed,
		200.0,
		20.0
	)
	
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle()
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "CharacterArriveTo":
			get_tree().reload_current_scene()


func hit():
	queue_free()
