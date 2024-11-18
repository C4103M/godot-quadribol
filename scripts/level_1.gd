extends Node2D


var fundo1_sprite: Sprite2D
var cenarySpeed: float = 0.1
var accumulated_offset: float = 0.0  # Armazena o deslocamento acumulado
var delta_time: float = 0.0
var cont = 0
var score = 0
var is_paused = false

@onready var label_start = $label_start
@onready var fundo_game = $Fundo1
@onready var btn_pause = $pause
@onready var canvas_pause = $Canvas_pause
@onready var continuar: Button = $Canvas_pause/continuar
@onready var label_score = $score
@onready var label_score2 = $Canvas_game_over/score
@onready var timer = $Timer
@onready var player = $Player
@onready var canvas_game_over = $Canvas_game_over
@onready var btn_restart = $Canvas_game_over/restart


func _ready():
	fundo1_sprite = fundo_game.get_node("%fundo1_sprite")
	fundo1_sprite.material.set_shader_parameter("offset", accumulated_offset)
	btn_pause.connect("pressed", Callable(self, "_on_pause_button_pressed"))
	timer.connect("timeout", Callable(self, "aroGenerator"))
	player.connect("game_over_signal", Callable(self, "gameover"))
	btn_restart.connect("pressed", Callable(self, "restart"))
	fundo_game.z_index = -2

func _input(event):
	print("Tecla pressionada: ", event)
	if (event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton) and event.pressed and cont < 1:
		start()
		cont += 1
	if Input.is_action_pressed("pause"):
		if is_paused:
			_on_continuar_pressed()
		else:
			_on_pause_button_pressed()

func _on_pause_button_pressed():
	get_tree().paused = true  # Pausa ou despausa a árvore de nós do jogo
	print("Jogo pausado")
	canvas_pause.visible = true
	fundo1_sprite.material.set_shader_parameter("speed", 0)
	is_paused = true

func _on_continuar_pressed():
	get_tree().paused = false  # Pausa ou despausa a árvore de nós do jogo
	print("Jogo continuando")
	fundo1_sprite.material.set_shader_parameter("speed", cenarySpeed)
	canvas_pause.visible = false
	is_paused = false

func _process(delta):
	if not get_tree().paused:  # Só atualiza se o jogo não estiver pausado
		delta_time = delta
		update_cenary()
	

func update_cenary():
	# Atualiza o deslocamento acumulado
	accumulated_offset += cenarySpeed * delta_time
	fundo1_sprite.material.set_shader_parameter("offset", accumulated_offset)

func start():
	label_start.visible = false
	btn_pause.visible = true
	label_score.visible = true
	fundo1_sprite.material.set_shader_parameter("speed", 0.1)
	aroGenerator()

func aroGenerator():
	var aro = preload("res://Interfaces/aros.tscn").instantiate()
	aro.position = Vector2(1920, randf_range(216, 864))
	#aro.position = Vector2(1920, 864)
	aro.connect("scoreUp", scoreUp)
	call_deferred("add_child", aro)
	aro.z_index = -1
	timer.start()

func scoreUp():
	score += 1
	cenarySpeed += 0.02
	label_score.text = str(score)
	
func gameover():
	get_tree().paused = true
	print('gameover')
	label_score2.text = str(score)
	canvas_game_over.visible = true

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
