extends Node2D

# Category, Custom?, Options (Option, Description, Boolean)
var OptionsData = [
	["Video", true, [
		["Graphics Styles", "Choose the graphics style for the game.", false],
		["Environmental Effects", "Enable or disable environmental effects like dynamic weather and day-night cycle.", false],
		["Border Options", "Customize the border style or choose a borderless fullscreen mode.", false]
	]],
	["Audio", true, [
		["Soundtrack", "Toggle the game's background music.", false],
		["Sound Effects", "Toggle the game's sound effects.", false]
	]],
	["Gameplay", true, [
		["Windowed Mode", "Switch between fullscreen and windowed mode.", false]
	]]
]

var textnode = preload("res://src/scenes/options/text.tscn")
var textNodes: Array = []

func create_clone(main, optiontype):
	for text in textNodes:
		text.queue_free()
	textNodes.clear()

	if main:
		for i in range(OptionsData.size()):
			var textInstance = textnode.instantiate()
			var text = textInstance.duplicate()
			text.order = i
			text.text = OptionsData[i][0]
			text.posy = 240 + 36 * i
			textNodes.append(text)
			add_child(text)
	else:
		for i in range(OptionsData[optiontype][2].size()):
			var textInstance = textnode.instantiate()
			var text = textInstance.duplicate()
			text.order = i
			text.text = OptionsData[optiontype][2][i][0]
			text.posy = 240 + 36 * i
			textNodes.append(text)
			add_child(text)

func _ready():
	create_clone(true, null)

var select = 0
var selected = false
var trans_cooldown = 0

var MainOptions = true
var options = null

func _process(delta):
	if MainOptions:
		if !selected:
			if Input.is_action_just_pressed("Up"):
				$CanvasLayer/Desc.modulate.a = 0
				$Sounds/Switch.play(0)
				if select > 0:
					select -= 1
				else:
					select = OptionsData.size() - 1
			elif Input.is_action_just_pressed("Down"):
				$CanvasLayer/Desc.modulate.a = 0
				$Sounds/Switch.play(0)
				if select < OptionsData.size() - 1:
					select += 1
				else:
					select = 0
			elif Input.is_action_just_pressed("Cancel"):
				selected = true
				trans_cooldown = 0.2
				$Sounds/Switch.play(0)
			elif Input.is_action_just_pressed("Confirm"):
				MainOptions = false
				create_clone(false, select)
				$Sounds/Select.play(0)
				options = select
				select = 0
		else:
			trans_cooldown -= delta
			if trans_cooldown < 0:
				Global.change_scene("res://src/scenes/title/title.tscn")
	else:
		if !selected:
			if Input.is_action_just_pressed("Up"):
				$CanvasLayer/Desc.modulate.a = 0
				$Sounds/Switch.play(0)
				if select > 0:
					select -= 1
				else:
					select = OptionsData[options][2].size() - 1
			elif Input.is_action_just_pressed("Down"):
				$CanvasLayer/Desc.modulate.a = 0
				$Sounds/Switch.play(0)
				if select < OptionsData[options][2].size() - 1:
					select += 1
				else:
					select = 0
			elif Input.is_action_just_pressed("Cancel"):
				MainOptions = true
				create_clone(true, null)
				select = options
				$Sounds/Switch.play(0)
		else:
			trans_cooldown -= delta
			if trans_cooldown < 0:
				Global.change_scene("res://src/scenes/title/title.tscn")
	
	#$CanvasLayer/Desc.text = OptionsData[select][1]
	#$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)
