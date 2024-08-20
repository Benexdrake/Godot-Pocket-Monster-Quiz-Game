extends CanvasLayer

@export var stat_full:Texture
@export var stat_empty:Texture

var green_background = preload("res://Assets/Background/grass_background.jpg")
var red_background = preload("res://Assets/Background/fire_background.jpg")
var blue_background = preload("res://Assets/Background/water_background.jpg")

@onready var background_texture_rect: TextureRect = $BackgroundTextureRect
@onready var hp_v_box_container: VBoxContainer = %HPVBoxContainer
@onready var attack_v_box_container: VBoxContainer = %AttackVBoxContainer
@onready var defense_v_box_container: VBoxContainer = %DefenseVBoxContainer
@onready var sp_attack_v_box_container: VBoxContainer = %SPAttackVBoxContainer
@onready var sp_defense_v_box_container: VBoxContainer = %SPDefenseVBoxContainer
@onready var speed_v_box_container: VBoxContainer = %SpeedVBoxContainer
@onready var beastie_name_label: Label = %BeastieNameLabel
@onready var exp_label: Label = %EXPLabel
@onready var beastie_information_label: Label = %BeastieInformationLabel
@onready var back_button: Button = $BackButton
@onready var shadow_image: TextureRect = %ShadowImage
@onready var beastie_image: TextureRect = %BeastieImage
@onready var type_h_box_container: HBoxContainer = %TypeHBoxContainer
@onready var weakness_h_box_container: HBoxContainer = %WeaknessHBoxContainer

var type_weakness_block_scene = preload("res://Scenes/UI/type_weakness_block.tscn")

func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)
	
	var beastie_nr = GlobalVariables.player.players_beastie_nr
	var beastie = GameManager.get_beastie(beastie_nr)
	
	change_status_points(hp_v_box_container, beastie.hp)
	change_status_points(attack_v_box_container, beastie.attack)
	change_status_points(defense_v_box_container, beastie.defense)
	change_status_points(sp_attack_v_box_container, beastie.special_attack)
	change_status_points(sp_defense_v_box_container, beastie.special_defense)
	change_status_points(speed_v_box_container, beastie.speed)
	
	beastie_name_label.text = beastie.beastie_name
	
	
	
	change_exp(beastie)
	type_weaknesses(beastie.types, type_h_box_container)
	type_weaknesses(beastie.weaknesses, weakness_h_box_container)
	change_background_and_beastie_image(beastie.nr, beastie.image_front)


func change_exp(beastie:Beastie):
		var desc = beastie.description
		beastie_information_label.text = desc[0] + "\n" + desc[1]
	
		exp_label.text = str(GlobalVariables.player.current_exp) + " / " + str(GlobalVariables.player.need_exp) + " EXP"	


func change_status_points(v_box_container:VBoxContainer, points:int):
	var i = v_box_container.get_children().size()
	for child in v_box_container.get_children():
		if i > points:
			child.texture = stat_empty
			i-=1
			continue
		child.texture = stat_full
		
	
func type_weaknesses(types:Array[String], hbox_container:HBoxContainer):
	for t in types:
		var instance = type_weakness_block_scene.instantiate()
		hbox_container.add_child(instance)
		instance.create(t)
		
		
func change_background_and_beastie_image(nr:int, beastie_image_front:String):
	var texture = load(beastie_image_front)
	match nr:
		1:
			background_texture_rect.texture = green_background
		4:
			background_texture_rect.texture = red_background
		7:
			background_texture_rect.texture = blue_background
			
			
	beastie_image.texture = texture
	shadow_image.texture = texture
func on_back_button_pressed():
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
