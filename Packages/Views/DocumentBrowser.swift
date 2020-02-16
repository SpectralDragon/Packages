//
//  DocumentBrowser.swift
//  Packages
//
//  Created by Vladislav Prusakov on 16.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import SwiftUI

struct DocumentBrowser: UIViewControllerRepresentable {
    
    @Binding var selectedDocument: PlaygroundDocument?
    
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
        return Coordinator(selectedDocument: self.$selectedDocument)
    }
    
    class Coordinator: NSObject, UIDocumentBrowserViewControllerDelegate {
        
        @Binding var selectedDocument: PlaygroundDocument?
        
        init(selectedDocument: Binding<PlaygroundDocument?>) {
            self._selectedDocument = selectedDocument
        }
        
        func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
            guard let documentURL = documentURLs.first else { return }
            self.selectedDocument = PlaygroundDocument(fileURL: documentURL)
        }
        
    }
    
}

class PlaygroundDocument: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let root = contents as? FileWrapper else { return }
    }
}
