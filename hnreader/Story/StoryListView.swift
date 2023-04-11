//
//  StoryListView.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import SwiftUI

struct StoryListView: View {
    @StateObject var viewModel = StoryViewModel(storiesPerPage: 30)
    @State var storiesOrdering = StoriesOrdering.top
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List(viewModel.stories) { story in
                Button {
                    path.append(story.id)
                } label: {
                    StoryRow(story: story)
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
                        .listRowSeparator(.hidden)
                    StoryRow(story: Story.mocked())
                        .redacted(reason: .placeholder)
                }
            }
            .navigationTitle("\(storiesOrdering.rawValue.capitalized) stories")
            .navigationDestination(for: Int.self) { storyId in
                if let storyUrl = viewModel.stories.first(where: { $0.id == storyId })?.url {
                    SafariView(url: storyUrl)
                }
            }
            .listStyle(.plain)
            .refreshable {
                Task {
                    await viewModel.fetch(ordering: storiesOrdering)
                }
            }
            .toolbar {
                ToolbarItem {
                    StoryListOrderingMenu(storiesOrdering: $storiesOrdering,
                                           viewModel: viewModel)
                }
            }
            .background(Color.background)
        }
        .onAppear {
            Task {
                await viewModel.fetch(ordering: storiesOrdering)
            }
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}

struct StoryListOrderingMenu: View {
    @Binding var storiesOrdering: StoriesOrdering
    var viewModel: StoryViewModel
    
    var body: some View {
        Menu {
            ForEach(0..<StoriesOrdering.allCases.count, id: \.self) { index in
                Button(role: StoriesOrdering.allCases[index] == storiesOrdering ? .destructive : .none) {
                    storiesOrdering = StoriesOrdering.allCases[index]
                    Task {
                        await viewModel.fetch(ordering: storiesOrdering)
                    }
                } label: {
                    HStack(alignment: .center) {
                        Text(StoriesOrdering.allCases[index].rawValue.capitalized)
                        Image(uiImage: StoriesOrdering.allCases[index].icon)
                    }
                }
            }
            .foregroundColor(.red)
        } label: {
            Image(uiImage: storiesOrdering.icon)
        }
    }
}
