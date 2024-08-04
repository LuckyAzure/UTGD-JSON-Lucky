extends RichTextLabel

func _ready():
	Battle.Text = self

var speed = 0.05
var cooldown = 0

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
	elif visible_characters < text.length():
		if text[visible_characters] != " ":
			Battle.Sounds.play("Text")
		visible_characters += 1
		cooldown = speed
