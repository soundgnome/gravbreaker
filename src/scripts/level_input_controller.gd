extends Node

var directions = ['north', 'east', 'south', 'west']
var space

func _ready():
	level_controller.set_space(self.get_viewport().find_world_2d().get_space())
	self.set_process(true)

func _process(delta):
	for direction in self.directions:
		if (Input.is_action_pressed(str('gravity_', direction))):
			level_controller.set_gravity(direction)
