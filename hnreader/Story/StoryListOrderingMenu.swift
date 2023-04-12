//
//  StoryListOrderingMenu.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SwiftUI

struct StoryListOrderingMenu: View {
    @Binding var storiesOrdering: StoriesOrdering
    var viewModel: StoryViewModel
    var orderingCases: [StoriesOrdering] {
        return StoriesOrdering.allCases.filter({ $0 != storiesOrdering })
    }
    
    var body: some View {
        Menu {
            ForEach(0..<orderingCases.count, id: \.self) { index in
                Button() {
                    storiesOrdering = orderingCases[index]
                    Task {
                        await viewModel.fetch(ordering: storiesOrdering)
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
            Image(uiImage: storiesOrdering.icon)
        }
    }
}
