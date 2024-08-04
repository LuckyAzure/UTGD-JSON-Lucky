extends Node

var Enemys = []

func _ready():
	Battle.Encounters = self
	
	var temp = null
	
	temp = [
		{"name":"utu_sans","position":[320,240],"flags":["GLOBAL"]}
	]
	_load_encounters(temp)


func _process(delta):
	pass

#----------------------------------------------------------------------------

func _load_encounters(list):
	for char in list:
		_load_char(char)

#----------------------------------------------------------------------------

const global_path = "res://assets/battle/chars/"
const encounters_path = "res://assets/battle/encounters/"

func _load_char(char):
	var path = null
	if "GLOBAL" in char.flags:
		path = global_path + char.name + "/"
	else:
		path = encounters_path + Battle.Name + "/" + char.name + "/"
	var json_data = _load_json(path + "char.json")
	var node_char = load(path + json_data.node)
	
	var node = node_char.instantiate()
	add_child(node)
	node.position = Vector2(char.position[0], char.position[1])
	

#----------------------------------------------------------------------------

func _load_json(path):
	var json_string = null
	var file_access = FileAccess.open(path, FileAccess.READ)
	if file_access:
		json_string = file_access.get_as_text()
	file_access.close()
	return JSON.parse_string(json_string)
