extends ColorRect

var player: Player

func _process(_delta: float) -> void:
	$Value.text = player.selected_object if player else ""
