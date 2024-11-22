extends PanelContainer

# Sinyal yang dipancarkan ketika tombol "Close" ditekan
signal close_button_pressed

enum  ShopSection {BUY, SELL}
var card_scene = preload("res://scenes/card.tscn")

var current_section

func _ready() -> void:
	# Inisialisasi kartu pada shop
	_populate_shop_cards()
	
	# Perbarui tampilan awal
	update_card_deck()
	update_shop_section(ShopSection.BUY)
	
	# Sambungkan sinyal untuk pembaruan deck
	GlobalVariabel.connect("update_card_deck", update_card_deck)

# Fungsi untuk mengisi kartu ke dalam ListCardShop
func _populate_shop_cards() -> void:
	for card in GlobalVariabel.card_shop:
		var card_scene_instance = card_scene.instantiate()
		card_scene_instance.card = card
		%ListCardShop.add_child(card_scene_instance)


# Fungsi yang dipanggil ketika tombol "Close" ditekan.
# Fungsi ini memancarkan sinyal "close_button_pressed", memungkinkan node lain menangani event ini.
func _on_close_button_pressed() -> void:
	emit_signal("close_button_pressed")


# Fungsi yang dipanggil ketika tombol "Buy Section" ditekan.
# Fungsi ini mengganti tampilan shop ke bagian pembelian (BUY).
func _on_buy_section_button_pressed() -> void:
	update_shop_section(ShopSection.BUY)


# Fungsi yang dipanggil ketika tombol "Sell Section" ditekan.
# Fungsi ini mengganti tampilan shop ke bagian penjualan (SELL).
func _on_sell_section_button_pressed() -> void:
	update_shop_section(ShopSection.SELL)


# Fungsi untuk memperbaruhi section shop
func update_shop_section(shop_section: ShopSection):
	# Periksa apakah perlu mengganti section
	if current_section == shop_section:
		return
	
	current_section = shop_section
	var stylebox = _create_highlight_stylebox()

	# Perbarui tampilan berdasarkan section yang dipilih
	match current_section:
		ShopSection.BUY:
			_set_button_styles(%BuySectionButton, %SellSectionButton, stylebox)
			_toggle_section_visibility(%ListCardShop, %ListCardUser, true)
		ShopSection.SELL:
			_set_button_styles(%SellSectionButton, %BuySectionButton, stylebox)
			_toggle_section_visibility(%ListCardUser, %ListCardShop, true)

# Fungsi untuk membuat stylebox dengan warna tertentu
func _create_highlight_stylebox() -> StyleBoxFlat:
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color("8e8e8e")
	return stylebox

# Fungsi untuk mengatur stylebox override pada tombol
func _set_button_styles(active_button, inactive_button, stylebox):
	active_button.remove_theme_stylebox_override("normal")
	inactive_button.add_theme_stylebox_override("normal", stylebox)

# Fungsi untuk mengatur visibilitas section
func _toggle_section_visibility(show_section, hide_section, show):
	show_section.visible = show
	hide_section.visible = !show


# Fungsi untuk memperbarui daftar kartu
func update_card_deck():
	# Hapus semua children di ListCardUser
	for child in %ListCardUser.get_children():
		child.queue_free()
	
	# Tambahkan kartu dari active_card_deck dan discard_card_deck
	_add_cards_to_list(GlobalVariabel.active_card_deck)
	_add_cards_to_list(GlobalVariabel.discard_card_deck)

# Fungsi untuk menambahkan kartu ke ListCardUser
func _add_cards_to_list(card_deck):
	for card in card_deck:
		var card_on_deck_instance = card_scene.instantiate()
		card_on_deck_instance.card = card
		card_on_deck_instance.at_shop = true
		%ListCardUser.add_child(card_on_deck_instance)
