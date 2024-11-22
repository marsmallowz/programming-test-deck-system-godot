extends Node

signal update_card_deck

var list_card : ListCard = preload("res://resources/list_card.tres")
var active_card_deck : Array[CardOnDeck]
var discard_card_deck : Array[CardOnDeck]
var card_shop : Array[Card]

func _ready() -> void:
	card_shop = list_card.data
	var total_active_card = 17
	var total_discard_card = 3
	for i in total_active_card:
		var new_card_on_deck = CardOnDeck.new()
		new_card_on_deck.card = list_card.data[randi() % list_card.data.size()]
		active_card_deck.append(new_card_on_deck)
	for i in total_discard_card:
		var new_card_on_deck = CardOnDeck.new()
		new_card_on_deck.card = list_card.data[randi() % list_card.data.size()]
		new_card_on_deck.card_status = CardOnDeck.CardStatus.DISCARD
		discard_card_deck.append(new_card_on_deck)


func sell_card(index: int):
	active_card_deck.remove_at(index)
	emit_signal("update_card_deck")

func buy_card(card: Card):
	var card_on_deck = CardOnDeck.new()
	card_on_deck.card = card
	active_card_deck.append(card_on_deck)
	emit_signal("update_card_deck")

func discard_card(index, card: CardOnDeck):
	var new_card = card
	new_card.card_status = CardOnDeck.CardStatus.DISCARD
	discard_card_deck.append(card)
	active_card_deck.remove_at(index)
	emit_signal("update_card_deck")
