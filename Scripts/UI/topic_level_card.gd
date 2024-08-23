extends PanelContainer
class_name TopicLevelCard

@export var star:Texture

@onready var topic_name_label: Label = %TopicNameLabel
@onready var topic_image_texture_rect: TextureRect = %TopicImageTextureRect
@onready var information_label: Label = %InformationLabel
@onready var difficulty_h_box_container: HBoxContainer = %DifficultyHBoxContainer

var topic_id:String
var topic_name:String

func _ready() -> void:
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

	
func create(_topic_id:String,_topic_name:String, topic_image:Texture, information:String, difficulty:int):
	topic_id = _topic_id
	topic_name = _topic_name
	topic_name_label.text = _topic_name
	topic_image_texture_rect.texture = topic_image
	information_label.text = information
	
	for i in difficulty:
		var texture_rect = TextureRect.new()
		difficulty_h_box_container.add_child(texture_rect)
		texture_rect.texture = star


func on_gui_input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			GlobalVariables.current_topic_id = topic_id
			ScreenTransition.transition_to_scene("res://Scenes/Level/battle_screen.tscn")
			
			
func on_mouse_entered():
	$AnimationPlayer.play("hover")
	z_index = 10


func on_mouse_exited():
	$AnimationPlayer.play_backwards("hover")
	z_index = 0
	
