extends Node2D

onready var pine = $select/pine
var pre_units = [preload("res://tests/Panel_pathology.tscn"), 
			preload("res://tests/Panel_pharmacology.tscn"),
			preload("res://tests/Panel_neurology.tscn"),
			preload("res://tests/Panel_phisiology.tscn"),
			preload("res://tests/Panel_anatomy.tscn"),
			preload("res://tests/Panel_cardiology.tscn")]

var pre_win_game = preload("res://win_game.tscn")
var pre_loose_game = preload("res://loose_game.tscn")

var can = false


func _process(delta):
	$UI/TextureRect/lbl_brainWin.text = str(Global_profile.brainsWinners)
	$UI/TextureRect/lbl_brainLoose.text = str(Global_profile.brainsLoosers)
	if Global_profile.brainsWinners >= 5:
		reset_game()
		var win_game = pre_win_game.instance()
		add_child(win_game)
	elif Global_profile.brainsLoosers >= 5:
		reset_game()
		var loose_game = pre_loose_game.instance()
		add_child(loose_game)

func reset_game():
	Global_IDs.reset_data()
	Global_profile.reset_points()


#pathology, pharmacology, neurology, physiology, anatomy, cardiology
func wt_Area(name : String):
	
	if can:
		if name == "pathology":
			show_unit(0)
		elif name == "pharmacology" :
			show_unit(1)
		elif name == "neurology" :
			show_unit(2)
		elif name == "physiology" :
			show_unit(3)
		elif name == "anatomy" :
			show_unit(4)
		elif name == "cardiology" :
			show_unit(5)
		else:
			print("ops")
			print(name)

func show_unit(value):
	var unit = pre_units[value].instance()
	add_child(unit)


func _on_roulette_stopped(can):
	self.can = can
	pine.shot()

func _on_pine_wt_area(value):
	wt_Area(value)
