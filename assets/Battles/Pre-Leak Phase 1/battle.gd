extends Node2D

func _ready():
	$Music.play(110)
	print($Music.get_playback_position())
