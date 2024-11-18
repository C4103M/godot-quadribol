extends Area2D
var velocity = Vector2.ZERO
var speed = 600
const direction = Vector2.LEFT

signal scoreUp
var pontuacao = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pontuacao += 1
		emit_signal("scoreUp")
		if pontuacao % 20 == 0:
			speed += 100
			velocity = direction * speed
			
