extends Button

var card : Card

func _ready() -> void:
	if card != null:
		text = card.card_name


func _on_mouse_entered() -> void:
	%HoverModal.show()


func _on_mouse_exited() -> void:
	%HoverModal.hide()


func _on_buy_button_pressed() -> void:
	GlobalVariabel.buy_card(card)
