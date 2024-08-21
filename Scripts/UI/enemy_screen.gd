extends CanvasLayer

@onready var enemy_entity: Entity = $EnemyEntity
@onready var name_label: Label = %NameLabel
@onready var hp_progress_bar: ProgressBar = %HPProgressBar
@onready var timer: Timer = $Timer
@onready var hp_progress_bar_background: ProgressBar = %HPProgressBar_Background

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	var battle_screen = get_tree().get_first_node_in_group("battle_screen") as BattleScreen
	
	if battle_screen == null:
		return
		
	enemy_entity.hp_changed.connect(on_hp_changed)


func update():
	timer.start()
	hp_progress_bar.value = float(enemy_entity.current_hp) / float(enemy_entity.max_hp)
	name_label.text = enemy_entity.beastie_name
	

func on_hp_changed():
	update()


func on_timer_timeout():
	hp_progress_bar_background.value = float(enemy_entity.current_hp) / float(enemy_entity.max_hp)
