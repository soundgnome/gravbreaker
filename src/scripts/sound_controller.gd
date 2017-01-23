extends Node

var sound_scene

func _ready():
	self.sound_scene = preload('res://scenes/sound.tscn').instance()

func sfx(sample_name):
	self.sound_scene.play(sample_name)
