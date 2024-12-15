extends Node


@onready var jogo_node: Node = get_node("../jogo")

@onready var difc_node: Node = get_node("botoes/novo/dificuldade")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func novo_jogo(dificuldade: int) -> void:
	jogo_node.comeca_jogo(9, dificuldade)
	difc_node.visible = false
	self.visible = false
	jogo_node.visible = true

func esconde_jogo() -> void:
	jogo_node.visible = false
	self.visible = true

func _on_novo_pressed() -> void:
	difc_node.visible = true

func _on_sair_pressed() -> void:
	get_tree().quit()

func _on_facil_pressed() -> void:
	novo_jogo(26)

func _on_medio_pressed() -> void:
	novo_jogo(40)

func _on_dificil_pressed() -> void:
	novo_jogo(52)
