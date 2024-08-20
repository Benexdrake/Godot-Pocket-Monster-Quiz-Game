extends Node
class_name BattleScreen

@onready var quiz_screen: QuizScreen = $QuizScreen
@onready var back_button: Button = %BackButton
@onready var counter_label: Label = $CounterLabel

@onready var player_screen: CanvasLayer = $PlayerScreen
@onready var enemy_screen: CanvasLayer = $EnemyScreen

var queustion_solved:int
var max_questions:int

var topic:TopicResource
var questions = []

func _ready() -> void:
	player_screen.player_entity.died.connect(on_player_died)
	enemy_screen.enemy_entity.died.connect(on_enemy_died)
	back_button.pressed.connect(on_back_button_pressed)
	quiz_screen.check_answer.connect(on_check_answer)
	topic = GameManager.all_topics.get_topic_by_id(GlobalVariables.current_topic_id)
	topic.questions.shuffle()
	
	questions = topic.questions.duplicate(true)
	
	max_questions = questions.size()
	
	quiz_screen.create_question(questions[0].id)
	counter_label.text = str(queustion_solved) + " / " + str(max_questions)
	
	var beastie = GameManager.get_beastie(GlobalVariables.player.players_beastie_nr)
	
	player_screen.player_entity.create(GlobalVariables.player.health_points,beastie.image_back,beastie.beastie_name)
	player_screen.update()
	
	create_enemy()
	

func create_enemy():
	var nrs = GameManager.beasties.load_beasties()
	
	var rand = randi_range(0,nrs.size()-1)
	
	var beastie = GameManager.get_beastie(nrs[rand])
	## Gegner haben erstmal nur 3 HP
	enemy_screen.enemy_entity.create(3,beastie.image_front, beastie.beastie_name)
	enemy_screen.update()
	

func check_level_up():
	if GlobalVariables.player.current_exp >= GlobalVariables.player.need_exp:
		player_screen.player_entity.current_hp = GlobalVariables.player.health_points
		GlobalVariables.player.level +=1
		GlobalVariables.player.need_exp += GlobalVariables.player.TARGET_EXP_GROWTH
		GlobalVariables.player.current_exp = 0

	
func on_check_answer(answer:bool):
	if answer:
		questions.remove_at(0)
		quiz_screen.next_question(questions[0].id)
		queustion_solved +=1
		enemy_screen.enemy_entity.get_hit()
	else:
		player_screen.player_entity.get_hit()

	counter_label.text = str(queustion_solved) + " / " + str(max_questions)
	


func on_back_button_pressed():
	GameManager.save()
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
	
	
func on_player_died():
	GameManager.save()
	ScreenTransition.transition_to_scene("res://Scenes/UI/end_screen.tscn")
	

func on_enemy_died():
	GlobalVariables.collected_exp += 1
	GlobalVariables.player.current_exp += 1
	GameManager.save()
	check_level_up()
	create_enemy()
	player_screen.update()
