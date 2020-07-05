//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/29/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

/*
    "Halloween": ["👻", "🎃", "🕷", "💀", "👽"],
    "Faces":     ["😀", "😛", "😂", "🥰", "🤩"],
    "Hands":     ["🖖", "👉", "👈", "👊", "💪"],
*/

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        ZStack {
            if !viewModel.gameStarted {
                VStack {
                    Text("Choose a Theme to continue")
                        .font(Font.title)
                    ForEach(EMOJI_GAME_THEMES.keys.sorted(), id: \.self) { theme in
                        MyButton(action: {
                            self.viewModel.startGame(theme)
                        }) {
                            VStack{
                                Text(theme)
                                    .foregroundColor(Color.white)
                                    .font(Font.title)
                                Text(EMOJI_GAME_THEMES[theme]!.joined(separator: " "))
                            }
                            .padding()
                        }
                    }
                }
            } else {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                    .padding()
                    .foregroundColor(Color.orange)
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20))
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
            //.aspectRatio(2/3, contentMode: ContentMode.fit)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct MyButton<Content: View>: View {
    var action: () -> Void
    var cornerRadius: CGFloat = 100
    var content: () -> Content

    var body: some View {
        Button(action: self.action) {
            content()
        }
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.red]),
                        startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        )
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.startGame("Halloween")
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
