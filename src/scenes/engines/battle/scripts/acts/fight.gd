extends Node

func _process(delta):
	if Input.is_action_just_pressed("Cancel"):
		Battle.Sounds.play("Select")
		Battle.Acts._unload_act()
		Battle.HUD.actChoice = true

func _start():
	Battle.Text.text = "   * Test"
	Battle.Heart.position = Battle.Text.global_position + Vector2(12,18)

