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
            let stories = await withTaskGroup(of: Story?.self, body: { group in
                var stories = [Story]()
                
                for storyId in storyIds[0...(limit ?? storyIds.count)] {
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
            
            return (stories, storyIds)
        } catch let error {
            throw error
        }
    }
    
    private func fetchStory(_ storyId: Int) async throws -> Story {
        do {
            let story = try await AF.request(apiUrl.appending(path: "item/\(storyId).json")).serializingDecodable(Story.self).value
            return story
        } catch let error {
            throw error
        }
    }
    
}
