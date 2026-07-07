extends Node

const TEXTURES = {
	"DEFAULT" : Vector2(16, 32),
	"BLANK" : Vector2(0, 32),
	"FLAG" : Vector2(48, 32),
	"BOMB" : Vector2(32, 32),
	"ONE" : Vector2(0, 0),
	"TWO" : Vector2(16, 0),
	"THREE" : Vector2(32, 0),
	"FOUR" : Vector2(48, 0),
	"FIVE" : Vector2(0, 16),
	"SIX" : Vector2(16, 16),
	"SEVEN" : Vector2(32, 16),
	"EIGHT" : Vector2(48, 16)
}

const DIR = {
	"TOP_LEFT": Vector2(-1, -1),		# Top Left
	"TOP": Vector2(0, -1), 		# Top
	"TOP_RIGHT": Vector2(1, -1),		# Top Right
	"LEFT": Vector2(-1, 0), 		# Left
	# middle
	"RIGHT": Vector2(1, 0), 		# Right
	"DOWN_LEFT": Vector2(0, -1),		# Down Left
	"DOWN": Vector2(0, 1), 		# Down 
	"DOWN_RIGHT": Vector2(1, 1)			# Down Right
}

func get_tex_from_int(val):
	match val:
		0:
			return Vector2(0, 32)
		1:
			return Vector2(0, 0)
		2:
			return Vector2(16, 0)
		3:
			return Vector2(32, 0)
		4:
			return Vector2(48, 0)
		5:
			return Vector2(0, 16)
		6:
			return Vector2(16, 16)
		7:
			return Vector2(32, 16)
		8:
			return Vector2(48, 16)
		"_":
			printerr("Wrong value in function Should be an integer between 1-8")
