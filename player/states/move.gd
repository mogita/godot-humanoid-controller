class_name MoveState
extends BaseState

@export var movement_speed: float = 0.0

@export var jump_node: NodePath
@export var roll_node: NodePath
@export var fall_node: NodePath
@export var idle_node: NodePath
@export var walk_node: NodePath
@export var run_node: NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var roll_state: BaseState = get_node(roll_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(run_node)


func enter() -> void:
	super.enter()


func input(_event: InputEvent) -> BaseState:
	if player.is_grounded():
		if Input.is_action_just_pressed("jump"):
			return jump_state
		if Input.is_action_just_pressed("roll"):
			return roll_state
	return null


func physics_process(delta: float) -> BaseState:
	if player.get_input() != Vector2.ZERO:
		player.move(delta)
	else:
		return idle_state

	return null
