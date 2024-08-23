extends CanvasLayer
class_name QuizScreen

signal check_answer

@onready var quiz_button_1: Button = %QuizButton1
@onready var quiz_button_2: Button = %QuizButton2
@onready var quiz_button_3: Button = %QuizButton3
@onready var quiz_button_4: Button = %QuizButton4
@onready var question_label: Label = %QuestionLabel
@onready var time_progress_bar: ProgressBar = $TimeProgressBar

var current_question

func _ready() -> void:
	quiz_button_1.pressed.connect(on_button_pressed.bind(0))
	quiz_button_2.pressed.connect(on_button_pressed.bind(1))
	quiz_button_3.pressed.connect(on_button_pressed.bind(2))
	quiz_button_4.pressed.connect(on_button_pressed.bind(3))
	
	
func create_question(id:String):
	if owner is BattleScreen:
		current_question = owner.topic.get_question(id)
		current_question.answers.shuffle()
		question_label.text = current_question.question
		check_answer_size(current_question.answers[0][0], quiz_button_1)
		check_answer_size(current_question.answers[1][0], quiz_button_2)
		check_answer_size(current_question.answers[2][0], quiz_button_3)
		check_answer_size(current_question.answers[3][0], quiz_button_4)
		

func check_answer_size(answer:String, button:Button):
	button.add_theme_font_size_override("font_size", 32)
	if answer.length() > 50:
		button.add_theme_font_size_override("font_size", 20)
	button.text = answer
	button.size = Vector2(400,150)


func update_time_bar(current, max):
	time_progress_bar.value = 1.0 - (current / max)
		
	
func on_button_pressed(index:int):
	check_answer.emit(current_question.answers[index][1])
	

func next_question(id:String):
	if owner is BattleScreen:
		current_question = owner.topic.questions[0]
		create_question(id)
