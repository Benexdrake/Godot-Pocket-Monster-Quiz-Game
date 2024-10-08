extends CanvasLayer

@onready var name_label: Label = %NameLabel
@onready var level_label: Label = %LevelLabel
@onready var hp_progress_bar: ProgressBar = %HPProgressBar
@onready var hp_progress_bar_background: ProgressBar = %HPProgressBar_Background
@onready var exp_progress_bar: ProgressBar = %EXPProgressBar
@onready var player_entity: Entity = $PlayerEntity
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	
	
	
	var battle_screen = get_tree().get_first_node_in_group("battle_screen") as BattleScreen
	
	if battle_screen == null:
		return
	
	player_entity.hp_changed.connect(on_hp_changed)

## HP Progressbar 2 verzögerung Timer rot

func update():
	timer.start()
	hp_progress_bar.value = float(player_entity.current_hp) / float(player_entity.max_hp)
	exp_progress_bar.value = float(GlobalVariables.player.current_exp) / float(GlobalVariables.player.need_exp)
	name_label.text = player_entity.beastie_name
	level_label.text = "lv." + str(GlobalVariables.player.level)
	
	

func on_hp_changed():
	update()


func on_timer_timeout():
	hp_progress_bar_background.value = float(player_entity.current_hp) / float(player_entity.max_hp)
