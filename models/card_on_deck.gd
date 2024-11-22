extends Resource

class_name CardOnDeck

enum CardStatus {ACTIVE, DISCARD}

@export var card : Card
@export var card_status : CardStatus = CardStatus.ACTIVE
