extends CanvasLayer

# Game version
var version = "UTGD v0.01 (Alpha)"

# Global Ready
func _ready():
	$Fade.modulate.a = 1
	# Load save data when the node is ready
	Load_SaveData()

# Global Process
func _process(delta):
	# Check if fade effect is active
	if fadetype:
		# Perform transition tick
		Trans_Tick()
	Camera_Tick()
	Fade_Tick(delta)

# Scene System
var scene
var nextscene
var nextselect = 0

# Change scene
func change_scene(path):
	# Set fade effect to true
	fadetype = true
	# Set next scene path
	nextscene = path

# Transition tick
func Trans_Tick():
	# Check if fade effect is complete
	if $Fade.modulate.a >= 1:
		# Set fade effect to false
		fadetype = false
		# Change scene to next scene
		scene = get_tree().change_scene_to_file(nextscene)

# Save System
var savedata_directory = "user://UTGD-JSON-Lucky/" # Directory path for save data
var savedata_file = "data.json" # Save data file name
var default_data = {
	"progress": {},
	"options": {
		"gameplay": {
			"hard_mode": false
		},
		"video": {
			"graphics": 0,
			"shader": false,
			"border": 1
		},
		"audio": {
			"music_volume": 0.5,
			"sound_volume": 0.75,
			"ost_type": false
		}
	}
}

var savedata = {}
var savedata_path = savedata_directory + savedata_file # Complete path to the save file

# Load save data
func Load_SaveData():
	# Check if the save data directory exists, create it if it doesn't
	if !DirAccess.dir_exists_absolute(savedata_directory):
		DirAccess.make_dir_absolute(savedata_directory)
	
	# Check if the save data file exists
	if !FileAccess.file_exists(savedata_path):
		# Set savedata to default data
		savedata = default_data
		Save_SaveData()  # Save the default data to a file
	else:
		# Open the save data file for reading
		var file_access = FileAccess.open(savedata_path, FileAccess.READ)
		
		# Check if the file exists and can be read
		if file_access != null and file_access.file_exists(savedata_path):
			var json_data = file_access.get_as_text()
			file_access.close()
			var json = JSON.new()
			json.parse(json_data)
			savedata = json.get_data()
		else:
			savedata = default_data
			Save_SaveData()  # Save the default data to a file
	
	change_res = true

# Save save data
func Save_SaveData():
	var json_data = JSON.stringify(savedata)
	
	# Open the save data file for writing
	var file_access = FileAccess.open(savedata_path, FileAccess.WRITE)
	
	# Check if the file was opened successfully
	if file_access != null:
		file_access.store_string(json_data)
		file_access.close()
	else:
		print("Failed to save the data.")

# Border
var change_res = false

func Camera_Tick():
	print(DisplayServer.window_get_mode())
	if change_res:
		print(savedata)
		if savedata.options.video.border > 0:
			var resolution = Vector2(960, 540)
			get_viewport().content_scale_size = resolution
			if DisplayServer.window_get_mode() == 0:
				get_window().size = resolution
		else:
			var resolution = Vector2(640, 480)
			get_viewport().content_scale_size = resolution
			if DisplayServer.window_get_mode() == 0:
				get_window().size = resolution
		change_res = false

# Fade
var fadetype = false

func Fade_Tick(delta):
	if fadetype:
		$Fade.modulate.a += 3 * delta
	else:
		$Fade.modulate.a -= 3 * delta
	if $Fade.modulate.a < 0:
		$Fade.modulate.a = 0
	elif $Fade.modulate.a > 1:
		$Fade.modulate.a = 1