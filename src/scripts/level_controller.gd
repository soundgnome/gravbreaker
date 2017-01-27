extends Node

var nodes = {}
var physics
var space
var spare_ball_count = 3
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

func end_game(ball):
	ball.queue_free()

func lose_ball(ball):
	if self.spare_ball_count > 0:
		self.nodes['spare_balls'].get_children()[0].queue_free()
		self.spare_ball_count -= 1
		reset_ball(ball)
	else:
		self.end_game(ball)

func register_node(name, node):
	self.nodes[name] = node

func reset_ball(ball):
	self.set_gravity('none')
	ball.set_linear_velocity(self.vectors['none'])
	ball.reset_position()
	sound_controller.sfx('scratch')

func set_gravity(direction):
	self.physics.area_set_param(self.space, self.physics.AREA_PARAM_GRAVITY_VECTOR, self.vectors[direction])

func set_space(space):
	self.space = space