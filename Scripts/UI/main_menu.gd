extends CanvasLayer

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var status_button: Button = %StatusButton
@onready var quit_button: Button = %QuitButton

@onready var main_panel_container: PanelContainer = $MainPanelContainer


var options_menu_scene = preload("res://Scenes/UI/options_menu.tscn")

func _ready() -> void:
	play_button.pressed.connect(on_play_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	status_button.pressed.connect(on_status_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	
	GameManager.load_save_file()
	if GameManager.save_file_exists:
		status_button.visible = true


func on_play_button_pressed():
	if !GameManager.save_file_exists:
		ScreenTransition.transition_to_scene("res://Scenes/UI/character_select_screen.tscn")
	else:
		pass
		
	
	
	
func on_options_button_pressed():
	var options_instance = options_menu_scene.instantiate() as OptionsMenu
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	main_panel_container.visible = false
	add_child(options_instance)
	options_instance.close_options.connect(on_options_closed)
	
	
func on_status_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/status_screen.tscn")
	
	
func on_quit_button_pressed():
	await ScreenTransition.transition_quit()
	get_tree().quit()


func on_options_closed():
	main_panel_container.visible = true
