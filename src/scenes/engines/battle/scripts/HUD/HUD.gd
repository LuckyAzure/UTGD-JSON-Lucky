extends Node2D

func _ready():
	Battle.HUD = self
	var temp = null
	#This create every Act option that needs for the battle.
	temp = ["Fight", "Act", "Items", "Mercy"]
	_create_options(temp)

func _process(_delta):
	if actChoice:
		_navigation()
	_tick_acts()

#--------------------------------------------------------------------------------

var actChoice := true
var select = 0

func _navigation():
	if Input.is_action_just_pressed("Left"):
		Battle.Sounds.play("Select")
		select = (select - 1 + acts.size()) % acts.size()
	if Input.is_action_just_pressed("Right"):
		Battle.Sounds.play("Select")
		select = (select + 1) % acts.size()
	if Input.is_action_just_pressed("Confirm"):
		Battle.Sounds.play("Accept")
		Battle.Acts._load_act(acts[select].name)
		actChoice = false

func _tick_acts():
	if actChoice:
		Battle.Heart.position = acts[select].global_position + Vector2(-39,0)
	for act in acts:
		if act.perfs.order == select and actChoice:
			act.frame = 1
		else:
			act.frame = 0

#--------------------------------------------------------------------------------

#Create act options
var acts = []

#Configurations
var perfs = {
	"offset": Vector2(156,0),
	"select": {
		"max":0
	}
}

const act_node = preload("res://src/scenes/engines/battle/scripts/HUD/act.tscn")

func _create_options(options):
	for i in options.size():
		var act = act_node.instantiate()
		act.name = options[i]
		act.perfs.order = i
		act.animation = options[i]
		add_child(act)
		acts.append(act)
		perfs.select.max += 1

#--------------------------------------------------------------------------------


