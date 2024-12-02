extends Node


@onready var notas: Array[Node] = [
	get_node("1"), get_node("2"), get_node("3"),
	get_node("4"), get_node("5"), get_node("6"),
	get_node("7"), get_node("8"), get_node("9")
]
@onready var visibilidades: Array[bool]

func toggle_nota(n) -> void:
	var nota: Node = notas[n-1]
	visibilidades[n-1] = not visibilidades[n-1]
	nota.set_visivel(visibilidades[n-1])

func remove_notas() -> void:
	for nota in notas:
		nota.set_visivel(false)
	visibilidades = [false,false,false,false,false,false,false,false,false]
