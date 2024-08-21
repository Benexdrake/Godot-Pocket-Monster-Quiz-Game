extends PanelContainer
class_name WrongCard

@onready var question_label: Label = %QuestionLabel
@onready var answer_label: Label = %AnswerLabel

func create(question:String, answer:String):
	question_label.text = question
	answer_label.text = answer
