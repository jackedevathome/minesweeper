extends Camera2D

@export var starting_zoom_val : Vector2 = Vector2(0.5, 0.5)
@export var zoom_speed = 0.05
@export var pan_speed = 5

func _ready() -> void:
	starting_zoom_val = zoom

func _unhandled_input(event: InputEvent) -> void:
	# Zooming and Panning
	if event is InputEventMouseButton:
		# Zooming
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)

	zoom = zoom.clamp(Vector2(0.5, 0.5), Vector2(10, 10))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset_cam"):
		zoom = starting_zoom_val

	var pan_dir = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	offset += pan_dir * pan_speed
