//
//  StoriesOrdering.swift
//  hnreader
//
//  Created by gobtronic on 10/04/2023.
//

import Foundation
import SwiftUI

enum StoriesOrdering: String, CaseIterable {
    case top
    case best
    case new
}

extension StoriesOrdering {
    var apiPath: String {
        switch self {
        case .top:
            return "topstories.json"
        case .best:
            return "beststories.json"
        case .new:
            return "newstories.json"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .top:
            return UIImage(systemName: "chart.line.uptrend.xyaxis")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .best:
            return UIImage(systemName: "medal.fill")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        case .new:
            return UIImage(systemName: "clock.fill")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
        }
    }
}
