extends PanelContainer

signal close_button_pressed

enum  ShopSection {BUY, SELL}

var current_section

func _ready() -> void:
	var card_scene = preload("res://scenes/card.tscn")
	for card in GlobalVariabel.card_shop:
		var card_scene_instance = card_scene.instantiate()
		card_scene_instance.card = card
		%ListCardShop.add_child(card_scene_instance)
	update_card_deck()
	update_shop_section(ShopSection.BUY)
	GlobalVariabel.connect("update_card_deck", update_card_deck)


func _on_close_button_pressed() -> void:
	emit_signal("close_button_pressed")


func _on_buy_section_button_pressed() -> void:
	update_shop_section(ShopSection.BUY)
	
	
func update_shop_section(shop_section : ShopSection):
	if current_section != shop_section:
		current_section = shop_section
		var stylbox = StyleBoxFlat.new()
		stylbox.bg_color = Color("8e8e8e")
		if current_section == ShopSection.BUY:
			%BuySectionButton.remove_theme_stylebox_override("normal")
			%SellSectionButton.add_theme_stylebox_override("normal", stylbox)
			%ListCardShop.show()
			%ListCardUser.hide()
		else:
			%BuySectionButton.add_theme_stylebox_override("normal", stylbox)
			%SellSectionButton.remove_theme_stylebox_override("normal")
			%ListCardShop.hide()
			%ListCardUser.show()


func _on_sell_section_button_pressed() -> void:
	update_shop_section(ShopSection.SELL)

func update_card_deck():
	for child in %ListCardUser.get_children():
		child.queue_free()
	var card_on_deck_scene = preload("res://scenes/card_on_deck.tscn")
	for card in GlobalVariabel.active_card_deck:
		var card_on_deck_scene_instance = card_on_deck_scene.instantiate()
		card_on_deck_scene_instance.card_on_deck = card
		card_on_deck_scene_instance.at_shop = true
		%ListCardUser.add_child(card_on_deck_scene_instance)
	for card in GlobalVariabel.discard_card_deck:
		var card_on_deck_scene_instance = card_on_deck_scene.instantiate()
		card_on_deck_scene_instance.card_on_deck = card
		card_on_deck_scene_instance.at_shop = true
		%ListCardUser.add_child(card_on_deck_scene_instance)
