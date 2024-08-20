extends Resource
class_name AllTopicsResource

var file_path:String = "res://Resource/Topics/Files/"
var topics:Array[TopicResource] = []

func get_all_topics():
	
	var paths = get_all_topics_path()
	
	for path in paths:
		var topic = TopicResource.new()
		topic.start(path)
		topics.append(topic)


func get_topic_by_id(id:String, is_topic_card:bool = false):
	for topic in topics:
		if topic.topic_id == id:
			if is_topic_card:
				topic.questions = []
			return topic
			


func get_all_topics_path():
	var dir = DirAccess.open(file_path)
	
	var files:Array[String] = []
	
	var file_names = dir.get_files()
	for file in file_names:
		files.append(file_path + file.simplify_path())
	return files		
