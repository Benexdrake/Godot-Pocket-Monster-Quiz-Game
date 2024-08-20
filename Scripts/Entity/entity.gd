extends Node2D
class_name Entity

@onready var ground: TextureRect = $Ground
@onready var beastie_image: TextureRect = $BestieImage


signal died

signal hp_changed

var current_hp:int
var max_hp:int
var beastie_name:String

func create(_hp:int, beastie_image_path:String, _beastie_name:String):
	current_hp = _hp
	max_hp = _hp
	beastie_name = _beastie_name
	beastie_image.texture = load(beastie_image_path)
	

func get_hit():
	current_hp -=1
	hp_changed.emit()
	
	if current_hp <= 0:
		died.emit()
