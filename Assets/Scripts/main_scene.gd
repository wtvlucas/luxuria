extends Node2D

@export var water_drop_scene: PackedScene 
@export var priest_scene: PackedScene
@export var shoot_speed: float = 500 
@onready var weapon: Sprite2D = %Weapon
@onready var nun_body: CharacterBody2D = %NunBody
@onready var refill_timer: Timer = %RefillTimer
@export var refill_scene: PackedScene

@export var screen_margin: float = 50 
@export var spawn_interval: float = 3.0  

var spawn_timer: Timer

@onready var water_sound: AudioStreamPlayer2D = %WaterSound




func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", Callable(self, "_spawn_priest"))
	GameManager.dead = false
	add_child(spawn_timer)
	spawn_timer.start()
	
	refill_timer.connect("timeout", Callable(self, "_spawn_refill"))
	add_child(refill_timer)
	

	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and GameManager.bullets > 0:
		_shoot_water_drop()
		

func _spawn_priest() -> void:
	var priest = priest_scene.instantiate() as CharacterBody2D
	
	priest.global_position = get_random_offscreen_position()
	
	priest.nun_body = nun_body

	get_parent().add_child(priest)
	
	if spawn_timer.wait_time > 1:
		spawn_timer.wait_time -= 0.1
	
	


func _shoot_water_drop() -> void:
	
	var water_drop: Area2D = water_drop_scene.instantiate() as Area2D
	
	water_sound.play()
	
	var weapon_tip_pos: Vector2 = weapon.global_position + Vector2.RIGHT.rotated(weapon.rotation) * weapon.texture.get_size().x / 2
	water_drop.global_position = weapon_tip_pos
	
	get_parent().add_child(water_drop)
	
	var water_sprite = water_drop.get_node("WaterSprite")

	
	var direction: Vector2 = Vector2.RIGHT.rotated(weapon.rotation)
	water_sprite.rotation = direction.angle()
	water_sprite.flip_v = GameManager.switch
	
	water_drop.add_to_group("moving_water_drops")
	water_drop.set("velocity", direction * shoot_speed)
	
	GameManager.bullets -= 1


func get_random_offscreen_position() -> Vector2:
	var viewport_rect = get_viewport().get_visible_rect()
	var position = Vector2()
	
	match randi() % 4:
		0:  # Spawn à esquerda
			position.x = viewport_rect.position.x - screen_margin
			position.y = randf_range(viewport_rect.position.y, viewport_rect.position.y + viewport_rect.size.y)
		1:  # Spawn à direita
			position.x = viewport_rect.position.x + viewport_rect.size.x + screen_margin
			position.y = randf_range(viewport_rect.position.y, viewport_rect.position.y + viewport_rect.size.y)
		2:  # Spawn no topo
			position.x = randf_range(viewport_rect.position.x, viewport_rect.position.x + viewport_rect.size.x)
			position.y = viewport_rect.position.y - screen_margin
		3:  # Spawn na parte inferior
			position.x = randf_range(viewport_rect.position.x, viewport_rect.position.x + viewport_rect.size.x)
			position.y = viewport_rect.position.y + viewport_rect.size.y + screen_margin
	return position
	
func _spawn_refill() -> void:
	# Instanciar o objeto da cena "refill"
	var refill_instance = refill_scene.instantiate() as Node2D
	
	# Definir a posição onde o objeto será spawnado
	# Aqui você pode modificar para qualquer posição que desejar
	refill_instance.position = get_random_spawn_position()
	
	# Adicionar o objeto à árvore de nós (na cena atual)
	get_parent().add_child(refill_instance)

func get_random_spawn_position() -> Vector2:
	# Defina uma posição aleatória na tela ou defina sua própria lógica
	var viewport = get_viewport_rect()
	var x = randf_range(viewport.position.x, viewport.size.x)
	var y = randf_range(viewport.position.y, viewport.size.y)
	return Vector2(x, y)
