extends Node

signal update_card_deck

# Preload resource list_card
var list_card : ListCard = preload("res://resources/list_card.tres")
# Array untuk menyimpan deck kartu aktif dan kartu discard
var active_card_deck : Array[CardOnDeck]
var discard_card_deck : Array[CardOnDeck]
# Array untuk menyimpan kartu yang tersedia di toko
var card_shop : Array[Card]

# Fungsi yang dijalankan saat node siap
func _ready() -> void:
	card_shop = list_card.data  # Inisialisasi kartu yang ada di toko
	var total_active_card = 17  # Total kartu aktif
	var total_discard_card = 3  # Total kartu discard
	
	# Mengisi deck aktif dengan kartu acak
	for i in range(total_active_card):
		var current_card = list_card.data[randi() % list_card.data.size()]
		var new_card_on_deck = CardOnDeck.new()
		new_card_on_deck.id = current_card.id
		new_card_on_deck.card_name = current_card.card_name
		active_card_deck.append(new_card_on_deck)

	# Mengisi deck discard dengan kartu acak
	for i in range(total_discard_card):
		var current_card = list_card.data[randi() % list_card.data.size()]
		var new_card_on_deck = CardOnDeck.new()
		new_card_on_deck.id = current_card.id
		new_card_on_deck.card_name = current_card.card_name
		new_card_on_deck.card_status = CardOnDeck.CardStatus.DISCARD
		discard_card_deck.append(new_card_on_deck)


# Fungsi untuk menjual kartu berdasarkan index
func sell_card(index: int):
	active_card_deck.remove_at(index)  
	print("Card has been sold")
	emit_signal("update_card_deck") 

# Fungsi untuk membeli kartu dan menambahkannya ke deck aktif
func buy_card(card: Card):
	var card_on_deck = CardOnDeck.new()
	card_on_deck.id = card.id
	card_on_deck.card_name = card.card_name
	active_card_deck.append(card_on_deck)  
	print("Card has been purchased")
	emit_signal("update_card_deck")  

# Fungsi untuk membuang kartu ke deck discard berdasarkan index dan kartu
func discard_card(index, card: CardOnDeck):
	card.card_status = CardOnDeck.CardStatus.DISCARD  
	discard_card_deck.append(card) 
	active_card_deck.remove_at(index) 
	print("Card has been discard")
	emit_signal("update_card_deck") 
