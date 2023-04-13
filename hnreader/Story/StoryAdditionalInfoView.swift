//
//  StoryAdditionalInfoView.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SwiftUI

struct StoryAdditionalInfoView: View {
    @EnvironmentObject var viewModel: StoryViewModel
    var story: Story
    let commentsButtonEnabled: Bool

    var body: some View {
        HStack {
            Text("\(story.score) points by \(story.by)")
                .foregroundColor(Color.gray)
                .lineLimit(1)
            Spacer()
            Button("\(story.descendants) comments") {
                viewModel.navigationPath.append(.storyComments(story.id))
            }
            .disabled(!commentsButtonEnabled)
            .buttonStyle(BorderedButtonStyle())
        }
        .font(Font.system(.footnote).bold())
    }
}

struct StoryAdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAdditionalInfoView(story: Story.realMocked(),
                                commentsButtonEnabled: true)
            .padding(20)
    }
}
