extends CanvasLayer

var end : bool = false

func set_label_text(new_text) -> void:
	$Control/MarginContainer/HBoxContainer/Label.text = new_text

func set_end_text(new_text) -> void:
	$Control/EndLabel.text = new_text

func toggle_end_controls() -> void:
	if not end:
		$Control/EndLabel.visible = true
		$Control/RestartText.visible = true
		end = true
	else:
		$Control/EndLabel.visible = false
		$Control/RestartText.visible = false
		end = false
