//
//  SelectThemeView.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 7/4/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

// Show all possible themes to use in the game, and create a Navigation View
struct SelectThemeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose a Theme to continue")
                    .font(.title)
                ForEach(EMOJI_GAME_THEMES.keys.sorted(), id: \.self) { theme in
                    MyButton(
                        destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(), theme: theme)) {
                        VStack{
                            Text(theme)
                            Text(EMOJI_GAME_THEMES[theme]?.joined(separator: " ") ?? "")
                        }
                    }
                }
            }
        }
    }
}

struct MyButton<Label: View, Destination: View>: View {
    var destination: Destination
    var cornerRadius: CGFloat = 100
    var content: () -> Label

    var body: some View {
        NavigationLink(destination: destination) {
            content()
                .padding(10) // Internal padding for the content
        }
            .frame(maxWidth: .infinity) // Make the button full width
            .background( // Create a nice linear gradient button background (and rounded)
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.red]),
                            startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            )
            .foregroundColor(.white) // Text color white
            .font(.title) // Big Font
            .padding() // Padding between buttons
    }
}

struct SelectThemeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectThemeView()
    }
}
