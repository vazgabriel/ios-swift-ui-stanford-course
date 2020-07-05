//
//  CardView.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 7/4/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    // Controls bonus remaining time animation
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: .degrees(-90),
                            endAngle: .degrees(-animatedBonusRemaining * 360 - 90)
                        )
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(
                            startAngle: .degrees(-90),
                            endAngle: .degrees(-card.bonusRemaining * 360 - 90)
                        )
                    }
                }
                    .padding(5)
                    .opacity(0.4)
                    .transition(.identity)
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched
                        ? Animation.linear(duration: 1).repeatForever(autoreverses: false)
                        : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
