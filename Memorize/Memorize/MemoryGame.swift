//
//  MemoryGame.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/29/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import Foundation

let scorePerPair = 2
let scorePerPairAfterSeen = 1

struct MemoryGame<CardContent: Equatable> {
    private(set) var score: Int = 0
    private(set) var cards = Array<Card>()
    
    private var indexFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for i in cards.indices {
                cards[i].isFaceUp = i == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        // Check if it's clicking on a unclicked and unmatched card
        if let chosenIndex = self.cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            // Check if there's already a faced up card
            if let potentialMatchIndex = indexFaceUpCard {
                // Check if it's a successfully match
                if self.cards[chosenIndex].content == self.cards[potentialMatchIndex].content {
                    self.cards[chosenIndex].isMatched = true
                    self.cards[potentialMatchIndex].isMatched = true
                    
                    // Add score according with seen rule
                    self.score += self.cards[potentialMatchIndex].alreadySeen
                        ? scorePerPairAfterSeen
                        : scorePerPair
                }

                // Face up and mark cards as seen
                self.cards[chosenIndex].isFaceUp = true
                self.see([self.cards[chosenIndex].content, self.cards[potentialMatchIndex].content])
            } else {
                self.indexFaceUpCard = chosenIndex
            }
        } else if let chosenIndex = self.cards.firstIndex(matching: card), chosenIndex == indexFaceUpCard {
            // Check if it's clicking on the same card already facing up
            self.cards[chosenIndex].isFaceUp = false
            self.see([self.cards[chosenIndex].content])
        }
    }
    
    // Start game reset score and cards, and shuffle them
    mutating func startGame(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        score = 0
        cards = Array<Card>()

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    // Mark content as seen in order to give less score
    mutating func see(_ contents: Array<CardContent>) {
        for content in contents {
            for i in cards.indices {
                if cards[i].content == content {
                    cards[i].alreadySeen = true
                }
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                // Start using bonus time when card is setted face up
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }

        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }

        var alreadySeen: Bool = false
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            return pastFaceUpTime
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e not including the current time it's been face up if is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit, faceUpTime)
        }

        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // wheter the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // wheter we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
