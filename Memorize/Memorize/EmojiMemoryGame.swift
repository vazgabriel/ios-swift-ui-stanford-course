//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/29/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

let pairsOfCards = 6

// Themes for game (it's necessary to have 6 pairs of card or changing pairsOfCards )
let EMOJI_GAME_THEMES: [String:Array<String>] = [
    "Halloween": ["👻", "🎃", "🕷", "💀", "👽", "🧛"],
    "Faces": ["😀", "😛", "😂", "🥰", "🤩", "🥺"],
    "Hands": ["🖖", "👉", "👈", "👊", "💪", "👌"],
]

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = MemoryGame<String>()

    // MARK: - Access to the Model

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func startGame(_ theme: String) {
        if let emojis = EMOJI_GAME_THEMES[theme] {
            self.model.startGame(numberOfPairsOfCards: pairsOfCards) { i in emojis[i] }
        }
    }
}
