extends RigidBody2D

func _ready():
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(4)
	self.set_process(true)

func _process(delta):
	var bricks = self.get_colliding_bodies()
	if bricks.size() > 0:
		for brick in bricks:
			if brick.has_method('hit'):
				brick.hit()
				return
		sound_controller.sfx('bounce')
