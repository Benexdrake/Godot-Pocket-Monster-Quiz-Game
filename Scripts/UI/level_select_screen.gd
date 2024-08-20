extends CanvasLayer

@onready var level_grid_container: GridContainer = %LevelGridContainer
@onready var back_button: Button = %BackButton
var topid_card_scene = preload("res://Scenes/UI/topic_level_card.tscn")


func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)
	for topic in GameManager.all_topics.topics:
		for i in 3:
			var instance = topid_card_scene.instantiate() as TopicLevelCard
			level_grid_container.add_child(instance)
			instance.create(topic.topic_id, topic.topic,topic.icon, topic.information,i+1)


func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
