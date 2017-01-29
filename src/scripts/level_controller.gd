extends Node

var ball
var brick_count = 0
var current_level = 0
var last_level = 2
var level_node
var nodes = {}
var physics
var space
var spare_ball_count = 3
var vectors
var world_node

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

func add_brick(brick):
	self.brick_count += 1

func end_game(won):
	self.ball.queue_free()
	self.level_node.queue_free()
	if won:
		sound_controller.sfx('victory')
		self.nodes['user_message'].say('YOU WIN!', 'success')
	else:
		sound_controller.sfx('gameover')
		self.nodes['user_message'].say('GAME OVER', 'failure')


func lose_ball():
	if self.spare_ball_count > 0:
		sound_controller.sfx('scratch')
		self.nodes['spare_balls'].get_children()[0].queue_free()
		self.spare_ball_count -= 1
		self.reset_ball()
	else:
		self.end_game(false)

func next_level():
	if self.current_level == self.last_level:
		self.end_game(true)
	else:
		sound_controller.sfx('newlevel')
		self.current_level += 1
		if self.level_node:
			self.level_node.queue_free()
		self.level_node = load(str('res://scenes/levels/', self.current_level, '.tscn')).instance()
		self.world_node.add_child(self.level_node)
		self.reset_ball()

func register_node(name, node):
	self.nodes[name] = node

func remove_brick(brick):
	brick.queue_free()
	self.brick_count -= 1
	if self.brick_count == 0:
		self.next_level()
	else:
		sound_controller.sfx('break')

func reset_ball():
	self.set_gravity('none')
	self.ball.set_linear_velocity(self.vectors['none'])
	self.ball.reset_position()

func set_ball(ball):
	self.ball = ball

func set_gravity(direction):
	self.physics.area_set_param(self.space, self.physics.AREA_PARAM_GRAVITY_VECTOR, self.vectors[direction])

func set_space(space):
	self.space = space

func start_game(world_node):
	self.world_node = world_node
	self.next_level()
