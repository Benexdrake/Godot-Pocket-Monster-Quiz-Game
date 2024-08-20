extends CanvasLayer

var player = preload("res://Resource/player_resource.tres")

@onready var partner_information_label: Label = %PartnerInformationLabel
@onready var partner_container_1: PanelContainer = %PartnerContainer1
@onready var partner_container_2: PanelContainer = %PartnerContainer2
@onready var partner_container_3: PanelContainer = %PartnerContainer3
@onready var information_canvas_layer: CanvasLayer = $InformationCanvasLayer
@onready var partner_1: TextureRect = %Partner1
@onready var partner_2: TextureRect = %Partner2
@onready var partner_3: TextureRect = %Partner3

var beasties:Array[Beastie]

func _ready() -> void:
	partner_container_1.gui_input.connect(on_partner_gui_input.bind(0))
	partner_container_1.mouse_entered.connect(on_partner_mouse_entered.bind(0))
	partner_container_2.gui_input.connect(on_partner_gui_input.bind(1))
	partner_container_2.mouse_entered.connect(on_partner_mouse_entered.bind(1))
	partner_container_3.gui_input.connect(on_partner_gui_input.bind(2))
	partner_container_3.mouse_entered.connect(on_partner_mouse_entered.bind(2))
	
	beasties.append(GameManager.get_beastie(1))
	beasties.append(GameManager.get_beastie(4))
	beasties.append(GameManager.get_beastie(7))
	
	partner_1.texture = load(beasties[0].image_front)
	partner_2.texture = load(beasties[1].image_front)
	partner_3.texture = load(beasties[2].image_front)


func on_partner_gui_input(event:InputEvent, id:int):
	if event is InputEventMouse:
		if event.is_action_pressed("left_click"):
			GlobalVariables.player = player
			GlobalVariables.player.players_beastie_nr = beasties[id].nr
			GameManager.save()
			ScreenTransition.transition_to_scene("res://Scenes/UI/level_select_screen.tscn")
			

func on_partner_mouse_entered(id:int):
		if !information_canvas_layer.visible:
			$InformationCanvasLayer/InformationAnimationPlayer.play("show")
		information_canvas_layer.visible = true
		var desc = beasties[id].description
		var description:String = desc[0] + "\n" + desc[1]
		partner_information_label.text = description
