extends Node3D

const CAM_ROTATE_SPEED: float = 0.005
const MIN_ZOOM: float = 3.0
const MAX_ZOOM: float = 7.0
const ZOOM_SPEED: float = 0.8
const ZOOM_LERP_SPEED: float = 3

var pivoting: bool = false
var last_mouse_position: Vector2 = Vector2.ZERO
var zoom: float = 3.0

@onready var spring_arm: SpringArm3D = $SpringArm

func _ready() -> void:
	spring_arm.spring_length = zoom

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed('mouse_right') and not pivoting and event is InputEventMouseButton:
		# must carry this screen transform to perform Input.warp_mouse() to the correct position
		# works for both windowed and fullscreen
		last_mouse_position = event.position * get_viewport().get_screen_transform()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pivoting = true

	if pivoting and event is InputEventMouseMotion:
		rotate_y(-event.relative.x * CAM_ROTATE_SPEED)
		spring_arm.rotate_x(-event.relative.y * CAM_ROTATE_SPEED)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -PI/2, PI/3)
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= ZOOM_SPEED
	if event.is_action_pressed("cam_zoom_out"):
		zoom += ZOOM_SPEED
	zoom = clamp(zoom, MIN_ZOOM, MAX_ZOOM)

func _process(delta: float) -> void:
	if spring_arm.spring_length != zoom:
		spring_arm.spring_length =lerp(spring_arm.spring_length, zoom, delta * ZOOM_LERP_SPEED)
	if not Input.is_action_pressed('mouse_right') and pivoting:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.warp_mouse(last_mouse_position)
		pivoting = false
