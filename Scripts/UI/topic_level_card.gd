extends PanelContainer
class_name TopicLevelCard

@export var loop_modus:Texture
@export var time_modus:Texture
@export var normal_modus:Texture

@onready var topic_name_label: Label = %TopicNameLabel
@onready var topic_image_texture_rect: TextureRect = %TopicImageTextureRect
@onready var information_label: Label = %InformationLabel

var topic_id:String
var topic_name:String

func _ready() -> void:
	gui_input.connect(on_gui_input)

	
func create(_topic_id:String,_topic_name:String, topic_image:Texture, information:String):
	topic_id = _topic_id
	topic_name = _topic_name
	topic_name_label.text = _topic_name
	topic_image_texture_rect.texture = topic_image
	information_label.text = information


func on_gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			GlobalVariables.current_topic_id = topic_id
			ScreenTransition.transition_to_scene("res://Scenes/Level/battle_screen.tscn")
