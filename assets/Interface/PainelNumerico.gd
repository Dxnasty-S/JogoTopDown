extends Popup

var combinacao = []
var tentativa = []

onready var display = $VBoxContainer/DisplayContainer/Display
onready var luz = $VBoxContainer/BotoesContainer/GridContainer/Luz

signal combinacao_correta

func _ready():
	conectar_botoes()
	
func conectar_botoes():
	for filho in $VBoxContainer/BotoesContainer/GridContainer.get_children():
		if filho is Button:
			filho.connect("pressed", self, "botao_pressionado", [filho.text])

func botao_pressionado(botao):
	if botao == "OK":
		checar_tentativa()
	else:
		inserir(int(botao))


func checar_tentativa():
	if tentativa == combinacao:
		$AudioStreamPlayer2D.stream = load("res://Assets/SFX/threeTone1.ogg")
		luz.texture = load("res://Assets/GFX/Interface/PNG/dotGreen.png")
		$Timer.start()
	else:
		reiniciar_trava()

func inserir(botao):
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/twoTone1.ogg")
	$AudioStreamPlayer2D.play()
	tentativa.append(botao)
	atualizar_display()

func atualizar_display():
	display.text = PoolStringArray(tentativa).join("")
	if tentativa.size() == combinacao.size():
		checar_tentativa()

func reiniciar_trava():
	luz.texture = load("res://Assets/GFX/Interface/PNG/dotRed.png")
	display.text = ""
	tentativa.clear()

func _on_Timer_timeout():
	emit_signal("combinacao_correta")
	reiniciar_trava()
