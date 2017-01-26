extends Node

var physics
var space
var vectors

func _ready():
	self.physics = Physics2DServer
	self.vectors = {
		'north': Vector2(0, -1),
		'east': Vector2(1,0),
		'south': Vector2(0, 1),
		'west': Vector2(-1,0),
		'none': Vector2(0,0),
	}
	self.set_process(true)

func reset_ball(ball):
	self.set_gravity('none')
	ball.set_linear_velocity(self.vectors['none'])
	ball.reset_position()
	sound_controller.sfx('scratch')

func set_gravity(direction):
	self.physics.area_set_param(self.space, self.physics.AREA_PARAM_GRAVITY_VECTOR, self.vectors[direction])

func set_space(space):
	self.space = space