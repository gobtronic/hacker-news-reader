//
//  URLExtension.swift
//  hnreader
//
//  Created by gobtronic on 09/04/2023.
//

import Foundation

extension URL {
    var simplifiedString: String {
        return self.host()?.replacingOccurrences(of: "www.", with: "") ?? absoluteString
    }
}
