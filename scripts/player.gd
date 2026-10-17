extends CombatEntity

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Node2D = $Weapon
@export var speed = 100
@onready var current_state: Label = $CurrentState

signal attack_finished

var direction = "front"
var input_direction: Vector2

func _ready() -> void:
	current_health = max_health

func transform_direction(input_direction) -> void:
	if input_direction == Vector2.ZERO:
		return
	 
	var angle = rad_to_deg(input_direction.angle_to(Vector2(1.0,1.0).normalized())) # quad1 diagonal
	if angle < -91.0: # angle_to makes front left to appear as left with 90 when front right is front
		direction = "left"
	elif angle <= 0.0:
		direction = "front"
	elif angle < 90.0:
		direction = "right"
	else:
		direction = "back"

func _get_direction():
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	return input_direction

func apply_movement():
	velocity = input_direction * speed
	weapon.look_at(get_global_mouse_position())

func _on_area_2d_vision_area_exited(area: Area2D) -> void:
	var target = area.get_parent()  # the Hurtbox's parent is the entity itself
	if target is CombatEntity:
		target.visible = false
