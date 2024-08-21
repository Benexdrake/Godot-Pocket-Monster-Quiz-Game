extends Node
class_name BattleScreen

@onready var quiz_screen: QuizScreen = $QuizScreen
@onready var back_button: Button = %BackButton
@onready var player_screen: CanvasLayer = $PlayerScreen
@onready var enemy_screen: CanvasLayer = $EnemyScreen
@onready var question_timer: Timer = $QuestionTimer


var max_questions:int

var was_right_answer:bool = true

var topic:TopicResource
var questions = []

func _ready() -> void:
	question_timer.timeout.connect(on_question_timer_timeout)
	player_screen.player_entity.died.connect(on_player_died)
	enemy_screen.enemy_entity.died.connect(on_enemy_died)
	back_button.pressed.connect(on_back_button_pressed)
	quiz_screen.check_answer.connect(on_check_answer)
	topic = GameManager.all_topics.get_topic_by_id(GlobalVariables.current_topic_id)
	topic.questions.shuffle()
	questions = topic.questions.duplicate(true)
	max_questions = questions.size()
	quiz_screen.create_question(questions[0].id)
	
	var beastie = GameManager.get_beastie(GlobalVariables.player.players_beastie_nr)
	
	player_screen.player_entity.create(GlobalVariables.player.health_points,beastie.image_back,beastie.beastie_name)
	player_screen.update()
	create_enemy()
		
	if GlobalVariables.current_modus == GameManager.game_modus.exam:
		question_timer.start()
		quiz_screen.time_progress_bar.visible = true


func _process(delta: float) -> void:
	if GlobalVariables.current_modus == GameManager.game_modus.exam:
		quiz_screen.update_time_bar(question_timer.time_left, question_timer.wait_time)

func create_enemy():
	if questions.size() == 0:
		return
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
	if GlobalVariables.current_modus == GameManager.game_modus.exam:
		question_timer.start()
	GameManager.save()
	if answer:
		if was_right_answer:
			GlobalVariables.right_question_ids.append(questions[0].id)
		GlobalVariables.insert_question_id(questions[0].id)
		questions.remove_at(0)
		enemy_screen.enemy_entity.get_hit(1)
		question_timer.stop()
		question_timer.start()
		
		if questions.size() <=0:
			if GlobalVariables.current_modus == GameManager.game_modus.loop:
				topic.questions.shuffle()
				questions = topic.questions.duplicate(true)
				return
			
			enemy_screen.enemy_entity.get_hit(99)
			$Timer.start()
			await $Timer.timeout
				
			ScreenTransition.transition_to_scene("res://Scenes/UI/end_screen.tscn")
			return
		quiz_screen.next_question(questions[0].id)
		was_right_answer = true
	else:
		was_right_answer = false
		player_screen.player_entity.get_hit(1)
		GlobalVariables.insert_wrong_question_id(questions[0].id)


func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
	GlobalVariables.reset()
	
	
func on_player_died():
	ScreenTransition.transition_to_scene("res://Scenes/UI/end_screen.tscn")
	

func on_enemy_died():
	GlobalVariables.collected_exp += 1
	GlobalVariables.player.current_exp += 1
	GameManager.save()
	check_level_up()
	create_enemy()
	player_screen.update()
	

func on_question_timer_timeout():
	player_screen.player_entity.get_hit()
