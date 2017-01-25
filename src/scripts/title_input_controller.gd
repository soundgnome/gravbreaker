extends VBoxContainer

var starting = false

func _ready():
	self.set_process_input(true)

func _input(event):
	if not self.starting:
		if event.type == InputEvent.KEY:
			self._start_game()

func _start_game():
	self.get_tree().change_scene('res://scenes/level1.tscn')
