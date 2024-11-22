extends Button

var card_on_deck : CardOnDeck
var at_shop = false

func _ready() -> void:
	if at_shop:
		%DiscardButton.hide()
		%SellButton.show()
	else:
		%DiscardButton.show()
		%SellButton.hide()
	if card_on_deck != null:
		text = card_on_deck.card.card_name
		if card_on_deck.card_status == CardOnDeck.CardStatus.DISCARD:
			%DiscardButton.hide()
			%SellButton.hide()
			disconnect("mouse_entered", _on_mouse_entered)
			disconnect("mouse_exited", _on_mouse_exited)
			var stylbox = StyleBoxFlat.new()
			stylbox.bg_color = Color("8e8e8e")
			add_theme_stylebox_override("normal", stylbox)


func _on_mouse_entered() -> void:
	%HoverModal.show()


func _on_mouse_exited() -> void:
	if is_instance_valid(self): # Memastikan node masih valid
		var hover_modal = get_node_or_null("%HoverModal")
		if hover_modal:
			hover_modal.hide()


func _on_discard_button_pressed() -> void:
	var index = get_index()
	GlobalVariabel.discard_card(index, card_on_deck)


func _on_sell_button_pressed() -> void:
	var index = get_index()
	GlobalVariabel.sell_card(index)
