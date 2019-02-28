extends Node2D

var pre_collisor = preload("res://pine_collision.tscn")

signal wt_area


func shot():
	var collisor = pre_collisor.instance()
	collisor.connect("exportNameArea", self, "areaChoosen")
	add_child(collisor)
	

func areaChoosen(value):
	emit_signal("wt_area", value)