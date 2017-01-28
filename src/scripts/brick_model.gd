extends StaticBody2D

export var hit_points = 1

func _ready():
	level_controller.add_brick(self)

func hit():
	self.hit_points -= 1
	if hit_points == 0:
		sound_controller.sfx('break')
		level_controller.remove_brick(self)
	else:
		sound_controller.sfx('bounce')
		self._update_sprite()

func _update_sprite():
	for child in self.get_children():
		if child.has_method('get_region_rect'):
			var old_rect = child.get_region_rect()
			var pos = old_rect.pos
			var new_rect = Rect2(Vector2(pos.x, pos.y - old_rect.size.y), old_rect.size)
			child.set_region_rect(new_rect)
