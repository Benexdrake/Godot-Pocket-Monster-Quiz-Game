extends CanvasLayer

@onready var partner_information_label: Label = %PartnerInformationLabel
@onready var partner_container_1: PanelContainer = %PartnerContainer1
@onready var partner_container_2: PanelContainer = %PartnerContainer2
@onready var partner_container_3: PanelContainer = %PartnerContainer3

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


func on_partner_gui_input(event:InputEvent, id:int):
	if event is InputEventMouse:
		if event.is_action_pressed("left_click"):
			partner_selected(id)
			

func on_partner_mouse_entered(id:int):
	mouse_entered(id)


func mouse_entered(id:int):
	## Zeige Informationen zum Partner an.
	## Muss später geändert werden, description als String statt Array
	var desc = beasties[id].description
	var description:String = desc[0] + "\n" + desc[1]
	partner_information_label.text = description
	
	
func partner_selected(id:int):
	## Speichern der Partner Nr in Global Variable
	GlobalVariables.player.players_beastie_nr = beasties[id].nr
	GameManager.save()
	## Wechsle Scene zum Battle Screen
	ScreenTransition.transition_to_scene("res://Scenes/UI/main_menu.tscn")
