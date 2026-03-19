extends CanvasLayer

@export var player: Node2D
@onready var health_bar = $HealthBar

func _ready():
	
	if player:
		
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		
		player.health_changed.connect(update_bar)
	else:
		push_warning("Player is not assigned to the UI!")

func update_bar(new_health: int):
	health_bar.value = new_health
