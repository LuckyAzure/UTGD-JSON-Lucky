extends Marker2D

var perfs = {
	"scale": {
		"target": Vector2(2,2),
		"lerp": Vector2(2,2)
	},
	"head": 0,
	"torso": 0
}

func testing():
	if Input.is_action_just_pressed("Confirm"):
		perfs.scale.lerp = Vector2(2.5, 1.5)
		perfs.torso = 1
		perfs.head = 2
	if Input.is_action_just_pressed("Cancel"):
		perfs.scale.lerp = Vector2(1.5, 2.5)
		perfs.torso = 0
		perfs.head = 0

var timer = 0.0

func _process(delta):
	timer += delta
	movement()
	smoothness(delta)
	
	readperfs()
	testing()
	
	torso()

func readperfs():
	$Torso/Head.frame = perfs.head

func movement():
	$Legs.skew = sin(timer * -3) * 0.075
	$Legs.scale.y = 1 + sin(timer * -6) * 0.025
	
	$Torso.global_position = $Legs/TorsoPos.global_position
	$Torso.rotation_degrees = sin(timer * -3) * 1
	
	$Torso/Head.rotation_degrees = -$Torso.rotation_degrees
	$Torso/Head.position.y = -19.5 - sin(timer * -6) * 0.5
	
	$Torso/Scarf.skew = -0.05 + (sin((timer + 0.5) * 3) * -0.05)

func smoothness(delta):
	perfs.scale.lerp = perfs.scale.lerp.lerp(perfs.scale.target,15 * delta)
	scale = scale.lerp(perfs.scale.lerp,15 * delta)

var torso_data = [
	{"position": [0, 93], "size": [60, 27], "offset": [-31, -26]},
	{"position": [61, 93], "size": [92, 28], "offset": [-47, -27]}
]

func torso():
	var data = torso_data[perfs.torso]
	$Torso.region_rect = Rect2(
		data.position[0],
		data.position[1],
		data.size[0],
		data.size[1]
	)
	$Torso.offset = Vector2(
		data.offset[0],
		data.offset[1]
	)
