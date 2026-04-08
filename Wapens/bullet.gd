extends Area2D

var speed: float = 800.0
var direction: Vector2 = Vector2.ZERO
var damage: int = 2 

func _ready():
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Monster"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
