class_name BTNavigationProcess extends BTAction

@export var target_var: StringName = &"target"
	
func _has_target():
	var target: Node2D = blackboard.get_var(target_var, null)
	if target and is_instance_valid(target):
		return true
	return false

func _tick(_delta: float) -> Status:
	var is_talking = blackboard.get_var("talking", false)
	if is_talking:
		return FAILURE
	
	
	if agent.navigation_agent == null or not agent.is_alive:
		return FAILURE
  
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(agent.navigation_agent.get_navigation_map()) == 0:
		return FAILURE
		
	if agent.navigation_agent.is_navigation_finished():
		agent._on_velocity_computed(Vector2.ZERO)
		return SUCCESS
		
	if _has_target():
		return FAILURE

	var speed = agent.character_physics.walk_speed
	var next_path_position: Vector2 = agent.navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = agent.global_position.direction_to(next_path_position) * speed
	if agent.navigation_agent.avoidance_enabled:
		agent.navigation_agent.set_velocity(new_velocity)
	else:
		agent._on_velocity_computed(new_velocity)
		
	agent.move_and_slide()
	
	return RUNNING
