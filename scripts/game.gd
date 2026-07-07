extends Node

@export var width = 10
@export var height = 10
@export var mines_count = 12

var grid: Array[Cell] = [] # Vår 2D-array

@onready var grid_container: GridContainer = $GameCanvas/Control/MarginContainer/CenterContainer/GridContainer
@onready var hud = $HUD

const CELL_SCENE = preload("uid://c1s0y5oqqm6cc")

var flags = 0

var label_bombs = "Bombs left: "

func _unhandled_input(_event: InputEvent) -> void:
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_quit"):
			get_tree().quit()
	
	if Input.is_action_just_pressed("restart"):
		new_game()

func new_game():
	if hud.end:
		hud.toggle_end_controls()
	flags = mines_count
	generate_board(width, height, mines_count)
	calculate_numbers()

func _ready() -> void:
	new_game()

func generate_board(cols, rows, mines) -> void:
	# Clear board
	var grid_children = grid_container.get_children()
	for x in grid_children:
		x.queue_free()
		
	grid = []
	grid_container.columns = width
	
	for y in rows:
		#grid.append([])
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
		if grid[grid_index].is_flagged: return # Don't reveal flagged cell
		if grid.get(grid_index).is_mine:
			hud.toggle_end_controls()
			hud.set_end_text("You Loose!")
			#grid[grid_pos.y][grid_pos.x].set_texture(Util.TEXTURES.BOMB)
			show_all_bombs()
			return
		else:
			reveal_cell(grid_index, grid_pos)
	if index == MOUSE_BUTTON_RIGHT:
		if not grid.get(grid_index).is_flagged and not grid.get(grid_index).is_revealed and flags > 0:
			grid.get(grid_index).is_flagged = true
			grid.get(grid_index).set_texture(Util.TEXTURES.FLAG)
			hud.set_label_text(label_bombs + str(mines_count - get_flagged_cells()))
			flags -= 1
			check_win()
		elif grid.get(grid_index).is_flagged:
			grid.get(grid_index).is_flagged = false
			grid.get(grid_index).set_texture(Util.TEXTURES.DEFAULT)
			flags += 1
			hud.set_label_text(label_bombs + str(mines_count - get_flagged_cells()))

func calculate_numbers():
	for cell in grid:
		if cell.is_mine:
			continue
		var count = 0
		for other in grid:
			if other.is_mine and abs(cell.grid_pos.x - other.grid_pos.x) <= 1 \
			and abs (cell.grid_pos.y - other.grid_pos.y) <= 1 and cell != other:
				count += 1
		cell.neighbor_mines = count

func reveal_cell(index, _pos):
	if not grid.get(index).is_revealed:
		grid[index].is_revealed = true
		var proximity = grid[index].neighbor_mines
		var cell = grid[index] as Cell
		if cell.neighbor_mines == 0:
			reveal_empty_neighbors(cell)
		match proximity:
			0:
				grid[index].set_texture(Util.TEXTURES.BLANK)
			1:
				grid[index].set_texture(Util.TEXTURES.ONE)
			2:
				grid[index].set_texture(Util.TEXTURES.TWO)
			3:
				grid[index].set_texture(Util.TEXTURES.THREE)
			4:
				grid[index].set_texture(Util.TEXTURES.FOUR)
			5:
				grid[index].set_texture(Util.TEXTURES.FIVE)
			6:
				grid[index].set_texture(Util.TEXTURES.SIX)
			7:
				grid[index].set_texture(Util.TEXTURES.SEVEN)
			8:
				grid[index].set_texture(Util.TEXTURES.EIGHT)
		check_win()

func reveal_empty_neighbors(cell : Cell):
	for other in grid:
		if not other.is_revealed and not other.is_mine and not other.is_flagged \
		and abs(cell.grid_pos.x - other.grid_pos.x) <= 1 \
		and abs(cell.grid_pos.y - other.grid_pos.y) <= 1:
			other.is_revealed = true
			other.set_texture(Util.get_tex_from_int(other.neighbor_mines))
			if other.neighbor_mines > 0:
				cell.set_texture(Util.get_tex_from_int(cell.neighbor_mines))
			else:
				reveal_empty_neighbors(other)
		check_win()

func place_mines(mines):
	for mine in mines:
		var random_pos_x = randi_range(0, width-1)
		var random_pos_y = randi_range(0, height-1)
		for c in grid:
			if c.grid_pos == Vector2(random_pos_x, random_pos_y):
				c.is_mine = true
				#c.set_texture(Util.TEXTURES.BOMB)
		#prints(random_pos_x, random_pos_y)
	hud.set_label_text(label_bombs + str(mines_count))

func show_all_bombs():
	for c in grid:
		if c.is_mine:
			c.set_texture(Util.TEXTURES.BOMB)
			c.is_revealed = true

func get_flagged_cells() -> int:
	var count = 0
	for cell in grid:
		if cell.is_flagged:
			count += 1
	return count

func check_win():
	for cell in grid:
		if cell.is_mine and not cell.is_flagged and not cell.is_revealed:
			return
	if hud.end == false: hud.toggle_end_controls()
	hud.set_end_text("You WIN")
