extends Node

func _ready():
	Battle.Sounds = self


func play(sound):
	get_node(sound).play()
