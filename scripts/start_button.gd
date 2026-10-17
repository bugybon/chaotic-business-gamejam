extends Button

signal start_cooking()

func _on_pressed() -> void:
	start_cooking.emit()
