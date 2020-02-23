//
//  PlaygroundDocument.swift
//  Packages
//
//  Created by Vladislav Prusakov on 23.02.2020.
//  Copyright © 2020 LiteCode. All rights reserved.
//

import UIKit

class PlaygroundDocument: UIDocument {
    
    var modules: [String] = []
    let title: String
    
    private var contents: FileWrapper!
    private var userEdits: UserEdits!
    
    override init(fileURL url: URL) {
        self.title = url.deletingPathExtension().lastPathComponent
        super.init(fileURL: url)
    }
    
    override func contents(forType typeName: String) throws -> Any {
        let root = FileWrapper()
        root.addFileWrapper(self.contents)
        
        let edits = FileWrapper()
        return root
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let root = contents as? FileWrapper else { return }
        
        self.contents = root.fileWrappers?["Contents"]
        let contentsDir = root.fileWrappers?["Edits"]
        guard let userEdits = contentsDir?.fileWrappers?["UserEdits.diffpack"] else {
            throw DocumentError.notFoundFileWrapper(name: "UserEdits.diffpack")
        }
        
        self.userEdits = try UserEdits(contents: userEdits)
        
        let modulesDir = userEdits.fileWrappers?["UserModules"]
        let modules = modulesDir?.fileWrappers?.keys.map { $0 } ?? []
        self.modules = modules
    }
}

struct UserEdits {
    var manifest: FileWrapper
    var chapters: FileWrapper
    
    init(contents: FileWrapper) throws {
        guard let manifest = contents.fileWrappers?["Manifest.plist"] else {
            throw DocumentError.notFoundFileWrapper(name: "Manifest.plist")
        }
        
        guard let chapters = contents.fileWrappers?["Chapters"] else {
            throw DocumentError.notFoundFileWrapper(name: "Chapters")
        }
        
        self.chapters = chapters
        self.manifest = manifest
    }
}

fileprivate enum DocumentError: LocalizedError {
    case notFoundFileWrapper(name: String)
}
