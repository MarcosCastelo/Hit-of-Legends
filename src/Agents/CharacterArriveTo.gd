extends KinematicBody2D

onready var sprite: Sprite = $TriangleRed
onready var bullet_scene: = preload("res://src/Objects/Bullet.tscn")

const DISTANCE_THRESHOLD: = 3.0

export var max_speed: float = 500.0
export var slow_radius: = 200.0

var target_global_position: = Vector2.ZERO
var _velocity: Vector2 = Vector2.ZERO
var shooting : bool = false


func _ready() -> void:
	set_physics_process(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		target_global_position = get_global_mouse_position()
		set_physics_process(true)
	if event.is_action_pressed("shoot") and !shooting:
		shoot()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		target_global_position = get_global_mouse_position()
	if global_position.distance_to(target_global_position) < DISTANCE_THRESHOLD:
		set_physics_process(false)
	
	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		target_global_position,
		max_speed,
		slow_radius
	)
	if !shooting:
		_velocity = move_and_slide(_velocity)
		sprite.rotation = _velocity.angle()



func shoot():
	var bullet = bullet_scene.instance()
	_velocity = (get_global_mouse_position() - global_position).normalized()
	sprite.rotation = _velocity.angle()
	bullet.position = position
	get_parent().add_child(bullet)
	shooting = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	shooting = false


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		get_tree().change_scene("res://src/Score.tscn")

func set_shooting():
	shooting = true
	_velocity = Vector2.ZERO
