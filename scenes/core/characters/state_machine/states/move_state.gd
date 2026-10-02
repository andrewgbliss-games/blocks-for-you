class_name MoveState extends LimboState

@export var animation_player: AnimationPlayer
@export var animation_name: StringName = "Move"

func _enter() -> void:
	animation_player.play(animation_name)

func _update(_delta: float) -> void:
	var direction = agent.input.get_movement_direction()
	if direction == Vector2.ZERO:
		get_root().dispatch("move_stop")
		return
	var speed = agent.character_physics.walk_speed
	if agent.input.is_action_pressed("run"):
		speed = agent.character_physics.run_speed
	agent.move_dir(speed, direction)
	agent.move_and_slide()
