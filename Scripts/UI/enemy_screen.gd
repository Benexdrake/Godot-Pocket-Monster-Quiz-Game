extends CanvasLayer

@onready var enemy_entity: Entity = $EnemyEntity
@onready var name_label: Label = %NameLabel
@onready var hp_progress_bar: ProgressBar = %HPProgressBar

func _ready() -> void:
	var battle_screen = get_tree().get_first_node_in_group("battle_screen") as BattleScreen
	
	if battle_screen == null:
		return
		
	enemy_entity.hp_changed.connect(on_hp_changed)


func update():
	hp_progress_bar.value = float(enemy_entity.current_hp) / float(enemy_entity.max_hp)
	name_label.text = enemy_entity.beastie_name
	

func on_hp_changed():
	update()
