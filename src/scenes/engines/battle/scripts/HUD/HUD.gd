extends Node2D

var temp = ["Fight", "Act", "Items", "Mercy"]
var perfs = {
	"offset": Vector2(156,0),
	"select": {
		"max":0
	}
}

func _ready():
	_create_options(temp)

const act_node = preload("res://src/scenes/engines/battle/scripts/HUD/act.tscn")

func _create_options(options):
	for i in options.size():
		var act = act_node.instantiate()
		act.perfs.order = i
		act.animation = options[i]
		add_child(act)
		perfs.select.max += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


