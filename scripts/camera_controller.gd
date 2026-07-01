extends Camera2D

@export var zoom_speed = 0.1
@export var pan_speed = 0.2

func _unhandled_input(event: InputEvent) -> void:
	# Zooming and Panning
	if event is InputEventMouseButton:
		# Zooming
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)

	zoom = zoom.clamp(Vector2(0.5, 0.5), Vector2(10, 10))

	if event is InputEventMouseMotion:
		if Input.is_action_pressed("camera_pan_mouse_middle"):
			global_position -= event.relative
