//
//  DecodableBool.swift
//  hnreader
//
//  Created by gobtronic on 07/04/2023.
//

import Foundation

@propertyWrapper
struct DecodableBool {
    var wrappedValue = false
}

extension DecodableBool: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Bool.self)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: DecodableBool.Type,
                forKey key: Key) throws -> DecodableBool {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}
