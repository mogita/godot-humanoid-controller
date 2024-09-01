# Instanciates a state machine for the Player it attaches to
extends Node

@export var starting_state: NodePath

var current_state: BaseState


# init initializes the state machine by giving each state a reference to the objects
# owned by the parent that they should be able to take control of and set a default state
func init(player: Player) -> void:
	for child in get_children():
		child.player = player

	# Setting the initial state of the player
	change_state(get_node(starting_state))


# change_state exits current state (if any) and enters the new state
func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


# physical_process is a pass-through function for the Player class
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)


# input is a pass-through function for the Player class
func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)


# process is a pass-through function for the Player class
func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
