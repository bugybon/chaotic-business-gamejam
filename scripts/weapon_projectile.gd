extends Area2D
@export var damage:int = 0
@export var speed:float = 5.0
var max_distance:float = 1000.0
var distance:float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	distance = delta * speed
	
	if max_distance < distance:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	var target = area.get_parent()
	if target is CombatEntity:
		target.take_damage(damage)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
