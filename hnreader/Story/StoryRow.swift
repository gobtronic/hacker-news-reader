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
    let story: Story
    @State var metadata: Story.UrlMetadata?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(story.title)
            if !story.isMocked, let metadata  {
                LinkView(metadata: metadata)
            }
            StoryAdditionalInfoView(story: story)
        }
        .task {
            guard !story.isMocked else {
                return
            }
            
            metadata = await Story.UrlMetadata.of(story: story)
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRow(story: Story.mocked())
    }
}
