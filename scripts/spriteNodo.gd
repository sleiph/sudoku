extends Sprite2D


var tex_path: String = "res://sprites/%s.png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func preenche(n: int, v: int) -> void:
	var caminho_imagem: String = tex_path % n
	var tex: Resource = load(caminho_imagem)
	self.texture = tex
	set_visivel(v)

func limpa() -> void:
	self.texture = null;

func set_visivel(valor: bool) -> void:
	self.visible = valor
