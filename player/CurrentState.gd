extends ColorRect

var player: Player

func _process(_delta: float) -> void:
	$Value.text = player.states.current_state.name if player else ""
