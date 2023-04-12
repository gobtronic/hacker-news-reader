//
//  Story.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import Foundation
import LinkPresentation
import UIKit

struct Story: Identifiable, Codable {
    var id: Int
    var by: String
    let title: String
    let type: Kind
    let url: URL?
    let score: Int
    let time: Double
    let kids: [Int]?
    
    @DecodableBool var isMocked: Bool = false
    
    // MARK: UrlMetadata
    
    func cachedUrlMetadata() -> UrlMetadata? {
        if let cachedUrlMetadata = UrlMetadata.cached.first(where: { $0.storyId == self.id }),
           cachedUrlMetadata.isLoaded {
            return cachedUrlMetadata
        }
        
        return nil
    }
    
    func generateUrlMetadata() async -> UrlMetadata? {
        return await UrlMetadata.generateFor(story: self)
    }
}

extension Story {
    public enum Kind: String, Codable {
        case story
        case job
    }
}

extension Story {
    static func mocked(type: Kind = .story) -> Story {
        return Story(id: Int.random(in: 0..<Int.max),
                     by: String.random(),
                     title: String.random(length: .long),
                     type: type,
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
