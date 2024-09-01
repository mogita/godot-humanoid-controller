extends BaseState

@export var run_node: NodePath
@export var walk_node: NodePath
@export var idle_node: NodePath

@onready var run_state: BaseState = get_node(run_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var idle_state: BaseState = get_node(idle_node)


func enter() -> void:
	super.enter()
	player.vertical_velocity = 0


func physics_process(delta: float) -> BaseState:
	player.vertical_velocity += player.gravity * delta
	player.velocity = lerp(player.velocity, player.direction * 0, delta * player.acceleration)
	player.velocity = player.velocity + Vector3.DOWN * player.vertical_velocity
	player.move_and_slide()

	if player.is_grounded():
		player.vertical_velocity = 0
		return idle_state

	return null
