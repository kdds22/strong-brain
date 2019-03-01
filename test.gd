extends Node2D

var pre_brainLooser = preload("res://brain_looser.tscn")
var pre_brainWinner = preload("res://brain_winner.tscn")

#global_jsons
export (String, FILE, "*.json") var questions_ : String

enum area {pathology_id, pharmacology_id, neurology_id, physiology_id, anatomy_id, cardiology_id }
export (area) var global_area

var force            # forces reset all questions
var questions        # all questions of area
var node_size        # questions size 
var node_id          # question ID
var node_type        # question type
var node_text        # question statement
var node_next_id     # area_question_id + 1 ---- or ---- next question/question_area
var node_choice = [] # Dictionary : text, next_id, result
var node_choice_result
var choices = []
var choices_results = []

var area_question_id # Number of question

onready var Buttons = [$Panel/Choices/Choice_A, $Panel/Choices/Choice_B, $Panel/Choices/Choice_C, $Panel/Choices/Choice_D]
onready var ButtonsLabels = [$Panel/Choices/Choice_A/Label,$Panel/Choices/Choice_B/Label, $Panel/Choices/Choice_C/Label, $Panel/Choices/Choice_D/Label]


func _ready():
	#interact()
	#global_area = global_area+"_id"
	call_question()

func load_questions(file_path):
	var file = File.new()
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var question = parse_json(file.get_as_text())
	assert question.size() > 0
	return question


func call_question():
	area_question_id = Global_IDs.areas[global_area]
	var question = load_questions(questions_)
	force = question["Force"]
	node_type = question["Type"]
	questions = question["Questions"]
	node_size = questions.size()
	node_id = questions[area_question_id]["id"]
	node_text = questions[area_question_id]["text"]
	node_next_id = questions[area_question_id]["next_id"]
	node_choice = questions[area_question_id]["choices"]
	
	show_question()
	

func show_question():
	var y = 0
	for choices in node_choice:
		self.choices.append(choices["text"])
		self.choices_results.append(choices["result"])
		
		if choices["result"] == true:
			node_choice_result = y
		y += 1
	
	var n = 0
	var _s = ""
	for x in ButtonsLabels:
		x.text = self.choices[n]
		_s = "_on_Choice_pressed"+str(n)
		Buttons[n].connect("pressed",self, _s)
		n += 1
	
	$Panel/QuestionType.text = node_type
	$Panel/QuestionText.text = node_text
	
func _on_Choice_pressed0():
	call_choice(0)
func _on_Choice_pressed1():
	call_choice(1)
func _on_Choice_pressed2():
	call_choice(2)
func _on_Choice_pressed3():
	call_choice(3)

func call_choice(value):
	if choices_results[value] == false:
		Global_IDs.areas[global_area] = area_question_id
		end_question(0)
	else:
		Global_IDs.areas[global_area] = node_next_id
		end_question(1)

func end_question(value):
	if value == 0:
		var brainLooser = pre_brainLooser.instance()
		brainLooser.connect("endAnim", self, "_on_BrainEndAnim")
		add_child(brainLooser)
	elif value == 1:
		var brainWinner = pre_brainWinner.instance()
		brainWinner.connect("endAnim", self, "_on_BrainEndAnim")
		add_child(brainWinner)
	else:
		return

func _on_BrainEndAnim(value):
	if value:
		Global_profile.brainsWinners += 1
	else:
		Global_profile.brainsLoosers += 1
	queue_free()






