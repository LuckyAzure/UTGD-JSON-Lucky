extends AnimatedSprite2D

var perfs = {
	"order": -1
}

func _process(_delta):
	_act_tick()

func _act_tick():
	var hud_perfs = get_parent().perfs
	var offset_x = hud_perfs.offset.x
	var half_width = ((hud_perfs.select.max - 1) * offset_x) / 2
	position.x = (perfs.order * offset_x) - half_width
