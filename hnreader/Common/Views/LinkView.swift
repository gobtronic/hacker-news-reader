//
//  LinkView.swift
//  hnreader
//
//  Created by gobtronic on 09/04/2023.
//

import LinkPresentation
import MobileCoreServices
import SwiftUI
import UniformTypeIdentifiers

struct LinkView: View {
    @State var metadata: Story.UrlMetadata
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let thumbnail = metadata.thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 140)
                    .clipped()
            }
            HStack {
                if let icon = metadata.icon {
                    Image(uiImage: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipped()
                }
                Text(metadata.url.simplifiedString)
                    .foregroundColor(Color(UIColor.darkGray))
            }
            .padding(10)
            .frame(maxWidth: .infinity, minHeight: 40)
            .clipped()
            .background(Color.gray.brightness(0.3))
            
        }
        .cornerRadius(10)
    }

}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(metadata: Story.UrlMetadata.mocked())
            .padding(10)
    }
}
