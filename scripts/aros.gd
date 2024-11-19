extends Area2D
var pont: int = 0
var velocity = Vector2.ZERO
var speed: int = 1400
const direction = Vector2.LEFT

signal scoreUp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed
	position += velocity * delta
	print("A velocidade é", position)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("scoreUp")

func ctrlVelocidade(): 
	speed += 100
	#velocity = direction * speed  # Recalcula o vetor de movimento
