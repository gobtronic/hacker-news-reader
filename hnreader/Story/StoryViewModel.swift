//
//  StoryViewModel.swift
//  hnreader
//
//  Created by gobtronic on 06/04/2023.
//

import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var stories = [Story]()
    @Published private(set) var isLoadingNextPage = false
    @Published var navigationPath = NavigationPath()

    private let storiesPerPage: Int
    private var currentPage = 1
    private var storyIds = [Int]()
    
    // MARK: - Init
    
    init(storiesPerPage: Int) {
        self.storiesPerPage = storiesPerPage
    }
    
    // MARK: - API
    
    @MainActor
    func fetch(ordering: StoryOrdering) async {
        currentPage = 1
        stories = Story.mockedList(nbItems: 10)
        do {
            (stories, storyIds) = try await API.shared.fetchStories(ordering: ordering, limit: storiesPerPage)
        } catch {}
    }
    
    @MainActor
    func loadNextPageIfNeeded(from story: Story) async {
        guard let fromIndex = stories.firstIndex(where: { story.id == $0.id }),
            fromIndex >= currentPage * storiesPerPage - 5 else {
            return
        }
        
        let nextPage = currentPage + 1
        guard storyIds.count >= currentPage * storiesPerPage,
            !isLoadingNextPage else {
            return
        }
        
        isLoadingNextPage = true
        
        let lastStoryIndexToFetch: Int
        if storyIds.count >= nextPage * storiesPerPage {
            lastStoryIndexToFetch = nextPage * storiesPerPage
        } else {
            lastStoryIndexToFetch = storyIds.count
        }
        
        let nextPageStoryIds = Array(storyIds[currentPage * storiesPerPage..<lastStoryIndexToFetch])
        do {
            let stories = try await API.shared.fetchStories(nextPageStoryIds)
            self.stories += stories
            currentPage = nextPage
            isLoadingNextPage = false
        } catch {
            isLoadingNextPage = false
        }
    }
    
    func isLastStoryCurrentlyAvailable(_ story: Story) -> Bool {
        guard let storyIndex = stories.firstIndex(where: { story.id == $0.id }) else {
            return false
        }
        
        return storyIndex == currentPage * storiesPerPage - 1
    }
}
