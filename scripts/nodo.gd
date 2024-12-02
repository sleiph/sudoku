extends Node2D


var n: int = 0
var jogo: Node = null

var pressed: bool = false
var editavel: bool = true

var ctrl_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_estado_focus_entered() -> void:
	pressed = true

func _on_estado_focus_exited() -> void:
	pressed = false

func _input(ev: InputEvent) -> void:
	if (ev is InputEventKey):
		if editavel and pressed:
			if ev.as_text_keycode()=='Ctrl':
				ctrl_pressed = ev.is_pressed()
			elif ev.is_released():
				if ctrl_pressed:
					input_notas(ev)
				else:
					input_principal(ev)

func input_principal(ev: InputEventKey) -> void:
	var input: int = get_input(ev)
	
	if input > 0:
		if (checa_input(input)):
			preenche_valor(input)
		else:
			jogo.dano()

func get_input(ev: InputEventKey) -> int:
	match ev.as_text_keycode():
		'1', 'Kp 1', 'Ctrl+Kp 1':
			return 1
		'2', 'Kp 2', 'Ctrl+Kp 2':
			return 2
		'3', 'Kp 3', 'Ctrl+Kp 3':
			return 3
		'4', 'Kp 4', 'Ctrl+Kp 4':
			return 4
		'5', 'Kp 5', 'Ctrl+Kp 5':
			return 5
		'6', 'Kp 6', 'Ctrl+Kp 6':
			return 6
		'7', 'Kp 7', 'Ctrl+Kp 7':
			return 7
		'8', 'Kp 8', 'Ctrl+Kp 8':
			return 8
		'9', 'Kp 9', 'Ctrl+Kp 9':
			return 9
		'Delete', 'Backspace', 'Ctrl+Delete':
			return -1
	return 0

func input_notas(ev: InputEventKey) -> void:
	var input: int = get_input(ev)
	
	if input > 0:
		$notas.toggle_nota(input)
	if input == -1:
		$notas.remove_notas()

func carregar_nodo(numero: int, v: int, vizinhos: Array[NodePath], sequencia: Array[NodePath], nodo_jogo: Node) -> void:
	n = numero
	jogo = nodo_jogo
	editavel = !v
	$notas.remove_notas()
	$inicial.preenche(numero, v)
	$variavel.preenche(numero, false)
	$estado.disabled = !editavel
	preenche_vizinhos(vizinhos)
	preenche_sequencia(sequencia)

func preenche_valor(n: int):
	if n > 0:
		editavel = false
		$notas.remove_notas()
		$variavel.set_visivel(true)

func preenche_vizinhos(vizinhos: Array[NodePath]) -> void:
	$estado.focus_neighbor_left = vizinhos[0]
	$estado.focus_neighbor_right = vizinhos[1]
	$estado.focus_neighbor_top = vizinhos[2]
	$estado.focus_neighbor_bottom = vizinhos[3]

func preenche_sequencia(sequencia: Array[NodePath]) -> void:
	$estado.focus_previous = sequencia[0]
	$estado.focus_next = sequencia[1]

func get_estado() -> NodePath:
	return $estado.get_path()

func checa_input(input: int) -> bool:
	return input == n
