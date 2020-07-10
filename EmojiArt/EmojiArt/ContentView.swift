//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Gabriel de Carvalho on 7/4/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
