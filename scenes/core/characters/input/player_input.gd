class_name PlayerInput extends CharacterInput

func get_movement_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func get_aim_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()

func is_action_pressed(action_name: String) -> bool:
	return Input.is_action_pressed(action_name)
