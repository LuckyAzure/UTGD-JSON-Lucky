extends Node2D

var creditsData = [
	["--Example--", null, true],
	["Example", "ExampleDesc", false],
	["--Engine--", null, true],
	["Lucky", "Who made this engine in godot.", false],
	["--Undertale Credits--", null, true],
	["Toby Fox", "Main developer and composer.", false],
	["Temmie Chang", "Artistic assistant.", false],
	["J.N. Wiedle", "Freelance cartoonist.", false],
	["Magnolia Porter", "Freelance illustrator.", false],
	["Gigi D.G.", "Artist and tester.", false],
	["Bob Sparker", "Special inspiration for Mettaton.", false],
	["Sarah", "Special inspiration for Mettaton.", false],
	["Michelle Czajkowski", "Guest designer for Muffet.", false],
	["Kenju", "Tileset artist.", false],
	["Merrigo", "Main background artist.", false],
	["Drak", "Artist and tester.", false],
	["Clairevoire", "Artist and tester.", false],
	["Easynam", "Contributor of overworld art.", false],
	["Guzusuru", "Animation assistant.", false],
	["Everdraed", "Asset and animation creator.", false],
	["Flashygoodness", "Programming help.", false],
	["Leon Arnott", "Programming help and Mac OS X porting.", false],
	["Mike Reid", "Guest designer for Glyde.", false]
]

var textnode: PackedScene
var order = 0

func create_clone():
	var textInstance = textnode.instantiate()
	var text = textInstance.duplicate()
	text.name = str(order)
	text.text = creditsData[order][0]
	text.posy = 240 + 36 * order
	
	order += 1
	add_child(text)

func _ready():
	textnode = preload("res://src/scenes/credits/text.tscn")
	
	for i in range(creditsData.size()):
		create_clone()

var select = 1
var selected = false
var trans_cooldown = 0

func _process(delta):
	if !selected:
		if Input.is_action_just_pressed("Up"):
			$CanvasLayer/Desc.modulate.a = 0
			$Sounds/Switch.play(0)
			if select > 0:
				select -= 1
				if creditsData[select][2]:
					select -= 1
				if select < 0:
					select = creditsData.size() - 1
			else:
				select = creditsData.size() - 1
		elif Input.is_action_just_pressed("Down"):
			$CanvasLayer/Desc.modulate.a = 0
			$Sounds/Switch.play(0)
			if select < creditsData.size() - 1:
				select += 1
				if creditsData[select][2]:
					select += 1
			else:
				select = 1
		elif Input.is_action_just_pressed("Cancel"):
			selected = true
			trans_cooldown = 0.5
			$Sounds/Switch.play(0)
	else:
		trans_cooldown -= delta
		if trans_cooldown < 0:
			get_tree().change_scene_to_file("res://src/scenes/title/title.tscn")
	
	$CanvasLayer/Desc.text = creditsData[select][1]
	$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)
