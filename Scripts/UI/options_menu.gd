extends CanvasLayer
class_name OptionsMenu

signal close_options

@onready var back_button: Button = %BackButton
@onready var quit_button: Button = %QuitButton
@onready var delete_button: Button = %DeleteButton

func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	delete_button.pressed.connect(on_delete_button_pressed)
	
	
func on_back_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	close_options.emit()
	queue_free()


func on_delete_button_pressed():
	GameManager.delete_save()

func on_quit_button_pressed():
	ScreenTransition.transition_quit()
	get_tree().quit()
