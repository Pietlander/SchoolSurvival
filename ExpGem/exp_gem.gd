extends Area2D

var exp_value: int = 1

func _ready():
	# Verbind de signal zodat we weten wanneer de speler ons aanraakt
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"): # Zorg dat je speler in de groep "player" zit!
		if body.has_method("gain_experience"):
			body.gain_experience(exp_value)
			queue_free() # Verwijder het kristal
