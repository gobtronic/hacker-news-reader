//
//  Story.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import Foundation

struct Story: Identifiable, Codable {
    public enum SType: String {
        case story
    }

    var id: Int
    var by: String
    let title: String
    let type: SType
    let url: URL?
    let score: Int
    let time: Double
    let kids: [Int]
    @DecodableBool var isMocked: Bool = false
}

extension Story.SType: Codable {}

extension Story {
    static func mocked() -> Story {
        return Story(id: Int.random(in: 0..<Int.max),
                     by: String.random(),
                     title: String.random(length: .long),
                     type: .story,
                     url: URL(string: "https://developer.apple.com/documentation/linkpresentation"),
                     score: 0,
                     time: 0,
                     kids: [],
                     isMocked: true)
    }
    
    static func mockedList(nbItems: Int) -> [Story] {
        var items = [Story]()
        for _ in 0...nbItems {
            items.append(Story.mocked())
        }
        return items
    }
}
