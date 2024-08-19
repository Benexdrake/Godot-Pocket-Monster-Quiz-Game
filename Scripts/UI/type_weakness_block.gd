extends PanelContainer
@onready var label: Label = $MarginContainer/Label

func _ready() -> void:
	pass
	

func create(type:String):
	var color:Color
	label.text = type
	match type:
		"Fire":
			color = Color.RED
		"Water":
			color = Color.BLUE
		"Ground":
			color = Color.SADDLE_BROWN
		"Rock":
			color = Color.DIM_GRAY
		"Electric":
			color = Color.YELLOW
		"Flying":
			color = Color.SKY_BLUE
		"Grass":
			color = Color.WEB_GREEN
		"Poison":
			color = Color.DARK_VIOLET
		"Ice":
			color = Color.ALICE_BLUE
		"Psychic":
			color = Color.HOT_PINK
		"Dragon":
			color = Color.CRIMSON
		_:
			color = Color.YELLOW_GREEN
			
			
	var style = (get_theme_stylebox("panel") as StyleBoxFlat).duplicate()
	style.bg_color = color
	add_theme_stylebox_override("panel",style)
