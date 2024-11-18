extends ColorRect

func _ready() -> void:
	# Configura a cor inicial do ColorRect
	
	self.color = Color(0, 0, 0, 0.5)  # Preto translúcido
	

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 0.5), 1.0)  # Suaviza até 0.5 de opacidade

func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 0.0), 1.0)  # Suaviza até transparente
