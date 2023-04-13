//
//  CommentListView.swift
//  hnreader
//
//  Created by gobtronic on 12/04/2023.
//

import SwiftUI

struct CommentListView: View {
    @StateObject private var viewModel = CommentViewModel()
    let story: Story
    
    var body: some View {
        NavigationStack {
            List(viewModel.comments) { comment in
                CommentRow(comment: comment)
                    .listRowBackground(Color.background)
            }
            .navigationTitle("Comments")
            .listStyle(.plain)
            .background(Color.background)
        }
        .onAppear {
            Task {
                await viewModel.fetchFor(story)
            }
        }
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView(story: Story.realMocked())
    }
}
