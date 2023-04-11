//
//  StoryAdditionalInfoView.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SwiftUI

struct StoryAdditionalInfoView: View {
    var story: Story
    
    var body: some View {
        HStack {
            Text("\(story.score) points by \(story.by)")
                .foregroundColor(Color.gray)
                .font(Font.system(.footnote))
                .lineLimit(1)
        }
    }
}

struct StoryAdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAdditionalInfoView(story: Story.mocked())
    }
}
