//
//  StoryUrlMetadata.swift
//  hnreader
//
//  Created by gobtronic on 09/04/2023.
//

import Foundation
import LinkPresentation
import UIKit

extension Story {
    class UrlMetadata {
        static var cached = [UrlMetadata]()
        
        let storyId: Int
        let url: URL
        var thumbnail: UIImage?
        var icon: UIImage?
        var isLoaded = false
        
        // MARK: - Init
        
        private init?(with story: Story) {
            guard let storyUrl = story.url else {
                return nil
            }
            
            self.storyId = story.id
            self.url = storyUrl
        }
        
        private init(storyId: Int, url: URL, thumbnail: UIImage?, icon: UIImage?) {
            self.storyId = storyId
            self.url = url
            self.thumbnail = thumbnail
            self.icon = icon
        }
        
        // MARK: - Fetching
        
        private func fetchThumbnail(withMetadata metadata: LPLinkMetadata) async {
            let _ = metadata.imageProvider?.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
                self.thumbnail = image as? UIImage
                return
            })
        }
        
        private func fetchIcon(withMetadata metadata: LPLinkMetadata) async {
            let _ = metadata.iconProvider?.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
                self.icon = image as? UIImage
                return
            })
        }
        
        // MARK: - Helper
        
        static func of(story: Story) async -> UrlMetadata? {
            if let cachedUrlMetadata = UrlMetadata.cached.first(where: { $0.storyId == story.id }) {
                return cachedUrlMetadata
            }
            
            guard var metadata = UrlMetadata(with: story) else {
                return nil
            }
            
            if metadata.isLoaded {
                return metadata
            }
            
            let metadataProvider = LPMetadataProvider()
            do {
                let linkMetadata = try await metadataProvider.startFetchingMetadata(for: metadata.url)
                await metadata.fetchThumbnail(withMetadata: linkMetadata)
                await metadata.fetchIcon(withMetadata: linkMetadata)
                metadata.isLoaded = true
                cached.append(metadata)
                return metadata
            } catch {
                metadata.isLoaded = true
                cached.append(metadata)
                return metadata
            }
        }
    }
}

extension Story.UrlMetadata {
    static func mocked() -> Story.UrlMetadata {
        return Story.UrlMetadata(storyId: 0, url: URL(string: "https://github.com/gobtronic/hacker-news-reader")!, thumbnail: nil, icon: nil)
    }
}
