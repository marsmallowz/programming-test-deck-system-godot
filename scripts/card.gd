extends Button

# Variabel untuk menyimpan data kartu
var card : Variant 
# Menandakan apakah kartu untuk berada di toko
var at_shop = false

func _ready() -> void:
	# Menyembunyikan dan menampilkan tombol sesuai status kartu
	if at_shop:
		%DiscardButton.hide() 
		%SellButton.show()     
	else:
		%DiscardButton.show()  
		%SellButton.hide()   
	
	if card != null:
		text = card.card_name  
		if card is CardOnDeck:
			%BuyButton.hide()  
			if card.card_status == CardOnDeck.CardStatus.DISCARD:
				# Ubah style tombol jika status kartu DISCARD
				var stylbox = StyleBoxFlat.new()
				stylbox.bg_color = Color("8e8e8e")
				add_theme_stylebox_override("normal", stylbox)
				# Nonaktifkan event mouse untuk kartu DISCARD
				disconnect("mouse_entered", _on_mouse_entered)
				disconnect("mouse_exited", _on_mouse_exited)
				%DiscardButton.hide()  
				%SellButton.hide()     

		elif card is Card:
			%DiscardButton.hide() 
			%SellButton.hide()    

# Fungsi yang dijalankan saat mouse masuk ke tombol
func _on_mouse_entered() -> void:
	%HoverModal.show()  

# Fungsi yang dijalankan saat mouse keluar dari tombol
func _on_mouse_exited() -> void:
	if is_instance_valid(self): 
		var hover_modal = get_node_or_null("%HoverModal")  
		if hover_modal:
			hover_modal.hide() 

# Fungsi yang dijalankan saat tombol Discard ditekan
func _on_discard_button_pressed() -> void:
	var index = get_index() 
	GlobalVariabel.discard_card(index, card)  

# Fungsi yang dijalankan saat tombol Sell ditekan
func _on_sell_button_pressed() -> void:
	var index = get_index()  
	GlobalVariabel.sell_card(index) 

# Fungsi yang dijalankan saat tombol Buy ditekan
func _on_buy_button_pressed() -> void:
	GlobalVariabel.buy_card(card)  
