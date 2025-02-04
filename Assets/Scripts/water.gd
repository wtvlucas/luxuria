extends Area2D

var velocity: Vector2
var priest: CharacterBody2D


func _process(delta: float) -> void:
	position += velocity * delta
	
	if !get_viewport_rect().has_point(global_position):
		queue_free()
	




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("priests"):
		body.queue_free()
		self.queue_free()
		PriestDamage.play()
		GameManager.score += 1
