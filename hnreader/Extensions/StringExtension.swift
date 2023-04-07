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
        let chars = "0123456789"
        let nbChars: Int
        switch length {
        case .short:
            nbChars = Int.random(in: 4..<10)
        case .regular:
            nbChars = Int.random(in: 12..<20)
        case .long:
            nbChars = Int.random(in: 30..<50)
        case .extraLong:
            nbChars = Int.random(in: 150..<220)
        }
        
        return String(
            (0..<nbChars).map{ _ in chars.randomElement()! }
        )
    }
}
