extends Area2D

var nameArea : String

signal exportNameArea

func _on_pine_collision_area_entered(area : Area2D):
	nameArea = area.name
	emit_signal("exportNameArea", nameArea)
	queue_free()
