extends CanvasLayer

@export var player: Node2D

# --- UI Nodes ---
@onready var health_bar = $HealthBar
@onready var xp_bar = $XPBar         
@onready var level_label = $LevelLabel  
@onready var win_screen = $WinScreen 
func _ready():
	if player:
		# --- Health Setup ---
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		player.health_changed.connect(update_health_bar) 
		
		# --- XP & Level Setup ---
		# We koppelen hier de nieuwe signalen van je Speler
		player.xp_changed.connect(update_xp_bar)
		player.level_changed.connect(update_level_text)
		
	else:
		push_warning("Player is not assigned to the UI!")

# UI Update Functies
func update_health_bar(new_health: int):

	health_bar.value = new_health

func update_xp_bar(current_xp: int, max_xp: int):
	xp_bar.max_value = max_xp
	xp_bar.value = current_xp

func update_level_text(new_level: int):
	level_label.text =  "Level: " + str(new_level)
	
	# Check of het level 10 is
	if new_level == 5:
		show_victory()
		
func show_victory():
	# Laat het scherm zien
	win_screen.show()
	# Zet de hele game op pauze
	get_tree().paused = true
