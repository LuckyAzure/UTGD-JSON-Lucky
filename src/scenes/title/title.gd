extends Node2D

var select = 0

var options = ["Reset","Continue","Extras","Options","Credits"]

func _ready():
	$Version.text = Global.version

func _process(delta):
	if Input.is_action_just_pressed("Up") and select > 0:
		$Sounds/Switch.play()
		select -= 1
	if Input.is_action_just_pressed("Down") and select < 4:
		$Sounds/Switch.play()
		select += 1
	
	$Soul.position.y = lerp($Soul.position.y,256.0 + (select * 40.0),10.0 * delta)
	
	for i in options.size():
		var pos = [0,0]
		var color = Color(1,1,1)
		if select == i:
			pos[0] = 64.0
			pos[1] = 0.0
		else:
			pos[0] = 32.0
			pos[1] = 1.0
		get_node(options[i]).position.x = lerp(get_node(options[i]).position.x,pos[0],15.0 * delta)
		get_node(options[i]).modulate.b = lerp(get_node(options[i]).modulate.b,pos[1],15.0 * delta)
