extends Control


func _on_modal_deck_close_button_pressed() -> void:
	$ModalDeck.hide()


func _on_deck_button_pressed() -> void:
	$ModalDeck.show()


func _on_buy_and_sell_pressed() -> void:
	$ModalShop.show()


func _on_modal_shop_close_button_pressed() -> void:
	$ModalShop.hide()
