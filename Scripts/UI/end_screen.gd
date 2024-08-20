extends CanvasLayer
@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)
	
	
func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
