extends "res://assets/Scripts/PersonagemBase.gd"


const TOLERANCIA_FOV = 20

const VERMELHO = Color(1, 0.25, 0.25)
const BRANCO = Color(1, 1, 1)

const ALCANCE_MAXIMO_DE_DETECCAO = 640

var Jogador

func _ready():
	Jogador = get_node("/root").find_node("PlasticSnake", true, false)
	
func _process(delta):
	if JogadorNoCampoDeVisao():
		$Lanterna.color = VERMELHO
	else:
		$Lanterna.color = BRANCO	
	
func JogadorNoCampoDeVisao():
	var DirecaoDoNPC = Vector2(1,0).rotated(global_rotation)
	var DirecaoAteOJogador = (Jogador.position - global_position).normalized()
	
	if (DirecaoAteOJogador.angle_to(DirecaoDoNPC)) < deg2rad(TOLERANCIA_FOV):
		return true	
	else:
		return false
		
func JogadorNaLinhaDeVisao():
	var AreaDoJogo = get_world_2d().direct_space_state
	var ObstaculoNaLinhaDeVisao = AreaDoJogo.intersect_ray(global_position, Jogador.global_position, [self], collision_mask)
	
	if not ObstaculoNaLinhaDeVisao:
		return false
		
	var DistanciaAteOJogador = Jogador.global_position.distance_to(global_position)
	var JogadorNoAlcance = DistanciaAteOJogador <ALCANCE_MAXIMO_DE_DETECCAO
	
	if (ObstaculoNaLinhaDeVisao.collider == Jogador and JogadorNoAlcance):
		 return true
	else:
		return false
