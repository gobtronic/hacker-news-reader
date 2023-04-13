//
//  CommentViewModel.swift
//  hnreader
//
//  Created by gobtronic on 12/04/2023.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments = [Comment]()
    
    func fetchFor(_ story: Story) async {
        comments = await API.shared.fetchCommentsFor(story)
    }
}
