extends Node

var version = "UTGD v0.01 (Alpha)"
var scene

var nextscene

func change_scene(path):
	Transaction.fadetype = true
	nextscene = path
	Transaction.get_node("Fade").modulate.a = 1

func _process(delta):
	if Transaction.fadetype:
		Trans_Tick()

func Trans_Tick():
	if Transaction.get_node("Fade").modulate.a == 1:
		Transaction.fadetype = false
		scene = get_tree().change_scene_to_file(nextscene)
