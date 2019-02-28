extends Node2D

onready var pine = $select/pine


var can = false

#pathology, pharmacology, neurology, physiology, anatomy, cardiology
func wt_Area(name : String):
	
	if can:
		if name == "pathology":
			print("0")
		elif name == "pharmacology" :
			print("1")
		elif name == "neurology" :
			print("2")
		elif name == "physiology" :
			print("3")
		elif name == "anatomy" :
			print("4")
		elif name == "cardiology" :
			print("5")
		else:
			print("ops")
			print(name)


func _on_roulette_stopped(can):
	self.can = can
	pine.shot()

func _on_pine_wt_area(value):
	
	wt_Area(value)
