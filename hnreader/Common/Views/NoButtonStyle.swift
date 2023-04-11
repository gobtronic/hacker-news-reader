//
//  NoButtonStyle.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SwiftUI

struct EmptyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
