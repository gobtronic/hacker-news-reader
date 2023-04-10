//
//  StoryUrlMetadata.swift
//  hnreader
//
//  Created by gobtronic on 09/04/2023.
//

import Foundation
import LinkPresentation
import UIKit
import UniformTypeIdentifiers

extension Story {
    class UrlMetadata {
        static var cached = [UrlMetadata]()
        
        let storyId: Int
        let url: URL
        var thumbnailFile: URL?
        var iconFile: URL?
        var isLoaded = false
        
        // MARK: - Init
        
        private init?(with story: Story) {
            guard let storyUrl = story.url else {
                return nil
            }
            
            self.storyId = story.id
            self.url = storyUrl
        }
        
        private init(storyId: Int, url: URL, thumbnailFile: URL?, iconFile: URL?) {
            self.storyId = storyId
            self.url = url
            self.thumbnailFile = thumbnailFile
            self.iconFile = iconFile
        }
        
        // MARK: - Fetching
        
        private func fetchThumbnail(withMetadata metadata: LPLinkMetadata) async {
            let _ = metadata.imageProvider?.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier, completionHandler: { url, _ in
                guard let url else {
                    return
                }
                
                let targetUrl = FileManager.default.temporaryDirectory.appendingPathComponent("\(self.storyId)_thumbnail.png", conformingTo: UTType.image)
                guard !FileManager.default.fileExists(atPath: targetUrl.path()) else {
                    self.thumbnailFile = targetUrl
                    return
                }
                do {
                    try FileManager.default.copyItem(at: url, to: targetUrl)
                    self.thumbnailFile = targetUrl
                } catch {}

                return
            })
        }
        
        private func fetchIcon(withMetadata metadata: LPLinkMetadata) async {
            let _ = metadata.iconProvider?.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier, completionHandler: { url, _ in
                guard let url else {
                    return
                }
                
                let targetUrl = FileManager.default.temporaryDirectory.appendingPathComponent("\(self.storyId)_icon.png", conformingTo: UTType.image)
                guard !FileManager.default.fileExists(atPath: targetUrl.path()) else {
                    self.iconFile = targetUrl
                    return
                }
                do {
                    try FileManager.default.copyItem(at: url, to: targetUrl)
                    self.iconFile = targetUrl
                } catch {}

                return
            })
        }
        
        // MARK: - Helper
        
        static func of(story: Story) async -> UrlMetadata? {
            if let cachedUrlMetadata = UrlMetadata.cached.first(where: { $0.storyId == story.id }) {
                return cachedUrlMetadata
            }
            
            guard let metadata = UrlMetadata(with: story) else {
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
        return Story.UrlMetadata(storyId: 0,
                                 url: URL(string: "https://github.com/gobtronic/hacker-news-reader")!,
                                 thumbnailFile: nil,
                                 iconFile: nil)
    }
}
