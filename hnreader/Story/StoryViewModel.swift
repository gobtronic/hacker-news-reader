//
//  StoryViewModel.swift
//  hnreader
//
//  Created by gobtronic on 06/04/2023.
//

import Foundation

class StoryViewModel: ObservableObject {
    @Published var stories = [Story]()
    private var storiesIdentifiers = [Int]()
    
    @MainActor
    func fetch(limit: Int? = nil) async {
        stories = Story.mockedList(nbItems: 10)
        do {
            (stories, storiesIdentifiers) = try await API.shared.fetchTopStories(limit: limit)
        } catch {}
    }
}
