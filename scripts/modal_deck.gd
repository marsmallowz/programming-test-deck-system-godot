extends PanelContainer

# Sinyal yang dipancarkan ketika tombol "Close" ditekan
signal close_button_pressed

var card_scene = preload("res://scenes/card.tscn")

enum DeckSection {ALL, ACTIVE, DISCARD}

var current_section

# Fungsi yang dijalankan saat node di-ready
func _ready() -> void:
	# Inisialisasi bagian deck ke "ALL"
	update_deck_section(DeckSection.ALL)
	# Memperbarui tampilan kartu pada deck
	update_card_deck()
	# Menghubungkan sinyal untuk pembaruan deck
	GlobalVariabel.connect("update_card_deck", update_card_deck)

# Fungsi yang dipanggil ketika tombol "Close" ditekan
func _on_close_button_pressed() -> void:
	emit_signal("close_button_pressed")

# Fungsi untuk memperbarui tampilan berdasarkan bagian deck yang dipilih
func update_deck_section(deck_section: DeckSection):
	if current_section != deck_section:
		current_section = deck_section
		
		# StyleBox untuk menandai tombol aktif
		var stylbox = StyleBoxFlat.new()
		stylbox.bg_color = Color("8e8e8e")
		
		# Perubahan tampilan berdasarkan bagian deck yang aktif
		match current_section:
			DeckSection.ALL:
				_set_button_styles(%AllSectionButton, %ActiveSectionButton, %DiscardSectionButton, stylbox)
				%ListActiveCard.show()
				%ListDiscardCard.show()
			DeckSection.ACTIVE:
				_set_button_styles(%ActiveSectionButton, %AllSectionButton, %DiscardSectionButton, stylbox)
				%ListActiveCard.show()
				%ListDiscardCard.hide()
			DeckSection.DISCARD:
				_set_button_styles(%DiscardSectionButton, %AllSectionButton, %ActiveSectionButton, stylbox)
				%ListActiveCard.hide()
				%ListDiscardCard.show()

# Fungsi untuk menangani tombol "All Section"
func _on_all_section_button_pressed() -> void:
	update_deck_section(DeckSection.ALL)

# Fungsi untuk menangani tombol "Active Section"
func _on_active_section_button_pressed() -> void:
	update_deck_section(DeckSection.ACTIVE)

# Fungsi untuk menangani tombol "Discard Section"
func _on_discard_section_button_pressed() -> void:
	update_deck_section(DeckSection.DISCARD)

# Fungsi untuk memperbarui tampilan kartu pada container deck
func update_card_deck():
	# Menghapus semua kartu dari container aktif dan discard
	_clear_container(%CardActiveContainer)
	_clear_container(%CardDiscardContainer)
	
	# Menambahkan kartu aktif ke container
	for data in GlobalVariabel.active_card_deck:
		_add_card_to_container(%CardActiveContainer, data, false)
	
	# Menambahkan kartu discard ke container
	for data in GlobalVariabel.discard_card_deck:
		_add_card_to_container(%CardDiscardContainer, data, false)

# Fungsi untuk membersihkan container dari anak-anaknya
func _clear_container(container: Control) -> void:
	for child in container.get_children():
		child.queue_free()

# Fungsi untuk menambahkan kartu ke container tertentu
func _add_card_to_container(container: Control, card_data, at_shop: bool) -> void:
	var card_scene_instance = card_scene.instantiate()
	card_scene_instance.card = card_data
	card_scene_instance.at_shop = at_shop
	container.add_child(card_scene_instance)

# Fungsi untuk mengatur style tombol berdasarkan bagian yang aktif
func _set_button_styles(active_button, button1, button2, stylbox: StyleBoxFlat) -> void:
	active_button.remove_theme_stylebox_override("normal")
	button1.add_theme_stylebox_override("normal", stylbox)
	button2.add_theme_stylebox_override("normal", stylbox)
