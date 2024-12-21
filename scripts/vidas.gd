extends Node


@onready var vidas: Array[Node] = [get_node("1"), get_node("2"), get_node("3")]

var n_vidas = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_vidas() -> int:
	return n_vidas

func carrega_vidas() -> void:
	n_vidas = 3
	for vida in vidas:
		vida.set_visivel(true)

func dano() -> void:
	if n_vidas >= 1:
		n_vidas = n_vidas-1
		var vida: Node = vidas[n_vidas]
		vida.set_visivel(false)
