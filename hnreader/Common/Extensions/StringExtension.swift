//
//  StringExtension.swift
//  hnreader
//
//  Created by gobtronic on 07/04/2023.
//

import Foundation
import SwiftUI

extension String {
    var asHtmlAttributedString: AttributedString {
        var attributedString: AttributedString
        if let stringData = self.data(using: .utf8),
           let nsAttributedString = try? NSAttributedString(data: stringData,
                                                            options: [.documentType: NSAttributedString.DocumentType.html],
                                                            documentAttributes: nil) {
            attributedString = AttributedString(nsAttributedString)
        } else {
            attributedString = AttributedString(NSAttributedString(string: self))
        }
        
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute.self] = .primary
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = Font.system(.body)
        attributedString.mergeAttributes(container, mergePolicy: .keepNew)
        
        return attributedString
    }
}

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
