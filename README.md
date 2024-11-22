# Programming Test - Deck System Management (Godot)
For technical test assessment

## Card Deck Management System

This application is used to manage a card deck consisting of active cards, discarded cards, and cards available in the shop. The system allows players to buy, sell, and discard cards, and updates the deck display when these actions are performed.

---

## Installation

1. **Ensure you have downloaded and installed Godot Engine version 4.3.**
2. **Download or clone this repository to your project directory.**
3. **Run the project using Godot Engine.**

---

## Main Components

### 1. Button to Show Deck Modal
   - A button used to display the modal containing the cards in the deck, including sections like ALL, ACTIVE, and DISCARD.

### 2. Button to Show Shop Modal
   - A button used to display the modal showing cards available for purchase in the shop.

### 3. Card Component
   - The component representing individual cards in the deck, each with a specific ID, name, and status (ACTIVE or DISCARD).

### 4. Deck Modal Component
   - A modal used to display the cards in the deck. The cards can be filtered into sections (ALL, ACTIVE, DISCARD), and actions like selling or discarding can be performed here.

### 5. Shop Modal Component
   - A modal displaying the available cards in the shop. Players can purchase cards from here to add to their active deck.

---

## Usage Instructions

1. **Displaying the Deck:**
   - Press the button to choose the deck section (ALL, ACTIVE, DISCARD). This will show the deck modal with cards based on the selected section.

2. **Displaying the Shop:**
   - Press the button to open the shop modal. This will display a list of cards available for purchase.

3. **Buying a Card:**
   - In the shop modal, select the card you wish to purchase and press the button to buy it. The card will then be added to your active deck.

4. **Discarding a Card:**
   - Select a card from the active deck and press the button to discard it. The card will move to the discard pile and be removed from the active deck.

5. **Selling a Card:**
   - Select a card from the active deck and press the button to sell it. The card will be removed from the active deck.

---

## Global Variables

The system utilizes **global variables** to store data about the deck and shop cards. These global variables allow for easy management and access across different components in the game, ensuring that the card data remains consistent and synchronized.

- **`active_card_deck`**: Stores the cards currently in the active deck.
- **`discard_card_deck`**: Stores the cards that have been discarded.
- **`card_shop`**: Stores the cards available for purchase in the shop.
