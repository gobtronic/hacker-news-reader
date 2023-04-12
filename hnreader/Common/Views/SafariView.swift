//
//  SafariView.swift
//  hnreader
//
//  Created by gobtronic on 11/04/2023.
//

import SafariServices
import SwiftUI

struct SafariView: View {
    let url: URL

    var body: some View {
        SafariViewRepresentable(url: url)
            .navigationBarHidden(true)
            .ignoresSafeArea()
    }
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://apple.com")!)
    }
}

fileprivate struct SafariViewRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewRepresentable>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewRepresentable>) {
        uiViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension SafariViewRepresentable {
    fileprivate final class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var parent: SafariViewRepresentable
        
        init(_ parent: SafariViewRepresentable) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
