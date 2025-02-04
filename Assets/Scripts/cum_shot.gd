extends Area2D


@onready var cum_sprite: Sprite2D = %CumSprite

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	rotation = 0
	add_to_group("cum") 


func _physics_process(delta: float) -> void:
	cum_sprite.flip_v = velocity.x < 0
	position += velocity * delta
	rotation = 0


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.dead = true
		DeadSound.play()
		get_tree().change_scene_to_file("res://Assets/Scenes/game_over.tscn")
