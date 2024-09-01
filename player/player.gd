class_name Player
extends CharacterBody3D

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
const ACCELERATION: float = 6.0
const ANGULAR_ACCELERATION: float = 10.0

const ANIM_CONDITIONS: Array = [
	"fall",
	"fight_idle",
	"hit",
	"idle",
	"jump",
	"kneel",
	"magic_area_attack",
	"magic_attack",
	"run",
	"walk",
	"stunned"
]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction: Vector3 = Vector3.FORWARD
var last_direction: Vector3 = Vector3.FORWARD
var movement_speed: float = 0.0
var vertical_velocity: float = 0.0
var selected_object: String = "<empty>"

@onready var armature: Node3D = $Armature
@onready var spring_arm_pivot: Node3D = $SpringArmPivot
@onready var anim_tree = $AnimationTree
@onready var anim_main = anim_tree.tree_root.get_node("main")
@onready var anim_tree_playback = anim_tree.get("parameters/main/playback")
@onready var states = $state_manager
@onready var debugger = $Debugger

func _ready() -> void:
	states.init(self)
	debugger.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

# backward compatible
func is_grounded() -> bool:
	return is_on_floor()

func get_input() -> Vector2:
	return Input.get_vector("left", "right", "forward", "backward")

func move(delta: float) -> void:
	move_or_inertia(delta, false)

# renamed to avoid shadowing the bulit-in method "inertia"
func go_inertia(delta: float) -> void:
	move_or_inertia(delta, true)

func move_or_inertia(delta: float, inertia: bool) -> void:
	if not inertia:
		# Get the input direction and handle the movement/deceleration.
		var input_vec = get_input()
		direction = (transform.basis * Vector3(input_vec.x, 0, input_vec.y)).rotated(Vector3.UP, spring_arm_pivot.rotation.y).normalized()
		last_direction = direction
	else:
		direction = last_direction

	if not inertia:
		velocity.x = lerp(velocity.x, direction.x * movement_speed, delta * ACCELERATION)
		velocity.z = lerp(velocity.z, direction.z * movement_speed, delta * ACCELERATION)
	else:
		# during inertia the movement should be much slower
		velocity.x = lerp(velocity.x, direction.x * movement_speed / 7, delta * ACCELERATION)
		velocity.z = lerp(velocity.z, direction.z * movement_speed / 7, delta * ACCELERATION)

	print("velocity", velocity)
	set_velocity(velocity + Vector3.DOWN * vertical_velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()

	armature.rotation.y = lerp_angle(armature.rotation.y, atan2(-direction.x, -direction.z), delta * ANGULAR_ACCELERATION)

	if !is_on_floor():
		vertical_velocity += gravity * delta
	else:
		vertical_velocity = 0
