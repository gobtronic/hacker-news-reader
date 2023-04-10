//
//  LoadingRow.swift
//  hnreader
//
//  Created by gobtronic on 10/04/2023.
//

import SwiftUI

struct LoadingRow: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }
}

struct LoadingRow_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRow()
    }
}
