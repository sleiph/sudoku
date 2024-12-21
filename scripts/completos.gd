extends Node


@onready var numeros: Array[Node] = [
	get_node("1"), get_node("2"), get_node("3"),
	get_node("4"), get_node("5"), get_node("6"),
	get_node("7"), get_node("8"), get_node("9")
]

@onready var completos: Array[int] = [
	0, 0, 0,
	0, 0, 0,
	0, 0, 0
]

var terminados = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_certo(n: int) -> void:
	completos[n] = completos[n]+1

func checa_completo(n: int) -> bool:
	return completos[n] == 9

func checa_terminado() -> bool:
	return terminados == 9

func set_completo(n: int) -> void:
	numeros[n].visible = true
	terminados = terminados + 1
