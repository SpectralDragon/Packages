//
//  DocumentBrowser.swift
//  Packages
//
//  Created by Vladislav Prusakov on 16.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import SwiftUI

struct DocumentBrowser: UIViewControllerRepresentable {
    
    var selectedDocument: (PlaygroundDocument) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentBrowser>) -> UIDocumentBrowserViewController {
        let vc = UIDocumentBrowserViewController()
        vc.delegate = context.coordinator
        vc.allowsDocumentCreation = false
        vc.allowsPickingMultipleItems = false
        vc.shouldShowFileExtensions = true
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentBrowserViewController, context: UIViewControllerRepresentableContext<DocumentBrowser>) {
        
    }
    
    func makeCoordinator() -> DocumentBrowser.Coordinator {
        return Coordinator(selectedDocument: self.selectedDocument)
    }
    
    class Coordinator: NSObject, UIDocumentBrowserViewControllerDelegate {
        
        var selectedDocument: (PlaygroundDocument) -> Void
        
        init(selectedDocument: @escaping (PlaygroundDocument) -> Void) {
            self.selectedDocument = selectedDocument
        }
        
        func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
            guard let documentURL = documentURLs.first else { return }
            self.selectedDocument(PlaygroundDocument(fileURL: documentURL))
        }
        
        func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
            
        }
        
    }
    
}
