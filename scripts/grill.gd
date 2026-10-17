extends Node2D

# in ingame seconds measured
var cooktime:int = 0
@onready var time_label: Label = $Control/VBoxContainer/TimeLabel
@onready var timer: Timer = $Timer
@onready var start_button: Button = $Control/VBoxContainer/StartButton
var time_pattern:String = "%02d:%02d"
var buttons:Array[Node]
var food:Area2D
var cooking:bool = false
var is_empty:bool = true

signal start_cooking()

func disable_buttons(state:bool)->void:
	for button in buttons:
		button.disabled = state
	start_button.disabled = state

#time * 10 / 60 -> time/6; 1 irl second -> 10 ingame seconds
func timer_to_in_game_time(time:int) -> Array[int]:
	return [time/6,time*10%60]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttons = get_tree().get_nodes_in_group("seconds_buttons")
	for button in buttons:
		button.change_cooktime.connect(_on_change_cooktime)
	
	time_label.text = time_pattern % [cooktime/60, cooktime%60]

func _process(delta: float) -> void:
	if cooking:
		time_label.text = time_pattern % timer_to_in_game_time(ceili(timer.time_left))
		print(time_pattern % timer_to_in_game_time(ceili(timer.time_left)) + " " + str(timer.time_left))
#
func _on_change_cooktime(seconds:int) -> void:
	cooktime =max(cooktime + seconds, 0)
	print(cooktime)
	time_label.text = time_pattern % [cooktime/60, cooktime%60]


func _on_start_button_start_cooking() -> void:
	timer.start(cooktime/10)
	cooking = true
	if food != null: food.start_cooking()
	disable_buttons(true)


func _on_timer_timeout() -> void:
	timer.stop()
	cooktime = 0
	cooking = false
	disable_buttons(false)
	time_label.text = time_pattern % [0,0]

#
#func _on_area_entered(area: Area2D) -> void:
	#area.get_parent().remove_child(area)
	#self.add_child(area)
#
#
#func _on_area_exited(area: Area2D) -> void:
	#self.remove_child(area)
	#get_tree().root.add_child(area)
