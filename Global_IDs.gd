extends Node

var pathology_id    = 0  
var pharmacology_id = 0  
var neurology_id    = 0  
var physiology_id   = 0  
var anatomy_id      = 0  
var cardiology_id   = 0  
var areas = []

func _ready():
	areas.append(pathology_id)
	areas.append(pharmacology_id)
	areas.append(neurology_id)
	areas.append(physiology_id)
	areas.append(anatomy_id)
	areas.append(cardiology_id)

#pathology_id, pharmacology_id, neurology_id, physiology_id, anatomy_id, cardiology_id

func reset_data():
	pathology_id    = 0  
	pharmacology_id = 0  
	neurology_id    = 0  
	physiology_id   = 0  
	anatomy_id      = 0  
	cardiology_id   = 0  