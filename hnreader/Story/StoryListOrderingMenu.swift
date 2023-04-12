//
//  StoryListOrderingMenu.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SwiftUI

struct StoryListOrderingMenu: View {
    @Binding var storyOrdering: StoryOrdering
    var viewModel: StoryViewModel
    var orderingCases: [StoryOrdering] {
        return StoryOrdering.allCases.filter({ $0 != storyOrdering })
    }
    
    var body: some View {
        Menu {
            ForEach(0..<orderingCases.count, id: \.self) { index in
                Button() {
                    storyOrdering = orderingCases[index]
                    Task {
                        await viewModel.fetch(ordering: storyOrdering)
                    }
                } label: {
                    HStack(alignment: .center) {
                        Text(orderingCases[index].rawValue.capitalized)
                        Image(uiImage: orderingCases[index].icon)
                    }
                }
            }
            .foregroundColor(.red)
        } label: {
            Image(uiImage: storyOrdering.icon)
        }
    }
}
