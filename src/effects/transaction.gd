extends CanvasLayer

var fadetype = false

func _ready():
	$Fade.modulate.a = 1

func _process(delta):
	if fadetype:
		$Fade.modulate.a = lerp($Fade.modulate.a,1.0,($Fade.modulate.a * 10) * delta)
	else:
		$Fade.modulate.a = lerp($Fade.modulate.a,0.0,($Fade.modulate.a * 10) * delta)
