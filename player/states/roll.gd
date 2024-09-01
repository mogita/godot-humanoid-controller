extends MoveState

@export var roll_time: float = 0.4


# Override MoveState input() since we don't want to change states based checked player input
func input(_event: InputEvent) -> BaseState:
	return null


# Track how long we've been dashing so we know when to exit
func process(_delta: float) -> BaseState:
	# if animation is not done playing, don't respond to more inputs
	# if current_dash_time > 0:
	# 	return null

	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("run"):
			return run_state
		return walk_state
	return idle_state
