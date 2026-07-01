extends Node

@export var size = 10
@export var width = 10
@export var height = 10
@export var mines_count = 12

var grid: Array = [] # Vår 2D-array

@onready var grid_container: GridContainer = $CanvasLayer/Control/MarginContainer/CenterContainer/GridContainer

const CELL_SCENE = preload("uid://c1s0y5oqqm6cc")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _ready() -> void:
	var grid_children = grid_container.get_children()
	for x in grid_children:
		x.queue_free()
	
	
	grid_container.columns = width
	for x in range(width):
		grid.append([])
		for y in range(height):
			var cell = CELL_SCENE.instantiate() as Cell
			grid_container.add_child(cell)
			cell.cell_clicked.connect(on_cell_clicked.bind())
			cell.grid_pos = Vector2(y, x)
			grid[x].append(cell)
	place_mines()

func on_cell_clicked(grid_pos, index):
	if index == MOUSE_BUTTON_LEFT:
		reveal_cell(grid_pos)
	elif index == MOUSE_BUTTON_MASK_RIGHT:
		if not grid[grid_pos.y][grid_pos.x].is_flagged:
			grid[grid_pos.y][grid_pos.x].set_texture(Util.TEXTURE_INDEX.FLAG)
		else:
			grid[grid_pos.y][grid_pos.x].set_texture(Util.TEXTURE_INDEX.DEFUALT)

func reveal_cell(pos):
	#print(grid[pos.y][pos.x].is_mine)
	grid[pos.y][pos.x].is_revealed = true
	grid[pos.y][pos.x].set_texture(Util.TEXTURE_INDEX.BLANK)

func place_mines():
	for mine in range(mines_count):
		var random_pos_x = randi_range(0, width-1)
		var random_pos_y = randi_range(0, height-1)
		grid[random_pos_x][random_pos_y].is_mine = true
		grid[random_pos_x][random_pos_y].set_texture(Util.TEXTURE_INDEX.BOMB)
		prints(random_pos_x, random_pos_y)
		
