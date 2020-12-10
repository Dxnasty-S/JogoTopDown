extends Popup

func definir_texto(combinacao):
	$NinePatchRect/CenterContainer/NinePatchRect/Label.text = ("O seu codigo de aceso é: " +
	PoolStringArray(combinacao).join(""))
