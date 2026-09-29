class_name BTSetRandomNavigationPos extends BTAction

var time := 0.0
var time_interval := 1.0

func _tick(_delta: float) -> Status:
	var delta := _delta
	if agent.navigation_agent == null:
		time = 0.0
		return SUCCESS
	time += delta
	if time < time_interval:
		
		var random_pos: Vector2 = Vector2.ZERO
		if agent.navigation_agent:
			var map = agent.navigation_agent.get_navigation_map()
			if map:
				random_pos = NavigationServer2D.map_get_random_point(map, 1, false)
					
		time = 0.0
		agent.navigation_agent.set_target_position(random_pos)
		return SUCCESS
	return SUCCESS
