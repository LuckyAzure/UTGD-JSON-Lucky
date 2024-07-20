extends Node2D

var creditsData = [
	["--Example--", null, true],
	["Example", "ExampleDesc", false],
	["--Engine Credits--", null, true],
	["LuckyAzure", "Creator of this engine.", false],
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
	["Mike Reid", "Guest designer for Glyde.", false],
	["--Special Thanks--", null, true],
	["UNSTOP4BLE", "Cool guy I played cod with on ps3.", false],
	["???", "", false],
	["???", "", false],
	["???", "", false],
	["???", "", false],
	["???", "", false],
	["???", "", false],
	["???", "", false],
	["???", "", false]
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
	textnode = preload("res://src/scenes/interfaces/credits/text.tscn")
	
	for i in range(creditsData.size()):
		create_clone()

var select = 1
var selected = false
var trans_cooldown = 0

func _process(delta):
	$Soul.position = $Soul.position.lerp(Vector2(120.0,260), 15.0 * delta)
	if !selected:
		processSelection(delta)
	else:
		processTransition(delta)

func SoulBounce(boolean):
	var bounce = Vector2(8,24)
	$CanvasLayer/Desc.modulate.a = 0
	$Sounds/Switch.play(0)
	if boolean:
		$Soul.position -= bounce
	else:
		$Soul.position += bounce

func processSelection(delta):
	if Input.is_action_just_pressed("Up"):
		SoulBounce(true)
		select = (select - 1 + creditsData.size()) % creditsData.size()
		while creditsData[select][2]:
			select = (select - 1 + creditsData.size()) % creditsData.size()
	elif Input.is_action_just_pressed("Down"):
		SoulBounce(false)
		select = (select + 1) % creditsData.size()
		while creditsData[select][2]:
			select = (select + 1) % creditsData.size()
	elif Input.is_action_just_pressed("Cancel"):
		selected = true
		trans_cooldown = 0.2
		$Sounds/Switch.play(0)
	
	$CanvasLayer/Desc.text = creditsData[select][1]
	$CanvasLayer/Desc.modulate.a = lerp($CanvasLayer/Desc.modulate.a, 1.0, 15.0 * delta)

func processTransition(delta):
	trans_cooldown -= delta
	if trans_cooldown < 0:
		Global.change_scene("res://src/scenes/interfaces/title/title.tscn")
