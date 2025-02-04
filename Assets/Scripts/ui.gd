extends CanvasLayer

@onready var score: Label = %Score


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta: float) -> void:
	
	$TextureProgressBar.position = get_viewport().get_mouse_position()

	$TextureProgressBar.value = GameManager.bullets
	
	score.text = str(GameManager.score)
