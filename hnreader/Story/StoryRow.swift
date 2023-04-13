//
//  StoryRow.swift
//  hnreader
//
//  Created by gobtronic on 06/04/2023.
//

import Foundation
import LinkPresentation
import SwiftUI

struct StoryRow: View {
    @EnvironmentObject var viewModel: StoryViewModel
    let story: Story
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(story.title)
                if story.type == .job {
                    Spacer()
                    Image(systemName: "case.fill")
                        .padding(8)
                        .foregroundColor(.accentColor)
                        .background(Color.foreground)
                        .containerShape(Circle())
                }
            }
            if !story.isMocked, let metadata = story.cachedUrlMetadata() {
                LinkView(metadata: metadata)
            }
            StoryAdditionalInfoView(story: story)
                .padding([.top], 5)
                .environmentObject(viewModel)
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRow(story: Story.realMocked())
            .padding(20)
    }
}
