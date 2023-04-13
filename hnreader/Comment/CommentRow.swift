//
//  CommentRow.swift
//  hnreader
//
//  Created by gobtronic on 12/04/2023.
//

import SwiftUI

struct CommentRow: View {
    let comment: Comment
    
    var body: some View {
        VStack {
            HStack {
                Text(comment.by)
                Text("")
                Spacer()
            }
            .foregroundColor(Color.gray)
            .font(.system(.footnote))
            AttributedText(string: comment.text)
                .padding(.top, 3)
        }
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: Comment.realMocked())
            .padding(20)
    }
}

