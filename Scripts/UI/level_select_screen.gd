extends CanvasLayer

@onready var level_grid_container: GridContainer = %LevelGridContainer
@onready var back_button: Button = %BackButton

@onready var check_box_1: CheckBox = %CheckBox1
@onready var check_box_2: CheckBox = %CheckBox2
@onready var check_box_3: CheckBox = %CheckBox3

var topid_card_scene = preload("res://Scenes/UI/topic_level_card.tscn")

func _ready() -> void:
	check_box_1.pressed.connect(on_checkbox_pressed.bind(0))
	check_box_2.pressed.connect(on_checkbox_pressed.bind(1))
	check_box_3.pressed.connect(on_checkbox_pressed.bind(2))
	back_button.pressed.connect(on_back_button_pressed)
	for topic in GameManager.all_topics.topics:
		var instance = topid_card_scene.instantiate() as TopicLevelCard
		level_grid_container.add_child(instance)
		instance.create(topic.topic_id, topic.topic,topic.icon, topic.information)
		
	GlobalVariables.current_modus = GameManager.game_modus.normal


func reset_checkboxes():
	check_box_1.button_pressed = false
	check_box_2.button_pressed = false
	check_box_3.button_pressed = false


func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")


func on_checkbox_pressed(modus:int):
	reset_checkboxes()
	match modus:
		0:
			check_box_1.button_pressed = true
			GlobalVariables.current_modus = GameManager.game_modus.normal
		1:
			check_box_2.button_pressed = true
			GlobalVariables.current_modus = GameManager.game_modus.loop
		2:
			check_box_3.button_pressed = true
			GlobalVariables.current_modus = GameManager.game_modus.exam
