extends Node

var player:PlayerResource = PlayerResource.new()
var wrong_question_ids:Array[String]
var right_question_ids:Array[String]

var all_question_ids:Array[String]
var current_topic_id:String
var current_modus

## Weiss nicht ob noch benötigt
var killed_enemies_count:int
var collected_exp:int


func insert_wrong_question_id(id:String):
	if !wrong_question_ids.has(id):
		wrong_question_ids.append(id)


func insert_question_id(id:String):
	if !all_question_ids.has(id):
		all_question_ids.append(id)
		

func reset():
	wrong_question_ids = []
	all_question_ids = []
	killed_enemies_count = 0
	collected_exp = 0
