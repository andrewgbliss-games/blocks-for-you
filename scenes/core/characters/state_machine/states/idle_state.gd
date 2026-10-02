class_name IdleState extends LimboState

@export var animation_player: AnimationPlayer
@export var animation_name: StringName = "Idle"

func _enter() -> void:
	animation_player.play(animation_name)

func _update(_delta: float) -> void:
	var direction = agent.input.get_movement_direction()
	if direction != Vector2.ZERO:
		get_root().dispatch("move_start")
	agent.move_dir(0.0, direction)
	agent.move_and_slide()
