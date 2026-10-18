extends Node

var can_pickup:bool = true

func _ready() -> void:
	get_tree().root.physics_object_picking_sort = true
	get_tree().root.physics_object_picking_first_only = true
