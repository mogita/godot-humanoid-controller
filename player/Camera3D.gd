extends Camera3D

const RAY_LENGTH: float = 1000.0

var selectionQuery: PhysicsRayQueryParameters3D
var lastCollider: StaticBody3D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("mouse_left"):
		var from = project_ray_origin(event.position)
		var to = from + project_ray_normal(event.position) * RAY_LENGTH
		selectionQuery = PhysicsRayQueryParameters3D.create(from, to)

	if event.is_action_pressed("escape"):
		deactivate_last_collider(null)
		owner.selected_object = "<empty>"

func _physics_process(_delta: float) -> void:
	if selectionQuery:
		var worldspace = get_world_3d().direct_space_state
		var result = worldspace.intersect_ray(selectionQuery)
		if result and result.collider.has_method("activate"):
			owner.selected_object = result.collider.get_display_name()
			if result.collider != lastCollider:
				deactivate_last_collider(result.collider)
				result.collider.activate()
		selectionQuery = null

func deactivate_last_collider(newCollider: StaticBody3D) -> void:
	if lastCollider and lastCollider.has_method("deactivate"):
		lastCollider.deactivate()
	lastCollider = newCollider
