extends Resource
class_name AllBeasties


var beasties_json = preload("res://Assets/Beasties/beasties.json")

func load_beasties() -> Array[int]:
	var all_beasties_nrs:Array[int]
	
	for beast in beasties_json.data:
		if all_beasties_nrs.has(int(beast.nr)):
			continue
		all_beasties_nrs.append(int(beast.nr))
	return all_beasties_nrs

func get_beastie(nr:int) -> Beastie:
	var beastie = Beastie.new()
	for b in beasties_json.data:
		if b.nr == nr:
			beastie.create(b.nr,b.name, "res://Assets/Beasties/Front/"+str(b.nr)+".png","res://Assets/Beasties/Back/"+str(b.nr)+".png", get_array(b.descriptions), b.height, b.category, b.weight, get_array(b.genders), get_array(b.types), get_array(b.weaknesses), b.hp, b.attack, b.defense, b.specialAttack, b.specialDefense, b.speed)
			return beastie
	return null
	
	
func get_array(old_array):
	var string_array:Array[String] = []
	string_array.append_array(old_array)
	return string_array 
