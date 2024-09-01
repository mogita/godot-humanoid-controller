extends BaseState

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var jump_movement_speed: float

@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity: float = (
	(-2.0 * jump_height)
	/ (jump_time_to_descent * jump_time_to_descent)
)

@export var fall_node: NodePath
@export var run_node: NodePath
@export var walk_node: NodePath
@export var idle_node: NodePath

var jumping: bool = false

@onready var fall_state: BaseState = get_node(fall_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var idle_state: BaseState = get_node(idle_node)


func enter() -> void:
	super.enter()
	jumping = true
	$jump_timer.start()


func physics_process(delta: float) -> BaseState:
	player.velocity.y += get_gravity() * delta

	if jumping:
		if player.get_input() != Vector2.ZERO:
			if player.movement_speed == 0:
				player.movement_speed = jump_movement_speed
			player.move(delta)
		else:
			player.go_inertia(delta)
	else:
		if player.get_input() != Vector2.ZERO:
			if Input.is_action_pressed("walk"):
				return walk_state
			else:
				return run_state
		else:
			return idle_state
	return null


func get_gravity() -> float:
	return jump_gravity if player.velocity.y > 0.0 else fall_gravity


func _on_jump_timer_timeout():
	jumping = false
