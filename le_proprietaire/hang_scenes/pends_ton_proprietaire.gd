extends Control


signal finally_hang

func _on_container_pendaison() -> void:
	$Pends/PendsTimer.start()


func _on_pends_timer_timeout() -> void:
	$Pends.visible = true
	$Ton/TonTimer.start()


func _on_ton_timer_timeout() -> void:
	$Ton.visible = true
	$"Propriétaire/PropriétaireTimer".start()


func _on_propriétaire_timer_timeout() -> void:
	$"Propriétaire".visible = true
	$EndTimer.start()
	

func _on_end_timer_timeout() -> void:
	visible = false
	finally_hang.emit()
