extends Button
signal change_cooktime(seconds:int)

@export var seconds:int = 0

func _on_pressed() -> void:
	change_cooktime.emit(seconds)
