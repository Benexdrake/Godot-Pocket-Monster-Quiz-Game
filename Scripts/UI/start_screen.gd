extends CanvasLayer

func _ready() -> void:
	pass
	
	
func _input(event: InputEvent):
	if !event is InputEventMouse || event.is_action_pressed("left_click"):
		await ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
	
