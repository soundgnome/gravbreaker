extends RigidBody2D

var boundaries = [0, 1024, 0, 576]
var starting_pos

func _ready():
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(4)
	self.starting_pos = self.get_pos()
	self.set_process(true)

func reset_position():
	self.set_pos(self.starting_pos)

func _process(delta):
	self._hit_bricks()
	self._check_boundary()

func _check_boundary():
	var pos = self.get_pos()
	if pos.x < self.boundaries[0] or pos.x > self.boundaries[1] \
	or pos.y < self.boundaries[2] or pos.y > self.boundaries[3]:
		level_controller.reset_ball(self)

func _hit_bricks():
	var bricks = self.get_colliding_bodies()
	if bricks.size() > 0:
		for brick in bricks:
			if brick.has_method('hit'):
				brick.hit()
				return
		sound_controller.sfx('bounce')
