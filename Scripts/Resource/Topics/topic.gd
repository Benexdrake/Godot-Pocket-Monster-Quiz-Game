extends Resource
class_name TopicResource

var topic_id:String
var topic:String
var information:String
var icon:Texture
var questions = []

	
func start(topic_file:String):
	var data = load(topic_file).data
	
	topic_id = data.topic_id
	topic = data.topic
	information = data.information
	icon = load("res://Assets/TopicCard/Logo/"+data.icon)
	questions = data.questions
	
	
func get_question(id:String):
	for question in questions:
		if question.id == id:
			return question
