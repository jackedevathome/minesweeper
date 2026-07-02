extends Node

@export var width = 10
@export var height = 10
@export var mines_count = 12

var grid: Array[Cell] = [] # Vår 2D-array

@onready var grid_container: GridContainer = $CanvasLayer/Control/MarginContainer/CenterContainer/GridContainer

const CELL_SCENE = preload("uid://c1s0y5oqqm6cc")

func _unhandled_input(_event: InputEvent) -> void:
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_quit"):
			get_tree().quit()
	
	if Input.is_action_just_pressed("restart"):
		generate_board(width, height, mines_count)

func _ready() -> void:
	generate_board(width, height, mines_count)

func generate_board(cols, rows, mines) -> void:
	# Clear board
	var grid_children = grid_container.get_children()
	for x in grid_children:
		x.queue_free()
		
	grid = []
	grid_container.columns = width
	
	for y in rows:
		for x in cols:
			var cell = CELL_SCENE.instantiate() as Cell
			grid_container.add_child(cell)
			cell.grid_pos = Vector2(x, y)
			cell.cell_clicked.connect(on_cell_clicked.bind())
			grid.append(cell)
			cell.grid_index = grid.size() - 1
	place_mines(mines)
	#print_debug(grid.size())

func on_cell_clicked(grid_index : int, grid_pos: Vector2, index : int):
	if index == MOUSE_BUTTON_LEFT:
		#print(grid[grid_pos])
		if grid.get(grid_index).is_mine:
			print("BOOOM!")
			#grid[grid_pos.y][grid_pos.x].set_texture(Util.TEXTURES.BOMB)
			show_all_bombs()
			return
		else:
			get_neighbors(grid[grid_index])
			reveal_cell(grid_index, grid_pos)
	if index == MOUSE_BUTTON_RIGHT:
		if not grid.get(grid_index).is_flagged and not grid.get(grid_index).is_revealed:
			grid.get(grid_index).is_flagged = true
			grid.get(grid_index).set_texture(Util.TEXTURES.FLAG)
		elif grid.get(grid_index).is_flagged:
			grid.get(grid_index).is_flagged = false
			grid.get(grid_index).set_texture(Util.TEXTURES.DEFAULT)

func get_neighbors(cell: Cell):
	var n = cell.grid_pos - Vector2(-1, 0)
	print(n)

func get_nearby_cells(cell: Cell, total_rows: int, total_columns:int) -> Array[Cell]:
	var current_pos : Vector2 = cell.grid_pos
	
	var nearby_cells: Array[Cell] = []
	
	var top_left: int = (current_pos.y - 1) + ((current_pos.x - 1) * width)
	#print_debug(top_left)
	
	return [Cell.new()] ## CHANGE THIS RETURN STATEMENT

func reveal_cell(index, pos):
	if not grid.get(index).is_revealed:
		grid[index].is_revealed = true
		grid[index].set_texture(Util.TEXTURES.BLANK)
	print(grid[index].grid_pos)

func place_mines(mines):
	for mine in range(mines):
		var random_pos_x = randi_range(0, width-1)
		var random_pos_y = randi_range(0, height-1)
		for c in grid:
			if c.grid_pos == Vector2(random_pos_x, random_pos_y):
				c.is_mine = true
				#c.set_texture(Util.TEXTURES.BOMB)
		#prints(random_pos_x, random_pos_y)

func show_all_bombs():
	for c in grid:
		if c.is_mine:
			c.set_texture(Util.TEXTURES.BOMB)
