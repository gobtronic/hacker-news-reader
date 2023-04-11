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
    
    var body: some View {
        NavigationStack {
            List(viewModel.stories) { story in
                NavigationLink(destination: SafariView(url: story.url!)) {
                    StoryRow(story: story)
                }
                .redacted(reason: story.isMocked ? .placeholder : [])
                .onAppear {
                    Task {
                        await viewModel.loadNextPageIfNeeded(from: story)
                    }
                }
                if viewModel.isLoadingNextPage && viewModel.isLastStoryCurrentlyAvailable(story) {
                    LoadingRow()
                        .listRowSeparator(.hidden)
                    StoryRow(story: Story.mocked())
                        .redacted(reason: .placeholder)
                }
            }
            .navigationTitle("\(storiesOrdering.rawValue.capitalized) stories")
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
                Button(role: StoriesOrdering.allCases[index] == storiesOrdering ? .destructive : .none, action: {
                    storiesOrdering = StoriesOrdering.allCases[index]
                    Task {
                        await viewModel.fetch(ordering: storiesOrdering)
                    }
                }, label: {
                    HStack(alignment: .center) {
                        Text(StoriesOrdering.allCases[index].rawValue.capitalized)
                        Image(uiImage: StoriesOrdering.allCases[index].icon)
                    }
                })
            }
            .foregroundColor(.red)
        } label: {
            Image(uiImage: storiesOrdering.icon)
        }
    }
}
