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
    let id: Int
    let by: String
    let title: String
    let type: Kind
    let descendants: Int
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
                     by: String.random(length: .short),
                     title: String.random(length: .long),
                     type: type,
                     descendants: 86,
                     url: URL(string: "https://developer.apple.com/documentation/linkpresentation"),
                     score: 123,
                     time: 0,
                     kids: [],
                     isMocked: true)
    }
    
    static func realMocked() -> Story {
        return Story(id: 8863,
                     by: "dhouston",
                     title: "My YC app: Dropbox - Throw away your USB drive",
                     type: .story,
                     descendants: 71,
                     url: URL(string: "http://www.getdropbox.com/u/2/screencast.html"),
                     score: 104,
                     time: 1175714200,
                     kids: [
                        9224,
                        8917,
                        8952,
                        8958,
                        8884,
                        8887,
                        8869,
                        8873,
                        8940,
                        8908,
                        9005,
                        9671,
                        9067,
                        9055,
                        8865,
                        8881,
                        8872,
                        8955,
                        10403,
                        8903,
                        8928,
                        9125,
                        8998,
                        8901,
                        8902,
                        8907,
                        8894,
                        8870,
                        8878,
                        8980,
                        8934,
                        8943,
                        8876
                     ])
    }
    
    static func mockedList(nbItems: Int) -> [Story] {
        var items = [Story]()
        for _ in 0...nbItems {
            items.append(Story.mocked())
        }
        return items
    }
}
