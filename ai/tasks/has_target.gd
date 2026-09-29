class_name BTHasTarget extends BTCondition

@export var target_var: StringName = &"target"

func _tick(_delta: float) -> Status:
	var target: Node2D = blackboard.get_var(target_var, null)
	if not is_instance_valid(target):
		return FAILURE

	return SUCCESS
