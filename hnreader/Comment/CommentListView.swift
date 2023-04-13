//
//  CommentListView.swift
//  hnreader
//
//  Created by gobtronic on 12/04/2023.
//

import SwiftUI

struct CommentListView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    @EnvironmentObject private var storyViewModel: StoryViewModel
    let story: Story
    
    var body: some View {
        List {
            Section {
                StoryRow(story: story,
                         commentsButtonEnabled: false)
                    .environmentObject(storyViewModel)
                    .listRowBackground(Color.background)
                    .listRowInsets(EdgeInsets(top: 10,
                                              leading: 20,
                                              bottom: 10,
                                              trailing: 20))
                    .listRowSeparator(.hidden)
            }
            ForEach(commentViewModel.comments) { comment in
                CommentRow(comment: comment)
                    .listRowBackground(Color.background)
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .background(Color.background)
        .onAppear {
            Task {
                await commentViewModel.fetchFor(story)
            }
        }
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommentListView(story: Story.realMocked())
        }
    }
}
