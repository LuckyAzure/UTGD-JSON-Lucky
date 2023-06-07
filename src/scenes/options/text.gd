extends Label

var order = 0
var option_name = null

var posx = 0.0
var posy = 0.0

func _process(delta):
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
