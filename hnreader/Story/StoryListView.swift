//
//  StoryListView.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import SwiftUI

struct StoryListView: View {
    @ObservedObject var viewModel = StoryViewModel(storiesPerPage: 30)
    
    var body: some View {
        NavigationView {
            List(viewModel.stories) { story in
                StoryRow(story: story)
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
            .listStyle(.grouped)
            .refreshable {
                Task {
                    await viewModel.fetch()
                }
            }
            .navigationTitle("Top stories")
            .toolbar {
                Button(action: {
                    // TODO: Implement different stories filtering
                }, label: {
                    return Image(systemName: "medal.fill")
                })
            }
        }
        .onAppear {
            Task {
                await viewModel.fetch()
            }
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
