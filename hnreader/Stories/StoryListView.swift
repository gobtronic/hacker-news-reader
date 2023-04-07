//
//  StoryListView.swift
//  hnreader
//
//  Created by gobtronic on 04/04/2023.
//

import SkeletonUI
import SwiftUI

struct StoryListView: View {
    @ObservedObject var viewModel = StoryViewModel()
    @State var animateList = false
    
    var body: some View {
        NavigationView {
            List(viewModel.stories) { story in
                StoryRow(story: story)
                    .redacted(reason: story.isMocked ? .placeholder : [])
            }
            .animation(.default, value: animateList)
            .refreshable {
                Task {
                    animateList = true
                    await viewModel.fetch(limit: 30)
                    animateList = false
                }
            }
            .navigationTitle("Top stories")
        }
        .onAppear {
            Task {
                animateList = true
                await viewModel.fetch(limit: 30)
                animateList = false
            }
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
