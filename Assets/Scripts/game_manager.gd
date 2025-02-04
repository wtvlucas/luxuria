extends Node

var switch : bool = false
@export var bullets : int = 10
@export var score : int = 0
@export var dead : bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func reset() -> void:
	bullets = 10
	score = 0
	dead = false
	var priests = get_tree().get_nodes_in_group("priests")
	var cums = get_tree().get_nodes_in_group("cum")
	
	for cum in cums:
		if cum:  # Verifica se o priest ainda existe
			cum.queue_free()
			
	for priest in priests:
		if priest:  # Verifica se o priest ainda existe
			priest.queue_free()
