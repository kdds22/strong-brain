extends Node2D

#var main = "res://MainGame.tscn"

export (String, FILE, "*.tscn") var main : String

export (String, FILE, "*.json") var main_questions : String

var org = ["Figado", "Estomago", "Pulmao", "ApUrinario", "Intestino"]
var quest = []
var quest_n = []
var pas
var txt
var was_started = Global_profile.was_started


func _ready():
	randomize()
	_on_PlayButton_pressed()
	if !was_started:
#		$Start_question.hide()
#		$Start_btns.show()
		pass
	else:
		$Start_question.show()
		$Start_btns.hide()


func choose_question_main(question):
	
	for n in question.size():
		quest.append(question[org[n]]["text"])
		quest_n.append(question[org[n]]["pass"])
		n += 1

	var size = quest.size()
	var choice_question = randi() % size
	txt = quest[choice_question]
	pas = quest_n[choice_question]
	show_main(txt)


func show_main(txt):
	$Start_question.show()
	$Start_btns.hide()
	$Start_question/Question/RichTextLabel.text = txt


func load_main_question(file_path):
	var file : File = File.new()
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var question = parse_json(file.get_as_text())
	assert question.size() > 0
	file.close()
	return question


func _process(delta):
	$mouse.position = get_global_mouse_position()


func areas_pick(orgao : String, type : bool):
	if orgao == "":
		for node in $Orgaos.get_children():
				node.show()
		return
	else:
		for node in $Orgaos.get_children():
			if !node.is_in_group(orgao):
				if !type:
					node.show()
				else:
					node.hide()
	


func _on_Area_intestino_area_entered(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_intestino.z_index = 10
		areas_pick("intestino", true)
func _on_Area_intestino_area_exited(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_intestino.z_index = 0
		areas_pick("intestino", false)


func _on_Area_estomago_area_entered(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_estomago.z_index = 10
		areas_pick("estomago", true)
func _on_Area_estomago_area_exited(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_estomago.z_index = 0
		areas_pick("estomago", false)


func _on_Area_figado_area_entered(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_figado.z_index = 10
		areas_pick("figado", true)
func _on_Area_figado_area_exited(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_figado.z_index = 0
		areas_pick("figado", false)


func _on_Area_pulmao_area_entered(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_pulmao.z_index = 10
		areas_pick("pulmao", true)
func _on_Area_pulmao_area_exited(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_pulmao.z_index = 0
		areas_pick("pulmao", false)


func _on_Area_ap_urina_area_entered(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_ap_urina.z_index = 10
		areas_pick("ap_urina", true)
func _on_Area_ap_urina_area_exited(area):
	if area.is_in_group("mouse"):
		$Orgaos/Area_ap_urina.z_index = 0
		areas_pick("ap_urina", false)



func _on_PlayButton_pressed():
	var question = load_main_question(main_questions)
	choose_question_main(question)

func _on_TextureButton_pressed():
	get_tree().quit()
func _on_figado_pressed():
	pas_question(0)
func _on_estomago_pressed():
	pas_question(1)
func _on_pulmao_pressed():
	pas_question(2)
func _on_ap_urina_pressed():
	pas_question(3)
func _on_intestino_pressed():
	pas_question(4)

func pas_question(value):
	Global_profile.set_start(true)
	if pas == value:
		$AnimationPlayer.play("zoom_in")
	else:
		_on_PlayButton_pressed()

func change_to_mainGame():
	get_tree().change_scene(main)
