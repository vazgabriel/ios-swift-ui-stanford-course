//
//  MemoryGame.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/29/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    var cards: Array<Card>
    
    var indexFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]()
            for i in cards.indices {
                if cards[i].isFaceUp {
                    faceUpCardIndices.append(i)
                }
            }
            
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            }
            return nil
        }
        set {
            for i in cards.indices {
                if i == newValue {
                    cards[i].isFaceUp = true
                } else {
                    cards[i].isFaceUp = false
                }
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = self.cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexFaceUpCard {
                if self.cards[chosenIndex].content == self.cards[potentialMatchIndex].content {
                    self.cards[chosenIndex].isMatched = true
                    self.cards[potentialMatchIndex].isMatched = true
                }
                self.indexFaceUpCard = nil
            } else {
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
                self.indexFaceUpCard = chosenIndex
            }
            self.cards[chosenIndex].isFaceUp = true
        }
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
