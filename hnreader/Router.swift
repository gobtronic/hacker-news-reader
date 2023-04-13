//
//  Router.swift
//  hnreader
//
//  Created by gobtronic on 12/04/2023.
//

import SwiftUI

class Router: ObservableObject {
    static var shared = Router()
    @Published var navigationPath = NavigationPath()
    
    enum Path: Hashable {
        case story(Int)
        case storyComments(Int)
    }
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Routing
    
    func push(_ path: Router.Path) {
        navigationPath.append(path)
    }
}
