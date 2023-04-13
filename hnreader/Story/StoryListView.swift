//
//  StoryListView.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import SwiftUI

struct StoryListView: View {
    @StateObject var viewModel = StoryViewModel(storiesPerPage: 30)
    @State var storyOrdering = StoryOrdering.top

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List(viewModel.stories) { story in
                Button {
                    viewModel.navigationPath.append(.story(story.id))
                } label: {
                    StoryRow(story: story)
                        .environmentObject(viewModel)
                }
                .buttonStyle(PlainButtonStyle())
                .redacted(reason: story.isMocked ? .placeholder : [])
                .onAppear {
                    Task {
                        await viewModel.loadNextPageIfNeeded(from: story)
                    }
                }
                .listRowBackground(Color.background)
                
                if viewModel.isLoadingNextPage && viewModel.isLastStoryCurrentlyAvailable(story) {
                    LoadingRow()
                        .listRowBackground(Color.background)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("\(storyOrdering.rawValue.capitalized) stories")
            .navigationDestination(for: StoryViewModel.Path.self) { path in
                switch path {
                case .story(let id):
                    if let storyUrl = viewModel.stories.first(where: { $0.id == id })?.url {
                        SafariView(url: storyUrl)
                    }
                case .storyComments(let id):
                    if let story = viewModel.stories.first(where: { $0.id == id }) {
                        CommentListView(story: story)
                    }
                }
                
            }
            .listStyle(.plain)
            .refreshable {
                Task {
                    await viewModel.fetch(ordering: storyOrdering)
                }
            }
            .toolbar {
                ToolbarItem {
                    StoryListOrderingMenu(storyOrdering: $storyOrdering,
                                           viewModel: viewModel)
                }
            }
            .background(Color.background)
        }
        .onAppear {
            Task {
                await viewModel.fetch(ordering: storyOrdering)
            }
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
