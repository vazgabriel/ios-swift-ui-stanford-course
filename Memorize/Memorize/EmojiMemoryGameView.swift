//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/29/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var theme: String
    
    // Receive the game and a theme
    init(viewModel: EmojiMemoryGame, theme: String) {
        self.viewModel = viewModel
        self.theme = theme
    }

    var body: some View {
        VStack {
            // Display cards
            ZStack {
                Grid(self.viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.6)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(5)
                }
                    .padding()
                    .foregroundColor(.orange)
            }
            // Display user's score
            Text("Score: \(self.viewModel.score)")
                .padding(.bottom)
                .font(.title)
        }
        .onAppear {
            // Whenever it appears, restart the game (because of navigation)
            if EMOJI_GAME_THEMES[self.theme] != nil {
                self.viewModel.startGame(self.theme)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return EmojiMemoryGameView(viewModel: EmojiMemoryGame(), theme: "Halloween")
    }
}
