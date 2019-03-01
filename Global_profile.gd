extends Node


var brainsWinners : int = 0
var brainsLoosers : int = 0


var was_started = false


func set_start(value : bool):
	was_started = value


func reset_points():
	brainsWinners = 0
	brainsLoosers = 0