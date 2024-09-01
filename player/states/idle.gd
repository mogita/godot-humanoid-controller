extends BaseState

var is_in_fight: bool = false

@export var jump_node: NodePath
@export var roll_node: NodePath
@export var fall_node: NodePath
@export var walk_node: NodePath
@export var run_node: NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var roll_state: BaseState = get_node(roll_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(run_node)


func enter() -> void:
	super.enter()
	player.velocity = Vector3.ZERO
	player.movement_speed = 0


func input(_event: InputEvent) -> BaseState:
	if player.get_input() != Vector2.ZERO:
		if Input.is_action_pressed("walk"):
			return walk_state
		else:
			return run_state

	if player.is_grounded() and Input.is_action_just_pressed("jump"):
		return jump_state

	return null


func physics_process(delta: float) -> BaseState:
	if !player.is_grounded():
		player.vertical_velocity += player.gravity * delta
		player.go_inertia(delta)

	return null
