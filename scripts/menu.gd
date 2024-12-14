extends Node


@onready var jogo_node: Node = get_node("../jogo")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_novo_pressed() -> void:
	jogo_node.comeca_jogo(9, 54)
	exibe_jogo()

func _on_sair_pressed() -> void:
	get_tree().quit()

func exibe_jogo() -> void:
	self.visible = false
	jogo_node.visible = true

func esconde_jogo() -> void:
	jogo_node.visible = false
	self.visible = true
