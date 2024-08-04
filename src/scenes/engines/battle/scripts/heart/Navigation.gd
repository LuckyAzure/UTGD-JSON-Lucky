extends CharacterBody2D

var Status = {
	"lv": 1,
	"hp": 20,
	"hp_max": 20,
	"spl": {
		"hp": 20,
		"type": "KR"
	}
}

func _process(delta):
	position = position.snapped(Vector2(1, 1))

func _ready():
	Battle.Heart = self
	_init_stats(9)

func _init_stats(LV):
	Status.lv = LV
	Status.hp_max = 16 + (4 * LV)
	Status.hp = Status.hp_max
	Status.spl.hp = Status.hp_max


#-----------------------------------------------------------------------

var items = [
	["Test1", 10],
	["Test2", 20],
	["Test3", 30],
	["Test4", 40]
]
