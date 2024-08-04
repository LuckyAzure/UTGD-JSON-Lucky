extends Node2D

func _process(delta):
	_HP_Tick()

const hp_scale = 1.2121212121212121212121212121212

func _HP_Tick():
	_size()
	_value()

func _value():
	var status = Battle.Heart.Status
	$Bar.value = status.hp
	$Bar.max_value = status.hp_max
	
	$Special.value = status.spl.hp
	$Special.max_value = status.hp_max
	
	if status.spl.type != "":
		$"../Number".text = str(status.spl.hp) + " / " + str(status.hp_max)
	else:
		$"../Number".text = str(status.hp) + " / " + str(status.hp_max)
	
	

func _size():
	var status = Battle.Heart.Status
	var size = status.hp_max * hp_scale
	$Outline.size.x = size + 4
	
	$Back.size.x = size
	
	$Bar.size.x = size
	$Special.size.x = size
	
	$"../SPL_Text".position.x = size - 39
	$"../SPL_Text".visible = (status.spl.type != "")
	
	if status.spl.type != "":
		$"../Number".position.x = (size - 31) + 31
	else:
		$"../Number".position.x = size - 31
