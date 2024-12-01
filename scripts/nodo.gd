extends Node2D


var n: int = 0

var pressed: bool = false
var editavel: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_estado_focus_entered() -> void:
	pressed = true

func _on_estado_focus_exited() -> void:
	pressed = false

func _input(ev: InputEvent) -> void:
	if ev is InputEventKey:
		if editavel and pressed:
			var input: int = 0
			var teste = ev.as_text_keycode()
			match ev.as_text_keycode():
				'Kp 1':
					input=1
				'Kp 2':
					input=2
				'Kp 3':
					input=3
				'Kp 4':
					input=4
				'Kp 5':
					input=5
				'Kp 6':
					input=6
				'Kp 7':
					input=7
				'Kp 8':
					input=8
				'Kp 9':
					input=9
				'Delete':
					input=-1
				
			muda_valor(input)
	
func carregar_nodo(numero: int, v: int, vizinhos: Array[NodePath], sequencia: Array[NodePath]) -> void:
	n = numero
	editavel = !v
	$inicial.preenche(numero, v)
	$estado.disabled = !editavel
	preenche_vizinhos(vizinhos)
	preenche_sequencia(sequencia)

func muda_valor(n: int):
	if n>0:
		$variavel.preenche(n, 1)
	elif n<0:
		$variavel.limpa()

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
