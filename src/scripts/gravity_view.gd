extends Node

var sprites
var current_direction

func _ready():
	self.sprites = {
		'north': self.get_node('north'),
		'east': self.get_node('east'),
		'south': self.get_node('south'),
		'west': self.get_node('west'),
	}
	level_controller.register_node('gravity_view', self)

func hide():
	if self.current_direction:
		self.sprites[self.current_direction].stop()
		self.sprites[self.current_direction].hide()
	self.current_direction = null

func show(direction):
	self.hide()
	if direction != 'none':
		self.sprites[direction].show()
		self.sprites[direction].play()
		self.current_direction = direction
