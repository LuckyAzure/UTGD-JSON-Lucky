extends Label

var order = 0
var option_name = null
var option = null

var posx = 0.0
var posy = 0.0

func _process(delta: float) -> void:
	var select = get_tree().get_current_scene().select
	var pos = [0.0, 0.0]
	if select == order:
		pos[0] = 64.0
		pos[1] = 0.0
	else:
		pos[0] = 32.0
		pos[1] = 1.0
	posx = lerp(posx, pos[0], 25.0 * delta)
	position.x = posx + (position.y / 3.0)
	modulate.b = lerp(modulate.b, pos[1], 15.0 * delta)
	position.y = lerp(position.y, posy - (select * 36.0), 25.0 * delta)
	text = option_name
	if option != null:
		var optionaa = get_tree().get_current_scene().OptionsData[get_tree().get_current_scene().options][0].to_lower()
		text += ": " + str(OFF_ON(Global.savedata["options"][optionaa][option]))

func OFF_ON(variable) -> String:
	if typeof(variable) == TYPE_BOOL:
		if variable:
			return "ON"
		else:
			return "OFF"
	elif typeof(variable) == TYPE_FLOAT:
		return str(variable)
	else:
		return ""
