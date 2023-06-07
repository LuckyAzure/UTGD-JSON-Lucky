extends Node2D

# Category, Description, Custom?, Options (Option, Description, Boolean)
var OptionsData = [
	["Gameplay", "Options related to gameplay settings.", false, [
		["hard_mode", "Hard Mode", "Enable or disable hard mode for a more challenging gameplay experience.", true]
	]],
	["Video", "Options related to video and display settings.", false, [
		["display_mode", "Display Mode", "Choose the display mode for the game (e.g., fullscreen, windowed).", false],
		["border", "Border", "Toggle the display of borders around the game window.", false],
		["shader", "Shader", "Enable or disable shader effects for enhanced visuals.", true]
	]],
	["Audio", "Options related to audio settings.", false, [
		["music_volume", "Music Volume", "Adjust the volume level for the game's background music.", false],
		["sound_volume", "Sound Volume", "Adjust the volume level for the game's sound effects.", false],
		["ost_type", "Alternative OST", "Toggle the alternative soundtrack for a different audio experience.", true]
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
			text.option_name = OptionsData[i][0]
			text.posy = 240 + 36 * i
			textNodes.append(text)
			add_child(text)
	else:
		for i in range(OptionsData[optiontype][3].size()):
			var textInstance = textnode.instantiate()
			var text = textInstance.duplicate()
			text.order = i
			text.option = OptionsData[optiontype][3][i][0].to_lower()
			text.option_name = OptionsData[optiontype][3][i][1]
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
	if !MainOptions:
		processSubOptions(delta)
		return
	
	if !selected:
		processMainOptions(delta)
	else:
		processTransition(delta)

func processMainOptions(delta):
	if Input.is_action_just_pressed("Up"):
		select = (select - 1 + OptionsData.size()) % OptionsData.size()
		$Sounds/Switch.play(0)
		$CanvasLayer/Desc.modulate.a = 0
	elif Input.is_action_just_pressed("Down"):
		select = (select + 1) % OptionsData.size()
		$Sounds/Switch.play(0)
		$CanvasLayer/Desc.modulate.a = 0
	elif Input.is_action_just_pressed("Cancel"):
		$Sounds/Switch.play(0)
		selected = true
		trans_cooldown = 0.2
	elif Input.is_action_just_pressed("Confirm"):
		MainOptions = false
		create_clone(false, select)
		$Sounds/Select.play(0)
		$CanvasLayer/Desc.modulate.a = 0
		options = select
		select = 0

	$CanvasLayer/Desc.text = OptionsData[select][1]
	$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)

func processSubOptions(delta):
	if Input.is_action_just_pressed("Up"):
		select = (select - 1 + OptionsData[options][3].size()) % OptionsData[options][3].size()
		$Sounds/Switch.play(0)
		$CanvasLayer/Desc.modulate.a = 0
	elif Input.is_action_just_pressed("Down"):
		select = (select + 1) % OptionsData[options][3].size()
		$Sounds/Switch.play(0)
		$CanvasLayer/Desc.modulate.a = 0
	elif Input.is_action_just_pressed("Cancel"):
		MainOptions = true
		create_clone(true, null)
		select = options
		$Sounds/Switch.play(0)
		$CanvasLayer/Desc.modulate.a = 0
	
	$CanvasLayer/Desc.text = OptionsData[options][3][select][2]
	$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)

func processTransition(delta):
	trans_cooldown -= delta
	if trans_cooldown < 0:
		Global.change_scene("res://src/scenes/title/title.tscn")
