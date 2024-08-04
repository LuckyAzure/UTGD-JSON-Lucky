extends Node2D

var select = 0
var selected = false
var trans_cooldown = 0

var options = ["Reset","Continue","Extras","Options","Credits"]

var nodes = {}

func _ready():
	select = Global.nextselect
	$Soul.position.y = 256.0 + (select * 40.0)
	$Version.text = ProjectSettings.get_setting("application/config/version")
	for option in options:
		nodes[option] = get_node(option)

func _process(delta):
	if !selected:
		if Input.is_action_just_pressed("Up") and select > 0:
			$Sounds/Switch.play(0)
			select -= 1
		elif Input.is_action_just_pressed("Down") and select < 4:
			$Sounds/Switch.play(0)
			select += 1
		elif Input.is_action_just_pressed("Confirm"):
			selected = true
			trans_cooldown = 0.2
			$Sounds/Select.play(0)
	else:
		trans_cooldown -= delta
		if trans_cooldown < 0:
			var scene = "res://src/scenes/credits/credits.tscn"
			Global.nextselect = select
			match select:
				0:
					scene = "res://src/scenes/interfaces/credits/credits.tscn"
				1:
					scene = "res://src/scenes/interfaces/credits/credits.tscn"
				2:
					scene = "res://src/scenes/interfaces/credits/credits.tscn"
				3:
					scene = "res://src/scenes/interfaces/options/options.tscn"
				4:
					scene = "res://src/scenes/interfaces/credits/credits.tscn"
			Global.change_scene(scene)

	$Soul.position.y = lerp($Soul.position.y, 256.0 + (select * 40.0), 10.0 * delta)

	for i in range(options.size()):
		var pos = [0, 0]
		if select == i:
			pos[0] = 64.0
			pos[1] = 0.0
		else:
			pos[0] = 32.0
			pos[1] = 1.0

		var node = nodes[options[i]]
		node.position.x = lerp(node.position.x, pos[0] if selected and select == i else -128.0 if selected else pos[0], 15.0 * delta)
		node.modulate.b = lerp(node.modulate.b, pos[1], 15.0 * delta)
