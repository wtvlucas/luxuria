extends CharacterBody2D

@export var speed: float = 600

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _ready() -> void:
	add_to_group("player") 
	

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	clamp_player_to_viewport()  # Limitar o player à viewport

func clamp_player_to_viewport() -> void:
	# Obtém os limites do viewport (área visível)
	var viewport_rect = get_viewport_rect()

	# Clampa a posição do player para ficar dentro da área visível
	position.x = clamp(position.x, viewport_rect.position.x, viewport_rect.position.x + viewport_rect.size.x)
	position.y = clamp(position.y, viewport_rect.position.y, viewport_rect.position.y + viewport_rect.size.y)
