extends Node2D

# OptionsData stores the data for each option.
# Format: [Category, Description, Custom?, Options (Option, Description, Type)]
var OptionsData = [
	["Gameplay", "Options related to gameplay settings.", false, [
		["hard_mode", "Hard Mode", "Enable or disable hard mode for a more challenging gameplay experience.", "boolean"]
	]],
	["Video", "Options related to video and display settings.", false, [
		["display_mode", "Display Mode", "Choose the display mode for the game (e.g., fullscreen, windowed).", "display"],
		["border", "Border", "Toggle the display of borders around the game window.", "boolean"],
		["shader", "Shader", "Enable or disable shader effects for enhanced visuals.", "boolean"]
	]],
	["Audio", "Options related to audio settings.", false, [
		["music_volume", "Music Volume", "Adjust the volume level for the game's background music.", "volume"],
		["sound_volume", "Sound Volume", "Adjust the volume level for the game's sound effects.", "volume"],
		["ost_type", "Alternative OST", "Toggle the alternative soundtrack for a different audio experience.", "boolean"]
	]]
]

# Load the text scene for option nodes
var textnode = preload("res://src/scenes/options/text.tscn")

# Array to store instantiated text nodes
var textNodes = []

# Creates clones of text nodes based on the selected category or sub-category
func create_clone(main, optionType):
	# Clear existing text nodes
	for text in textNodes:
		text.queue_free()
	textNodes.clear()

	# Create new text nodes based on main options or sub-options
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
		for i in range(OptionsData[optionType][3].size()):
			var textInstance = textnode.instantiate()
			var text = textInstance.duplicate()
			text.order = i
			text.option = OptionsData[optionType][3][i][0].to_lower()
			text.option_name = OptionsData[optionType][3][i][1]
			text.option_type = OptionsData[optionType][3][i][3]
			text.posy = 240 + 36 * i
			textNodes.append(text)
			add_child(text)

func _ready():
	# Initialize the menu with main options
	create_clone(true, -1)

# Variable to store the index of the currently selected option
var select = 0

# Flag to track if an option has been selected
var selected = false

# Cooldown time for scene transition
var trans_cooldown = 0.0

# Flag indicating if the menu is displaying main options
var MainOptions = true

# Index of the currently selected category or sub-category
var options = -1

func _process(delta):
	# Update the position of the visual element
	$Soul.position = $Soul.position.lerp(Vector2(120.0, 260.0), 15.0 * delta)

	# Process main options or sub-options based on the MainOptions flag
	if !MainOptions:
		processSubOptions(delta)
		return
	
	if !selected:
		processMainOptions(delta)
	else:
		processTransition(delta)

# Animates a visual effect when navigating through options
func SoulBounce(up):
	var bounce = Vector2(8, 24)
	$CanvasLayer/Desc.modulate.a = 0
	$Sounds/Switch.play(0)
	if up:
		$Soul.position -= bounce
	else:
		$Soul.position += bounce

# Process navigation and selection of main options
func processMainOptions(delta):
	if Input.is_action_just_pressed("Up"):
		select = (select - 1 + OptionsData.size()) % OptionsData.size()
		SoulBounce(true)
	elif Input.is_action_just_pressed("Down"):
		select = (select + 1) % OptionsData.size()
		SoulBounce(false)
	elif Input.is_action_just_pressed("Cancel"):
		# Save data, play sound, reset visual element, and set selected flag
		Global.Save_SaveData()
		$Sounds/Switch.play(0)
		selected = true
		trans_cooldown = 0.2
	elif Input.is_action_just_pressed("Confirm"):
		# Switch to sub-options, create clones, play sound, update variables
		MainOptions = false
		create_clone(false, select)
		$Sounds/Select.play(0)
		$CanvasLayer/Desc.modulate.a = 0.0
		options = select
		select = 0
		$Soul.position.x = -16

	# Update the description text and fade-in effect
	$CanvasLayer/Desc.text = OptionsData[select][1]
	$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)

# Process navigation and selection of sub-options
func processSubOptions(delta):
	var option = OptionsData[options][3][select][0]
	if Input.is_action_just_pressed("Up"):
		select = (select - 1 + OptionsData[options][3].size()) % OptionsData[options][3].size()
		SoulBounce(true)
	elif Input.is_action_just_pressed("Down"):
		select = (select + 1) % OptionsData[options][3].size()
		SoulBounce(false)
	if OptionsData[options][3][select][3] == "volume":
		if Input.is_action_just_pressed("Left"):
			# Decrease volume, play sound
			$Sounds/Switch.play(0)
			Global.savedata["options"][OptionsData[options][0].to_lower()][option] = clamp(Global.savedata["options"][OptionsData[options][0].to_lower()][option] - 5, 0.0, 100.0)
		elif Input.is_action_just_pressed("Right"):
			# Increase volume, play sound
			$Sounds/Switch.play(0)
			Global.savedata["options"][OptionsData[options][0].to_lower()][option] = clamp(Global.savedata["options"][OptionsData[options][0].to_lower()][option] + 5, 0.0, 100.0)
	if OptionsData[options][3][select][3] == "boolean" and (Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right")):
		# Toggle boolean value, play sound
		Global.savedata["options"][OptionsData[options][0].to_lower()][option] = !Global.savedata["options"][OptionsData[options][0].to_lower()][option]
		$Sounds/Switch.play(0)
		if OptionsData[options][3][select][0] == "border":
			Global.change_res = true
	if OptionsData[options][3][select][3] == "display" and (Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right")):
		# Toggle display mode, play sound
		Global.savedata["options"][OptionsData[options][0].to_lower()][option] = !Global.savedata["options"][OptionsData[options][0].to_lower()][option]
		DisplayServer.window_set_mode(int(Global.savedata.options.video.display_mode) * 4)
		Global.change_res = true
		$Sounds/Switch.play(0)
	if Input.is_action_just_pressed("Cancel"):
		# Reset variables, create clones, play sound, reset visual element
		$Soul.position.x = -16
		MainOptions = true
		create_clone(true, -1)
		select = options
		$Sounds/Switch.play(0)
		$CanvasLayer/Desc.modulate.a = 0.0

	# Update the description text and fade-in effect
	$CanvasLayer/Desc.text = OptionsData[options][3][select][2]
	$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)

# Process scene transition cooldown
func processTransition(delta):
	trans_cooldown -= delta
	if trans_cooldown < 0:
		Global.change_scene("res://src/scenes/title/title.tscn")
