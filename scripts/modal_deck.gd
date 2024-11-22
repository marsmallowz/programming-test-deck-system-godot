extends PanelContainer

signal close_button_pressed

enum DeckSection {ALL, ACTIVE, DISCARD}

var current_section 

func _ready() -> void:
	update_deck_section(DeckSection.ALL)
	update_card_deck()
	GlobalVariabel.connect("update_card_deck", update_card_deck)

func _on_close_button_pressed() -> void:
	emit_signal("close_button_pressed")


func update_deck_section(deck_section: DeckSection):
	if current_section != deck_section:
		current_section = deck_section
		var stylbox = StyleBoxFlat.new()
		stylbox.bg_color = Color("8e8e8e")
		if current_section == DeckSection.ALL:
			%AllSectionButton.remove_theme_stylebox_override("normal")
			%ActiveSectionButton.add_theme_stylebox_override("normal", stylbox)
			%DiscardSectionButton.add_theme_stylebox_override("normal", stylbox)
			%ListActiveCard.show()
			%ListDiscardCard.show()
		elif current_section == DeckSection.ACTIVE:
			%AllSectionButton.add_theme_stylebox_override("normal", stylbox)
			%ActiveSectionButton.remove_theme_stylebox_override("normal")
			%DiscardSectionButton.add_theme_stylebox_override("normal", stylbox)
			%ListActiveCard.show()
			%ListDiscardCard.hide()
		else:
			%AllSectionButton.add_theme_stylebox_override("normal", stylbox)
			%ActiveSectionButton.add_theme_stylebox_override("normal", stylbox)
			%DiscardSectionButton.remove_theme_stylebox_override("normal")
			%ListActiveCard.hide()
			%ListDiscardCard.show()


func _on_all_section_button_pressed() -> void:
	update_deck_section(DeckSection.ALL)


func _on_active_section_button_pressed() -> void:
	update_deck_section(DeckSection.ACTIVE)


func _on_discard_section_button_pressed() -> void:
	update_deck_section(DeckSection.DISCARD)

func update_card_deck():
	var card_on_deck_scene = preload("res://scenes/card_on_deck.tscn")
	
	for child in %CardActiveContainer.get_children():
		child.queue_free()
	for child in %CardDiscardContainer.get_children():
		child.queue_free()
	
	for data in GlobalVariabel.active_card_deck:
		var card_on_deck_scene_instance = card_on_deck_scene.instantiate()
		card_on_deck_scene_instance.card_on_deck = data
		card_on_deck_scene_instance.at_shop = false
		%CardActiveContainer.add_child(card_on_deck_scene_instance)
	for data in GlobalVariabel.discard_card_deck:
		var card_on_deck_scene_instance = card_on_deck_scene.instantiate()
		card_on_deck_scene_instance.card_on_deck = data
		card_on_deck_scene_instance.at_shop = false
		%CardDiscardContainer.add_child(card_on_deck_scene_instance)
