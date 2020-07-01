//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/29/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "💀", "👽"]
        let pairs = Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: pairs) { i in emojis[i] }
    }
    
    init() {
        model.cards.shuffle()
    }

    // MARK: - Access to the Model

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
