extends CharacterBody2D

const SPEED = 650.0
const JUMP_VELOCITY = -400.0

var isDead: bool = false
signal game_over_signal

func _physics_process(delta: float):
	# Obter a direção dos inputs para os eixos X e Y.
	var direction_x := Input.get_axis("esquerda", "direita")  # Movimento horizontal
	var direction_y := Input.get_axis("cima", "baixo")    # Movimento vertical
	# Atualizar a velocidade no eixo X e Y.
	velocity.x = direction_x * SPEED 
	velocity.y = direction_y * SPEED 
	# Desacelerar suavemente quando não houver input.
	if direction_x == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_y == 0:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	check_collisions()
	move_and_slide()
	
func check_collisions():
	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		#print("Colidiu com:", collision.get_collider().name)
		if collision.get_collider().name == "down" or collision.get_collider().name == "up":
			emit_signal("game_over_signal")
