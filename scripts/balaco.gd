extends Area2D
const direction = Vector2.LEFT
var speed = 1000
var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("A velocidade é", speed)
	position += velocity * delta
