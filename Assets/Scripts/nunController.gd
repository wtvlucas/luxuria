extends Sprite2D


@onready var nun: Sprite2D = %Nun
@onready var weapon: Sprite2D = %Weapon
@onready var nun_body: CharacterBody2D = %NunBody

@export var water_drop_scene: PackedScene 
@export var shoot_speed: float = 800 


var mousePos : Vector2
var weaponPos : Vector2


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	mousePos = get_viewport().get_mouse_position()
	
	weaponPos = weapon.global_position
	
	var weaponDirection: Vector2 = mousePos - weaponPos
	var weaponAngle: float = weaponDirection.angle()
	
	weapon.rotation = weaponAngle
	if mousePos.x < nun_body.position.x:
		nun.flip_h = true
		weapon.flip_v = true
		GameManager.switch = true
	else:
		nun.flip_h = false
		weapon.flip_v = false
		GameManager.switch = false
		
	

		
		
		
