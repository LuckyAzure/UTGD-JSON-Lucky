extends CanvasLayer

var fadetype = false

func _ready():
	$Fade.modulate.a = 1

func _process(delta):
	if fadetype:
		$Fade.modulate.a += 3 * delta
	else:
		$Fade.modulate.a -= 3 * delta
	if $Fade.modulate.a < 0:
		$Fade.modulate.a = 0
	elif $Fade.modulate.a > 1:
		$Fade.modulate.a = 1
