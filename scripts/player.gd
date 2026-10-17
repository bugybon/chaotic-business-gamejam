extends CombatEntity

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Node2D = $Weapon
@export var speed = 100
@onready var current_state: Label = $CurrentState
@onready var weapon_pivot: Marker2D = $WeaponPivot
@export var weapon_distance:float = 10.0
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
	
	var mouse_direction:Vector2 = weapon_pivot.global_position.direction_to(get_global_mouse_position())
	weapon.global_position = weapon_pivot.global_position + mouse_direction * weapon_distance
	print(weapon_pivot.global_position, global_position)
	weapon.look_at(get_global_mouse_position())
