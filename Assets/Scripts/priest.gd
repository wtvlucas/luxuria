extends CharacterBody2D

@export var speed: float = 200
var nun_body: CharacterBody2D
@onready var priest_sprite: AnimatedSprite2D = %PriestSprite
@onready var cum_shot_timer: Timer = %CumShotTimer
@export var cumshot_scene: PackedScene
@onready var cum_sound: AudioStreamPlayer2D = %CumSound


func _ready() -> void:
	rotation = 0
	set_physics_process(true)
	add_to_group("priests") 
	add_child(cum_shot_timer)
	#nun_body = get_tree().root.get_node("NunBody")

	# Conectar o timer ao método de disparo do cumshot
	cum_shot_timer.connect("timeout", Callable(self, "_priest_shoot_cumshot"))
	cum_shot_timer.wait_time = 3
	



func _physics_process(delta: float) -> void:
	# Verificar se o nun_body existe e o jogo não está em "game over"
	if GameManager.dead == false and nun_body != null:
		var direction = (nun_body.global_position - global_position).normalized()
		
		priest_sprite.flip_h = direction.x < 0

		velocity = direction * speed
		move_and_slide()
		rotation = 0
		

		
func _on_priest_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.dead = true
		DeadSound.play()
		get_tree().change_scene_to_file("res://Assets/Scenes/game_over.tscn")

func _priest_shoot_cumshot() -> void:
	# Verificar se o nun_body ainda existe antes de tentar instanciar e mover o cumshot
	if GameManager.dead == false:
		var cumshot = cumshot_scene.instantiate() as Area2D
		
		cum_sound.play()
		
		# Define a posição inicial do cumshot como a posição do priest
		cumshot.global_position = global_position
		
		# Adiciona o cumshot como filho ao nó pai do priest
		get_parent().add_child(cumshot)
		
		# Calcula a direção para a nun_body
		var direction: Vector2 = (nun_body.global_position - global_position).normalized()
		
		# Define a rotação do cumshot para que ele aponte na direção da nun_body
		var cumshot_sprite = cumshot.get_node("CumSprite")
		cumshot_sprite.rotation = direction.angle()
		
		# Move o cumshot na direção da nun_body
		cumshot.add_to_group("moving_cumshots")
		cumshot.set("velocity", direction * 700)
