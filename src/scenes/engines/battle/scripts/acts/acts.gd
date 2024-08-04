extends Node2D

var act_scripts = {
	"fight": preload("res://src/scenes/engines/battle/scripts/acts/fight.gd"),
	"act": preload("res://src/scenes/engines/battle/scripts/acts/act.gd"),
	"items": preload("res://src/scenes/engines/battle/scripts/acts/items.gd"),
	"mercy": preload("res://src/scenes/engines/battle/scripts/acts/mercy.gd")
}

func _ready():
	Battle.Acts = self

func _load_act(act):
	$Script.set_script(act_scripts[act.to_lower()])
	if $Script.has_method("_start"):
		$Script._start()

func _unload_act():
	$Script.set_script(null)

func _process(delta):
	if $Script.has_method("_process"):
		$Script._process(delta)
