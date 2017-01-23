extends Node

var server
var space
var vectors

func _ready():
	self.server = Physics2DServer
	self.space = self.get_viewport().find_world_2d().get_space()
	self.vectors = {
		'north': Vector2(0, -1),
		'east': Vector2(1,0),
		'south': Vector2(0, 1),
		'west': Vector2(-1,0),
	}
	self.set_process(true)

func _process(delta):
	for direction in self.vectors:
		if (Input.is_action_pressed(str('gravity_', direction))):
			self.server.area_set_param(self.space, self.server.AREA_PARAM_GRAVITY_VECTOR, self.vectors[direction])
