extends CanvasLayer
@onready var back_button: Button = %BackButton
@onready var wrong_card_v_box_container: VBoxContainer = %WrongCardVBoxContainer
@onready var points_label: Label = %PointsLabel
@onready var message_label: Label = %MessageLabel

var wrong_card_scene = preload("res://Scenes/UI/wrong_card.tscn")

func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)
	var wrong_ids = GlobalVariables.wrong_question_ids
	var topic = GameManager.all_topics.get_topic_by_id(GlobalVariables.current_topic_id) as TopicResource
	
	if GlobalVariables.wrong_question_ids.size() >0:
		$VBoxContainer/PanelContainer2.visible = true
	for id in wrong_ids:
		var question = topic.get_right_question(id)
		var instance = wrong_card_scene.instantiate() as WrongCard
		wrong_card_v_box_container.add_child(instance)
		instance.create(question["question"], question["answer"])
	var all = GlobalVariables.all_question_ids.size()
	var right = GlobalVariables.right_question_ids.size()
		
		
	points_label.text = str(right) + " / " + str(all)
	message_label.text = end_screen_text(right, all)

func end_screen_text(right:int, all:int):
	var text = ""
	var percent:float = float(right) / float(all)
	
	if percent >= 1.0:
		text = "Ja geil man, weiter so!"
	elif percent >= .9: 
		text = "Sehr gut"
	elif percent >= .8: 
		text = "Gut, aber du schaffst garantiert mehr!"
	elif percent >= .7: 
		text = "Ist Ok, aber du kannst mehr erreichen, lerne weiter"
	elif percent >= .6: 
		text = "Gerade so noch geschafft, lerne bitte weiter."
	else:
		text = "Auwaia, du musst mehr lernen, gogo du schaffst es"
	return text
	
	
func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
