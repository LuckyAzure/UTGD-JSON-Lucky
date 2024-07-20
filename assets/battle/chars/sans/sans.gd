extends Marker2D

var timer = 0.0

func _process(delta):
	timer += delta
	
	$Legs.scale.y = 1 + sin(timer * 1.75) * 0.05
	$Torso.global_position = $Legs/Pos.global_position
	
	$Torso/Cape.skew = 0.2 + cos((timer + 0.58) * 2) * 0.2
	$Torso/Kint.skew = 0.1 + cos((timer + 1.16) * 2) * 0.1
	
	$Torso/Cape2.skew = 0.1 + cos((timer + 1.75) * 2) * 0.1
	$Torso/Cape2/Kint.skew = -0.1 - cos((timer + 1.75) * 2) * 0.2

	var arms = [$"Torso/Left Shoulder", $"Torso/Right Shoulder"]
	
	for i in arms.size():
		var strength = 1
		var arm = arms[i]
		if i == 0:
			strength = -strength
		
		arm.rotation_degrees = 0 - sin((timer + 0.4) * 1.75) * (strength * 2)
		arm.get_node("Arm").rotation_degrees = 0 - sin((timer + 0.4) * 1.75) * (strength * 1.5)
	
	$Torso/Head.position.y = -19 - sin((timer - 0.4) * 1.75) * 0.75
	
