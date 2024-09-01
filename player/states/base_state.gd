# An interface of a valid state
class_name BaseState
extends Node

@export var animation_name: String

# Pass in a reference to the player's kinematic body so that it can be used by the state
var player: Player


func enter() -> void:
	for condition in player.ANIM_CONDITIONS:
		if condition != animation_name:
			player.anim_tree.set("parameters/main/conditions/" + condition, false)
		else:
			player.anim_tree.set("parameters/main/conditions/" + animation_name, true)


func exit() -> void:
	pass


func input(_event: InputEvent) -> BaseState:
	return null


func process(_delta: float) -> BaseState:
	return null


func physics_process(_delta: float) -> BaseState:
	return null
