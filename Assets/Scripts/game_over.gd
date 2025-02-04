extends Node2D

@onready var score: Label = %score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "SCORE: " + str(GameManager.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://Assets/Scenes/main_scene.tscn")
		GameManager.reset()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
