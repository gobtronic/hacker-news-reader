//
//  UINavigationControllerExtension.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // This line prevents the swipe back gesture to be disabled when pushing a View with `.navigationBarHidden(true)`
        interactivePopGestureRecognizer?.delegate = nil
    }
}
