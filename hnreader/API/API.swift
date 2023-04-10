//
//  API.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import Alamofire
import Foundation

struct API {
    static let shared = API()
    private let apiUrl = URL(string: "https://hacker-news.firebaseio.com/v0")!
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Calls
    
    func fetchTopStories(limit: Int? = nil) async throws -> (stories: [Story], allStoriesIds: [Int]) {
        do {
            let storyIds: [Int] = try await AF.request(apiUrl.appending(path: "beststories.json")).serializingDecodable([Int].self).value
            let stories = try await fetchStories(storyIds, limit: limit)
            
            return (stories, storyIds)
        } catch let error {
            throw error
        }
    }
    
    func fetchStories(_ storyIds: [Int], limit: Int? = nil) async throws -> [Story] {
        return await withTaskGroup(of: Story?.self, body: { group in
            var stories = [Story]()
            
            for storyId in storyIds[0...(limit ?? storyIds.count - 1)] {
                group.addTask {
                    return try? await fetchStory(storyId)
                }
            }
            for await story in group {
                if let story {
                    stories.append(story)
                }
            }
            
            return stories
        })
    }
    
    private func fetchStory(_ storyId: Int) async throws -> Story {
        do {
            let story = try await AF.request(apiUrl.appending(path: "item/\(storyId).json")).serializingDecodable(Story.self).value
            let _ = await Story.UrlMetadata.of(story: story)
            return story
        } catch let error {
            throw error
        }
    }
    
}
