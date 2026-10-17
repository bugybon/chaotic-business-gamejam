extends Node2D
var area_effect
var area_instance
signal attack_finished
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var marker_2d: Marker2D = $Marker2D

func _ready() -> void:
	area_effect = preload("res://objects/weapon_projectile.tscn")
	
func ranged_attack_animation() -> void:
	animation_player.play("ranged_attack")
	area_instance = area_effect.instantiate()
	get_tree().current_scene.add_child(area_instance)
	area_instance.global_position = marker_2d.global_position
	area_instance.rotation = rotation


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ranged_attack":
		attack_finished.emit()
