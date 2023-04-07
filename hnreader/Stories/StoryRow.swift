//
//  StoryRow.swift
//  hnreader
//
//  Created by gobtronic on 06/04/2023.
//

import SwiftUI

struct StoryRow: View {
    let story: Story?
    
    var body: some View {
        HStack {
            Text(story?.title)
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRow(story: Story.mocked())
    }
}
