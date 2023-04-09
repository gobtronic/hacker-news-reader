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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(story.title)
            if let url = story.url, !story.isMocked {
                LinkView(url: url)
            }
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRow(story: Story.mocked())
    }
}
