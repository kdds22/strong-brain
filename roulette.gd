extends Node2D

var cur_ : float
var gone = false
var can = false

signal stopped

func _ready():
	randomize()
	gone = false
	cur_ = 0
	pass

func _process(delta):
	if gone:
		if cur_ >= 0:
			rotation += cur_ * delta
			cur_ -= delta
		else:
			if gone == true:
				stopped()
			else:
				return

func stopped():
	gone = false
	can = true
	emit_signal("stopped", can)
	cur_ = 0

func set_cur_(value):
	if !gone:
		cur_ = value
		gone = true
	else:
		cur_ = cur_

func _on_TextureButton_pressed():
	set_cur_(rand_range(5, 15))
