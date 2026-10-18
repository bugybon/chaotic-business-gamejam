extends Area2D

enum Cooked{Raw, Medium, WellDone, Burned}

var draggable:bool = false
var offset:Vector2
#var station:Area2D = null

func attach(station) -> void:
	if station != null:
		#get_parent().remove_child(self)
		reparent(station)
		#station.is_empty = false
	else:
		#get_parent().remove_child(self)
		#get_parent().is_empty = true
		reparent(get_tree().root)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if draggable:
		#if Input.is_action_just_pressed("left_click"):
			#Global.can_pickup = false
			#offset = get_global_mouse_position() - global_position
		#if Input.is_action_pressed("left_click"):
			#global_position = get_global_mouse_position() - offset
		#if Input.is_action_just_released("left_click"):
			#Global.can_pickup = true
		if Input.is_action_just_pressed("left_click"):
			#attach()
			pass


func _on_mouse_entered() -> void:
	self.modulate = Color(1.2,1.2,1.2)
	if Global.can_pickup:
		draggable = true


func _on_mouse_exited() -> void:
	self.modulate = Color(1,1,1)
	draggable = false

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("parent" + area.get_parent().get_class())
	#if area.get_parent() is RigidBody2D:
		#pass
	#
	#station = area
	#if !Input.is_action_pressed("left_click"):
		#attach()
	##print(station.name)


#func _on_area_2d_area_exited(area: Area2D) -> void:
	#station = null
