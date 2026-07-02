extends Node

const TEXTURES = {
	"DEFAULT" : Vector2(16, 32),
	"BLANK" : Vector2(0, 32),
	"FLAG" : Vector2(48, 32),
	"BOMB" : Vector2(32, 32),
	"1" : Vector2(0, 0),
	"2" : Vector2(16, 0),
	"3" : Vector2(32, 0),
	"4" : Vector2(48, 0),
	"5" : Vector2(0, 16),
	"6" : Vector2(16, 16),
	"7" : Vector2(32, 16),
	"8" : Vector2(48, 16)
}

const DIR = {
	"1": Vector2(-1, -1),		# Top Left
	"2": Vector2(0, -1), 		# Top
	"3": Vector2(1, -1),		# Top Right
	"4": Vector2(-1, 0), 		# Left
	# middle
	"6": Vector2(1, 0), 		# Right
	"7": Vector2(0, -1),		# Down Left
	"8": Vector2(0, 1), 		# Down 
	"9": Vector2(1, 1)			# Down Right
}
