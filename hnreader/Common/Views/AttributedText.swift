//
//  AttributedText.swift
//  hnreader
//
//  Created by gobtronic on 13/04/2023.
//

import SwiftUI

struct AttributedText: View {
    @State private var attributedString: AttributedString?
    var string: String
    var textAlignment: Alignment = .leading
    
    var body: some View {
        if let attributedString {
            Text(attributedString)
                .frame(maxWidth: .infinity, alignment: textAlignment)
        } else {
            Text("")
                .onAppear {
                    DispatchQueue.main.async {
                        attributedString = string.asHtmlAttributedString
                    }
                }
        }
        
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(string: "<p>This is a test</p>")
    }
}
