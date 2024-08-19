extends Resource
class_name Beastie

var nr:int
var beastie_name:String
var image_front:String
var image_back:String
var description:Array[String]
var height:String
var category:String
var weight:String
var genders:Array[String]
var types:Array[String]
var weaknesses:Array[String]
var hp:int
var attack:int
var defense:int
var special_attack:int
var special_defense:int
var speed:int

func create(_nr:int,_beastie_name:String, _image_front:String, _image_back:String, _description:Array[String], _height:String, _category:String, _weight:String, _genders:Array[String], _types:Array[String], _weaknesses:Array[String], _hp:int, _attack:int, _defense:int, _special_attack:int, _special_defense:int, _speed:int):
	nr = _nr
	beastie_name = _beastie_name
	image_front = _image_front
	image_back = _image_back
	description = _description
	height = _height
	category = _category
	weight = _weight
	genders = _genders
	types = _types
	weaknesses = _weaknesses
	hp = _hp
	attack = _attack
	defense = _defense
	special_attack = _special_attack
	special_defense = _special_defense
	speed = _speed
