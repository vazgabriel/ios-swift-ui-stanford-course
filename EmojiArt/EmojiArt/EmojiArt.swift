//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Gabriel de Carvalho on 7/9/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import Foundation

struct EmojiArt {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable {
        let id: Int
        let text: String

        // 0, 0 = center
        var x: Int
        var y: Int
        var size: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}
