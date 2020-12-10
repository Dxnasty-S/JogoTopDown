extends Node

func gerar_combinacao(tamanho):
	var combinacao = []
	for numero in range(tamanho):

		combinacao.append(randi() % 10)
	return combinacao
