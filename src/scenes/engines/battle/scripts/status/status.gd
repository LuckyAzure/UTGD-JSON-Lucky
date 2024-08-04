extends Node2D

func _ready():
	Battle.Status = self

func _process(delta):
	_Status_Tick()

func _Status_Tick():
	var status = Battle.Heart.Status
	$Name.text = "Chara"
	$LV_Number.text = str(status.lv)
