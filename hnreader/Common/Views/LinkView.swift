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
    var url: URL
    @State private var metadata: LPLinkMetadata?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let metadata = metadata {
                LinkMetadataView(metadata: metadata)
            }
        }
        .onAppear {
            let metadataProvider = LPMetadataProvider()
            metadataProvider.startFetchingMetadata(for: url) { metadata, _ in
                if let metadata = metadata {
                    self.metadata = metadata
                }
            }
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(url: URL(string: "https://github.com/NuPlay/ExpandableText")!)
            .padding(10)
    }
}

fileprivate struct LinkMetadataView: View {
    var metadata: LPLinkMetadata
    @State private var image: UIImage?
    @State private var icon: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 140)
                    .clipped()
            }
            if let url = metadata.url {
                HStack {
                    if let icon {
                        Image(uiImage: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .clipped()
                    }
                    Text(url.simplifiedString)
                        .foregroundColor(Color(UIColor.darkGray))
                }
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 40)
                .clipped()
                .background(Color.gray.brightness(0.3))
            }
            
        }
        .cornerRadius(10)
        /*.overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(.gray, lineWidth: 2)
        )*/
        .onAppear {
            fetchImage()
            fetchIcon()
        }
    }
    
    // MARK: Image providers
    
    private func fetchImage() {
        let _ = metadata.imageProvider?.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
            self.image = image as? UIImage
        })
    }
    
    private func fetchIcon() {
        let _ = metadata.iconProvider?.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
            self.icon = image as? UIImage
        })
    }
}
