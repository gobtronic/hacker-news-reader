//
//  StringExtension.swift
//  hnreader
//
//  Created by gobtronic on 07/04/2023.
//

import Foundation

extension String {
    enum Length {
        case short
        case regular
        case long
        case extraLong
    }
    
    static func random(length: Length = .regular) -> String {
        let chars = "abcdefghijklmnop "
        let nbChars: Int
        switch length {
        case .short:
            nbChars = Int.random(in: 8..<16)
        case .regular:
            nbChars = Int.random(in: 25..<40)
        case .long:
            nbChars = Int.random(in: 80..<120)
        case .extraLong:
            nbChars = Int.random(in: 150..<220)
        }
        
        return String(
            (0..<nbChars).map{ _ in chars.randomElement()! }
        )
    }
}
