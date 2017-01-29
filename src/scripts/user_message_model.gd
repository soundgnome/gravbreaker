extends Label

func _ready():
	level_controller.register_node('user_message', self)

func say(message, style=null):
	self.set_text(message)
	if style == 'failure':
		self.add_color_override("font_color", Color(1,0,0,1))
		self.add_color_override("font_color_shadow", Color(0.5,0,0,1))
	self.show()
