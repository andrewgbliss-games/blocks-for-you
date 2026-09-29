class_name CharacterController extends CharacterBody2D

@export var input: CharacterInput
@export var character_physics: CharacterPhysics
@export var navigation_agent: NavigationAgent2D

var is_alive = true

func move(move_speed: float, direction: Vector2):
	velocity = calc_velocity(velocity, direction, move_speed, character_physics.acceleration, character_physics.friction, character_physics.max_velocity)
	move_and_slide()
	
func calc_velocity(v: Vector2, d: Vector2, s: float, a: float, f: float, c: Vector2):
	if d != Vector2.ZERO:
		v = v.move_toward(d * s, a)
	else:
		v = v.move_toward(Vector2.ZERO, f)
	v = v.clamp(-c, c)
	return v

func _on_velocity_computed(safe_velocity: Vector2):
	var c = character_physics.max_velocity
	velocity = safe_velocity.clamp(-c, c)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	_on_velocity_computed(safe_velocity)
