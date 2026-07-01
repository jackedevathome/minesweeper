extends TextureButton
class_name Cell

const TEXTURE_ATLAS = preload("res://assets/minesweeper.png")

var texture_tile_size = 16

signal cell_clicked(position: Vector2, button_index: int)

@export var grid_pos: Vector2 = Vector2.ZERO
@export var is_mine : bool = false
@export var is_revealed: bool = false
@export var is_flagged: bool = false
@export var neighbor_mines: int = 0

func _ready() -> void:
	if is_mine:
		set_texture(Util.TEXTURE_INDEX.BOMB)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		cell_clicked.emit(grid_pos, event.button_index)

func set_texture(texture_index: Vector2i):
	if texture_normal is AtlasTexture:
		texture_normal.region = Rect2(texture_index.x, texture_index.y, texture_tile_size, texture_tile_size)
