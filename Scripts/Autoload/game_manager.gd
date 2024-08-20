extends Node

const SAVE_FILE_PATH:String = "user://save.file_20_08"

var beasties = preload("res://Resource/Beasties/all_beasties.tres") as AllBeasties

var all_topics:AllTopicsResource = preload("res://Resource/Topics/all_topics.tres")

var save_file_exists:bool

func _ready() -> void:
	load_save_file()
	beasties.load_beasties()
	all_topics.get_all_topics()
	
func load_save_file():
	if !FileAccess.file_exists(SAVE_FILE_PATH):
		
		save_file_exists = false
		return
		
	var file = FileAccess.open(SAVE_FILE_PATH,FileAccess.READ)
	var save_data = file.get_var()
	
	load_player(save_data)
	save_file_exists = true
	
	
func save():
	var file = FileAccess.open(SAVE_FILE_PATH,FileAccess.WRITE)
	var save_data = set_player(GlobalVariables.player)
	file.store_var(save_data)


func delete_save():
	DirAccess.remove_absolute(SAVE_FILE_PATH)

func set_player(player:PlayerResource):
	var p = {
		"player_name" : player.player_name,
		"players_beastie_nr" : player.players_beastie_nr,
		"current_exp" : player.current_exp,
		"need_exp" : player.need_exp,
		"health_points" : player.health_points,
		"level" : player.level
	}
	return p


func load_player(player):
	GlobalVariables.player.player_name = player["player_name"]
	GlobalVariables.player.players_beastie_nr = player["players_beastie_nr"]
	GlobalVariables.player.current_exp = player["current_exp"]
	GlobalVariables.player.need_exp = player["need_exp"]
	GlobalVariables.player.health_points = player["health_points"]
	GlobalVariables.player.level = player["level"]


func get_beastie(nr:int):
	return beasties.get_beastie(nr) as Beastie
