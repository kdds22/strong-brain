extends Node2D

signal endAnim

func _on_Timer_timeout():
	$AnimationPlayer.play("finish")


func end():
	emit_signal("endAnim", true)
	queue_free()
