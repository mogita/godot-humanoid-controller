class_name Debugger
extends Control

func init(player: Player) -> void:
	for child in get_children():
		child.player = player
