extends Node


@onready var vidas: Node = get_node("interface/vidas")

@onready var completos: Node = get_node("interface/completos")

@onready var menu_node: Node = get_node("../menu")

@onready var nodos_path: String = "Linha%s/Node2D%s%s"

var linhas: Array[Array]
var visibilidade: Array[Array]
var n: int = 0
var srn: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func comeca_jogo(tamanho: int, faltantes: int) -> void:
	inicia_arrays()
	vidas.carrega_vidas()
	inicia_tabuleiro(tamanho, faltantes)
	popula_nodos()
	checa_completos()

func inicia_arrays() -> void:
	linhas = [
		[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]
	]
	visibilidade = [
		[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],
		[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],
		[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1]
	]

func inicia_tabuleiro(tamanho: int, k: int) -> void:
	n = tamanho
	srn = sqrt(tamanho)
	preenche_valores(k)
	
func preenche_valores(k: int) -> void:
	preenche_diagonal()
	preenche_resto(0, srn)
	removeDigitos(k);
	
func preenche_diagonal() -> void:
	for i in range(0, n, srn):
		preenche_caixa(i, i)

func preenche_caixa(linha:int, coluna: int) -> void:
	var num: int = 0
	
	for i in srn:
		for j in srn:
			while not valido_caixa(linha, coluna, num):
				num = gerador_aleatorio(n)
			
			linhas[linha+i][coluna+j] = num

func valido_linha(i: int, num: int) -> bool:
	for j in n:
		if (linhas[i][j] == num):
			return false
	return true

func valido_coluna(j: int, num: int) -> bool:
	for i in n:
		if linhas[i][j] == num:
			return false
	return true

func valido_caixa(linha: int, coluna: int, num: int) -> bool:
	for i in srn:
		for j in srn:
			if linhas[linha+i][coluna+j]==num:
				return false
	return true

func gerador_aleatorio(num: int) -> int:
	return floor(randi()%num+1)

func preenche_resto(i: int, j: int) -> bool:
	if j >= n and i < n-1:
		i = i+1
		j = 0
	
	if i>=n and j>=n:
		return true
	
	if i<srn:
		if j<srn:
			j = srn
	elif i< n-srn:
		var isrn: int = (i/srn)*srn
		if j==isrn:
			j = j+srn
	else:
		if j == n-srn:
			i = i+1
			j = 0
			if i>=n:
				return true
	
	for num in range(1, n+1):
		if is_seguro(i, j, num):
			linhas[i][j] = num
			if preenche_resto(i, j+1):
				return true
			
			linhas[i][j] = 0
	
	return false

func is_seguro(i: int, j: int, num: int) -> bool:
	return valido_linha(i, num) and valido_coluna(j, num) and valido_caixa(i-i%srn, j-j%srn, num)

func removeDigitos(k: int) -> void:
	var cont: int = k
	while cont > 0:
		var celula = gerador_aleatorio(n*n)-1;
		
		var i: int = celula/n
		var j: int = celula%n
		
		if visibilidade[i][j] != 0:
			cont=cont-1
			visibilidade[i][j] = 0

func popula_nodos() -> void:
	for i in 9:
		for j in 9:
			var caminho_nodo: String = nodos_path % [(i+1), (i+1), (j+1)]
			var nodo: Node = get_node(caminho_nodo)
			var vizinhos: Array[NodePath] = get_vizinhos(i, j)
			var sequencia: Array[NodePath] = get_sequencia(i, j)
			nodo.carregar_nodo(linhas[i][j], visibilidade[i][j], vizinhos, sequencia, self)

func get_vizinhos(i: int, j: int) -> Array[NodePath]:
	var ver: int = i+1
	var hor: int = j+1
	
	var indEsq: int = j if j>0 else 9
	var indDir: int = hor+1 if hor<9 else 1
	var indTop: int = i if i>0 else 9
	var indBot: int = ver+1 if ver<9 else 1
	
	var caminho_esq: String = nodos_path % [ver, ver, indEsq]
	var caminho_dir: String = nodos_path % [ver, ver, indDir]
	var caminho_top: String = nodos_path % [indTop, indTop, hor]
	var caminho_bot: String = nodos_path % [indBot, indBot, hor]
	
	var esqNode: NodePath = get_node(caminho_esq).get_estado()
	var dirNode: NodePath = get_node(caminho_dir).get_estado()
	var topNode: NodePath = get_node(caminho_top).get_estado()
	var botNode: NodePath = get_node(caminho_bot).get_estado()
	
	return [esqNode, dirNode, topNode, botNode]

func get_sequencia(i: int, j: int) -> Array[NodePath]:
	
	var indVerAnt: int = i+1
	var indVerPrx: int = i+1
	var indAnt: int = j
	var indPrx: int = j+2
	
	if j==0:
		indVerAnt = indVerAnt-1 if i>0 else 9
		indAnt = 9
	elif j==8:
		indVerPrx = indVerPrx+1 if i<8 else 1
		indPrx = 1
	
	var caminho_ant: String = nodos_path % [indVerAnt, indVerAnt, indAnt]
	var caminho_prx: String = nodos_path % [indVerPrx, indVerPrx, indPrx]
	
	var ant_node: NodePath = get_node(caminho_ant).get_estado()
	var prx_node: NodePath = get_node(caminho_prx).get_estado()
	
	return [ant_node, prx_node]

func game_over() -> void:
	menu_node.esconde_jogo()

func vitoria() -> void:
	menu_node.esconde_jogo()

func carrega_vidas() -> void:
	vidas.carrega_vidas()

func dano() -> void:
	vidas.dano()
	if vidas.get_vidas() < 1:
		game_over()

func acerto(i: int) -> void:
	completos.add_certo(i-1)
	if completos.checa_completo(i-1):
		completos.set_completo(i-1)
		if completos.checa_terminado():
			vitoria()

func checa_completos() -> void:
	for i in 9:
		for j in 9:
			if visibilidade[i][j] == 1:
				completos.add_certo(linhas[i][j]-1)
